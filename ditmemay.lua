local lplr = game.Players.LocalPlayer

WalkTween = function(Root, Target, Speed)
    local Dist = (Root.Position - Target.p).magnitude
    local Tween = game:GetService("TweenService"):Create(Root, TweenInfo.new(Dist / Speed, Enum.EasingStyle.Linear), { CFrame = Target})
    Tween:Play()
    Tween = 
    Tween.Completed:wait()
    Root.Velocity = Vector3.zero
end

return WalkTween

end