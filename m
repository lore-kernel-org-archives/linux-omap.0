Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EEE1E9919;
	Tue,  8 Sep 2026 00:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788827470; cv=none; b=cueqawQcXHEwJ1gMztihiI7uB2eBZ53SvS2gxqUHqFSXShB9X45zoOsHNbIf+uCpZK69GGOifdvgxRJ1W4z1+keJdQyRprbzU086PJfV3excMjLmGeQEg0tjPc7sMSXUSANyPX1kBJkhQ+GFsKraiE4cQpFStgkfHNOQmR5zbgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788827470; c=relaxed/simple;
	bh=3elVu73JVCNVQ45mmZkedKeCq4Wm6TJSv1pkF7XlsJo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=r2m+KOE/tOHIclUW6FMMg3LWrHwxLhPg7DxpVzM4ru5wORuSVYxEZ5sccQUcAv4cwTZihpoCuR0xAieizNoHTRumwu7ks6nYwcwTycnzzWRy6hLi/qgyj5ILoVBFIkn9C6djLle5BiYu81s6ta1sJF3JHeKEbfuJ6SV7UAPtmts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UBumuRHJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UBumuRHJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A13201F00A3D;
	Tue,  8 Sep 2026 00:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788827469;
	bh=zj4uIOsknu4mFc4QWbb5E+NrNKepcztoMg49+nbVDJ4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=UBumuRHJQM2idU/918ra5oUlcyif69v96nSip7JQXqFeFnwD0iQu4XjxeARHAsHau
	 DMowL1/bMmPBedyr4Y0RUUzS43bBdiBAzUyd+lDRL6ZXCDg8Ih6dmUZ4YoegSS2yf5
	 Ya4eQTLZ5cT5tjvhqanWOI6I8Ai2/cKTU2KlrZZoJkRuPuLEY2H0H/h4Kp+42zg305
	 rZBimavGb0A10sXvmkejvLDpAK+CIxUmvjg1mcMeh/JDXZsy7vWWelVQSpYeHrvoL2
	 d5Xm2N3Jiavz9mM1GxixxERbnCd9Nowrhn6g7ZmdpJD0py4e65PKSRz9+vPhpPzekm
	 VbtHHk/vjJMMA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0D4339E8A5B;
	Tue,  8 Sep 2026 00:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: ethernet: ti: davinci_mdio: Drop commas after match
 table sentinels
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178882740838.3220068.8746690241801565022.git-patchwork-notify@kernel.org>
Date: Tue, 08 Sep 2026 00:30:08 +0000
References: 
 <e481b6de46cecc6ea604ae165272c667274cc621.1788437140.git.geert+renesas@glider.be>
In-Reply-To: 
 <e481b6de46cecc6ea604ae165272c667274cc621.1788437140.git.geert+renesas@glider.be>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: s-vadapalli@ti.com, rogerq@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-omap@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  3 Sep 2026 14:06:47 +0200 you wrote:
> It does not make sense to have a comma after a sentinel, as any new
> elements must be added before the sentinel.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/net/ethernet/ti/davinci_mdio.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - net: ethernet: ti: davinci_mdio: Drop commas after match table sentinels
    https://git.kernel.org/netdev/net-next/c/615bcbb822cb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


