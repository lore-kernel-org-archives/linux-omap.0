Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9698E23395B;
	Sat,  6 Jun 2026 00:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780706409; cv=none; b=O1rWNQKoChj9NbB/ckT5WKYyRiXjgLQom8VX1qZo/4lM1bo3Y9n2KzL9ist5sLfEddJxuq4YoDEur0XWx+YufMZhRE8No05GzPZY3pD/xDbFFsvIr51wsZKwkzc+Q/wD/XdUOtuKBvgnyZ6H9UvRn+xl0s9uH3opx5+MaWFz8Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780706409; c=relaxed/simple;
	bh=Md+NCMU4DyuWYZ9EOMm5A/RgCz2ljI7cHiN59vuGKjs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VEW1TeNp64v/QnQAkIwgSdT3cEIpMF3RR/kXhHpnvWu1u7A97hFdc+kiXjSOg2LkoTOLpOMhfx8lvGJhUqKhlR0oDwbKwTMgvQQanuO/NwCaV/uBoyRE4OPo37nR18FUuLMCuvTTg7q0cEsq3RPpvpTvsAJXpmryHY2RCDWxo74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=chr7q/M8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="chr7q/M8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F1D61F00898;
	Sat,  6 Jun 2026 00:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780706408;
	bh=9bd+o5r6wGbxt9K0vgor2ZhlH1hGt/3yn9lOse8aatA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=chr7q/M8pKpdZnFFg1AdLVac/LM/TUive45eoMaIhF3p2MG303KBHO34njFSKYZlR
	 DtkePE0uCTYji8H1j03bpISeHORzYmS0WEUrNqbP8rrlSeXfwkBGKNLUt/8zeCr3IW
	 Qak1MvWXiReu9AHxRsGPDc/jrjLmKC/bdXSf0faM3WxN34P0SHEJnKRceCxSXVVDmx
	 CbnAPfa2acggy/ZDW/zVmUDn8NB5fhYE/no2EbxfXS/sHzTlNQhTCWL+GFNsL3MT9K
	 Nk27Kc3PjCK/wunT0gQeppR5xInz0MzC0pucIi3CRdUM9QhhJwmFanvQImCS9JYWEQ
	 BMpNMu4jFVa5A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09C43930C06;
	Sat,  6 Jun 2026 00:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: cpsw_new: unregister devlink on port
 registration failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178070640839.3971808.12083704478751748156.git-patchwork-notify@kernel.org>
Date: Sat, 06 Jun 2026 00:40:08 +0000
References: <20260604043115.1409134-1-lgs201920130244@gmail.com>
In-Reply-To: <20260604043115.1409134-1-lgs201920130244@gmail.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: s-vadapalli@ti.com, rogerq@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 alexander.sverdlin@gmail.com, haokexin@gmail.com,
 aleksandr.loktionov@intel.com, daniel.zahka@gmail.com,
 linux-omap@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, alexander.sverdlin@siemens.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  4 Jun 2026 12:31:15 +0800 you wrote:
> cpsw_probe() registers devlink before registering the CPSW ports.
> 
> If cpsw_register_ports() fails, the error path only unregisters the
> notifiers and then releases the lower level resources. It does not undo
> the successful cpsw_register_devlink() call, leaving the devlink instance
> and its parameters registered after probe has failed.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: cpsw_new: unregister devlink on port registration failure
    https://git.kernel.org/netdev/net-next/c/b64f763b6074

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


