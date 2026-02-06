Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723392E5B05;
	Fri,  6 Feb 2026 03:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770347413; cv=none; b=QmRenaEv1W8tG//lxsLwTVB0GwQfzfh0NIH/1FVaLmchv1ydC0So3d4YGilKuZHFUjewb5xiLrywCAYmtEFCmHbwaLtFjPN/4YTjmLGyxt12zhWh+nOdYR4VJAs9Bd9Vh9Yv2YubfeP5nnhR8mh4qR/WepEnX5HvsfYq95f6FTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770347413; c=relaxed/simple;
	bh=/eLo0XeI1iEAxXm9gSsI46aen8LeyLruZ5g9DaJuHxo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=deZWJi8UyoHeyi2zLfJetwvoBWIJfG9dHoeTRtwOZj9/XT2t2acO88YIcsFbzXBb5Ae8quhd1x1Pa9aozNmcHafuJQRmdP/zR29WCKXXkT3nQIMf6ORJz3WnNQqc9IweQqYQEPWI53oeXilbhY9sRP97EClAY8Vmj3zeE1UmsVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GsXZpNWm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GsXZpNWm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 051F3C4CEF7;
	Fri,  6 Feb 2026 03:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770347413;
	bh=/eLo0XeI1iEAxXm9gSsI46aen8LeyLruZ5g9DaJuHxo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GsXZpNWmln+YMO60LcCtZhaT3phXq5paeFQEHG5aHGWc9PaVt7jBmQVWjxw2YxtSg
	 m+VwLBnIRBl/N7ZtFFVjDoM9QwpmTv+8EYGRwpSk+MKJR8doprIPj6jSNVekom+I3+
	 GcHIOdeu18lgyAvLkqALU38aiziXDGGVeHt5I/ya1KGBzBD0g7oPSpeHiDj6V6Ywxo
	 IrTyoaLv/gy9l2iAKhFG/FjZ+t41mBCtcLzFRDVBcU0KTNA7Elq8c5syL7HF79iKu9
	 5Pna1CqKngKXRxVPLk9nmCyeU7byJXF2ecPHBe4M+AWotMySwnl+cId2UfFdFHfHHa
	 d6AlSOhfUvemw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C223B3808200;
	Fri,  6 Feb 2026 03:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] net: cpsw_new: Fix multiple issues in the
 cpsw_probe() error path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177034741058.664781.7836575985509758726.git-patchwork-notify@kernel.org>
Date: Fri, 06 Feb 2026 03:10:10 +0000
References: <20260205-cpsw-error-path-v1-0-6e58bae6b299@gmail.com>
In-Reply-To: <20260205-cpsw-error-path-v1-0-6e58bae6b299@gmail.com>
To: Kevin Hao <haokexin@gmail.com>
Cc: netdev@vger.kernel.org, s-vadapalli@ti.com, rogerq@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, vladimir.oltean@nxp.com,
 saeedm@nvidia.com, daniel.zahka@gmail.com, lorenzo@kernel.org,
 alexander.sverdlin@gmail.com, nicolas.dichtel@6wind.com, m-karicheri2@ti.com,
 ilias.apalodimas@linaro.org, grygorii.strashko@ti.com,
 linux-omap@vger.kernel.org, stable@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 05 Feb 2026 10:47:01 +0800 you wrote:
> These two patches address duplicate or unnecessary netdev unregistration
> in the cpsw_probe() error handling path.
> 
> ---
> Cc: Siddharth Vadapalli <s-vadapalli@ti.com>
> Cc: Roger Quadros <rogerq@kernel.org>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
> Cc: Saeed Mahameed <saeedm@nvidia.com>
> Cc: Daniel Zahka <daniel.zahka@gmail.com>
> Cc: Lorenzo Bianconi <lorenzo@kernel.org>
> Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> Cc: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> Cc: Murali Karicheri <m-karicheri2@ti.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> Cc: linux-omap@vger.kernel.org
> Cc: stable@vger.kernel.org
> 
> [...]

Here is the summary with links:
  - [net,1/2] net: cpsw_new: Fix unnecessary netdev unregistration in cpsw_probe() error path
    https://git.kernel.org/netdev/net/c/62db84b7efa6
  - [net,2/2] net: cpsw_new: Fix potential unregister of netdev that has not been registered yet
    https://git.kernel.org/netdev/net/c/9d724b34fbe1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


