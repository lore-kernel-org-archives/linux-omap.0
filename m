Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5075F338593;
	Fri, 27 Feb 2026 03:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772164205; cv=none; b=cMndwgQkfQIH0krDxsXm+UGHA3j2UKdpMUYXMKweRVihIIhKSZhf3CyDSrW27RbVLJuCsuKpPFJZkc64Az5fonFn+k7ch32aJphOElQ2LU21fLJ6NnOYflQhvZlGRFYf1QOtFd79M+YuHswVqbIyPwYVOtmAxeUsG9UXvAmWeV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772164205; c=relaxed/simple;
	bh=wGOpa4OZpBp2+ifd2LLQ47BHdaBBUT7v3LLaRe9nyWQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VuKHLF/a9J+8e2ckMSbR9139MaRYi9KF8zxOsg4bdQFPFJvbVXisAXuRd6I5lmNFKPp2oR1spnjDgOQOxjCBuEEVop29RjsumLsk+SCF6midk/z6Q4sWfCYIT8BMpW5HO0bfolHYBs5rZV4oO8Iy6AS1KK+/ojsEmsds5KQ7z8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YfWUMPja; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YfWUMPja"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D0AAC19421;
	Fri, 27 Feb 2026 03:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772164205;
	bh=wGOpa4OZpBp2+ifd2LLQ47BHdaBBUT7v3LLaRe9nyWQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YfWUMPja4/+C3H1N6kxixBZfCrhO1lzVRcwb2+4+kzCANP4nAC9ysgOnXMHNzpyHH
	 ztmyGg8v+Hug+HyuXh9PNuzZN+4Jc8+Upjfhjtome7FAYibxmF+YpaWwqM9yUceIAK
	 UukZYzcjnUxKim0+aqg+BYzh6JYlbOIYDeVu1newavyTCjgug+jLgQ+OwB+ZTGU2fI
	 LKtZGvCzbPsHIxfW49DqRhip89q6UedCs5xX+pbT3vwZ9U6FUzXoMekknzxA8M6Au5
	 yzZLZubW2kfzyx7cZCvwrqJmW4N1jaQ67fv0yBrSJ2CilbVYepJn1s85PxVd0wsB6Y
	 75zBBX8JGkF/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D035393109B;
	Fri, 27 Feb 2026 03:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: ethernet: ti: am65-cpsw-nuss/cpsw-ale: Fix
 multicast entry handling in ALE table
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177216420905.1962692.4647985394308297951.git-patchwork-notify@kernel.org>
Date: Fri, 27 Feb 2026 03:50:09 +0000
References: <20260224181359.2055322-1-c-vankar@ti.com>
In-Reply-To: <20260224181359.2055322-1-c-vankar@ti.com>
To: Chintan Vankar <c-vankar@ti.com>
Cc: mugunthanvnm@ti.com, richardcochran@gmail.com, stefan.wiehler@nokia.com,
 tglx@kernel.org, mingo@kernel.org, v-singh1@ti.com, vigneshr@ti.com,
 matthias.schiffer@ew.tq-group.com, vadim.fedorenko@linux.dev, nm@ti.com,
 mwalle@kernel.org, horms@kernel.org, rogerq@kernel.org, s-vadapalli@ti.com,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 andrew+netdev@lunn.ch, linux-omap@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 24 Feb 2026 23:43:59 +0530 you wrote:
> In the current implementation, flushing multicast entries in MAC mode
> incorrectly deletes entries for all ports instead of only the target port,
> disrupting multicast traffic on other ports. The cause is adding multicast
> entries by setting only host port bit, and not setting the MAC port bits.
> 
> Fix this by setting the MAC port's bit in the port mask while adding the
> multicast entry. Also fix the flush logic to preserve the host port bit
> during removal of MAC port and free ALE entries when mask contains only
> host port.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: ethernet: ti: am65-cpsw-nuss/cpsw-ale: Fix multicast entry handling in ALE table
    https://git.kernel.org/netdev/net/c/be11a537224d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


