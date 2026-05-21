Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D1A39FD4;
	Thu, 21 May 2026 00:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779322214; cv=none; b=UPZ9hsWcadtO8IFob39PnZfBrRJeYy5HJ86h2Rjmw8ObDDxdpS9Dub2MZq3IpQ6+5Up3e4Q4/Wjt3Bt25UPQjY/kW4maqYKWAd7tugHvWcyvJGDP0R0vNO6b8WRa9ZyFCFo3z9HT8BmTlCZp5UdwOtrC2KdusFwtl9NIGIMp614=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779322214; c=relaxed/simple;
	bh=gsUjl05l8jjVC6ZnSk68gW0X2gVZeUaR1ZqPKSHkP6E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Q1WywUKEKh4f8o1ZUbYSR2YUeWHclz9SKIIeCD8qKzSZbapNaUd14NWTo4r7sBJ/gRkKvWBOWh1JraX2HrRpD29UTEoJ4ajXzUaKymzEl9YhuBKjf25B+ldEAGeCw7ZmqIuc/b2hHwEZvKF96g7/sF+x8MklxT5dXDX+VKSFt8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GqcyDfqh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GqcyDfqh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F8851F00A3B;
	Thu, 21 May 2026 00:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779322213;
	bh=BUlfBYk6RwXSzfXr+JYfeRkpr1zoOI+S9jP3ra3LQ9A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=GqcyDfqhjTTOZT0LmXkpk79/gb+AM5+vxGvnjdqpBiKGqwNTGHhWFgDvAJkHcfEmT
	 l8EvUxp40DThD3QCnqEKfDn/5UsNKJ+7t1c8aL5hwSpnKecGF4xuHHvp6fEo8sz4a8
	 l5QSHTuDVRUqQGUiIiREECBfktji+BQJ9yikdA+nqKl+YqOylsZ/WvpqPtlrPR5qMh
	 bkZiVHSlWo92kWKmD4RNHmnsRLdqu/HVsENS/8VqM6Pkl2HEZNgxCpMU/y1gj4aRIM
	 9s7Wy2xk2EAKECNXePJaVFYCOl7dscCrxqGjC/Bm+EIWp8WAonCWd7r4WXHiDXZtyK
	 zujW5AhqvBTtA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0BC03930C25;
	Thu, 21 May 2026 00:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] net: ethernet: ti: am65-cpsw-nuss: remove dead vid
 check
 in slave_add_vid()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177932222338.3804120.13663409771850853061.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 00:10:23 +0000
References: <20260517220757.2679458-1-oss@vassilevski.com>
In-Reply-To: <20260517220757.2679458-1-oss@vassilevski.com>
To: Alexander Vassilevski <oss@vassilevski.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, s-vadapalli@ti.com, rogerq@kernel.org,
 dan.carpenter@linaro.org, c-vankar@ti.com, christophe.jaillet@wanadoo.fr,
 netdev@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 17 May 2026 15:07:57 -0700 you wrote:
> am65_cpsw_nuss_ndo_slave_add_vid() returns early at the top with:
> 
>      if (!netif_running(ndev) || !vid)
>          return 0;
> 
> so vid is guaranteed to be non-zero in the rest of the function. The
> subsequent
> 
> [...]

Here is the summary with links:
  - [v3] net: ethernet: ti: am65-cpsw-nuss: remove dead vid check in slave_add_vid()
    https://git.kernel.org/netdev/net-next/c/2e68f49bda78

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


