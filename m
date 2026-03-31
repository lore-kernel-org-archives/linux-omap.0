Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F03228150F;
	Tue, 31 Mar 2026 22:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774997588; cv=none; b=hRLGsa+Hf2R/9C9/BJiMJbNjSrpVw8mLr4OvYUTR3u9UtXUUM3XCQ79yDHLMSSi93jSs0zUGKOAShs/As0eAC5fkOIk4tkJzxxXMbuFR83+34bpNZ0pT0/kI3h5qYBhIFeo1D2haijaF70bpqODOx4JBpxmVsAJv/b3b2Rbu8hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774997588; c=relaxed/simple;
	bh=X9VOd9+kkM/vYEowoKqlVP7HKcz6eLyZuuUgMwZ6Bh0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ChYPNzDTqMvgkO6zreIEG52VVI6IO8cUjrvmIscLZJ3dByyOb08f4EVqkSWPAKRqBQkCrrsJ9a7TWX50H8grYlaeUGYeLAbooqseWIpYnPuayibmutBnYDZpFY9TBVu8V56t+23lkDLB+xR1scwgVRXD+KmAnqPHXT+bTgEnyCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jH0sImLn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jH0sImLn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA1C1C19423;
	Tue, 31 Mar 2026 22:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774997587;
	bh=X9VOd9+kkM/vYEowoKqlVP7HKcz6eLyZuuUgMwZ6Bh0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jH0sImLnUuPGaj0vA3CvAQKP9gQbr8jJeI+tl05o135oTQhwrwjdpsTk9FfI2ORJJ
	 nXGWxm5QV1d+g/T5G6TVkaNNvEJoerMdehUPWjbRgQWO/ZGsk1GMPcLr/0SGSZQ+6M
	 saUaSpccRzQWgSVlEFZ7N81ScHJ0O/tryuj6nOrVJQaSSJk0b/3Aa/OFVxhw99AHkR
	 YA1tKUn4U9b3nTUrfkheshKkWP5/v5EqdyvZK8iY8zaZXZpcr4BO0nUZ61IeAlbegD
	 tH8gJtMVX6mdIlealFBGc+ZRqgpsMwRRR83EyeQnAIlykcrth38niGTEzu2jlKKFJj
	 OKq94Vlic8xDA==
Date: Tue, 31 Mar 2026 15:53:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Murali
 Karicheri <m-karicheri2@ti.com>, Grygorii Strashko
 <grygorii.strashko@ti.com>, Arnd Bergmann <arnd@arndb.de>, Siddharth
 Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Kevin Hao <haokexin@gmail.com>, Alexander
 Sverdlin <alexander.sverdlin@gmail.com>, Saeed Mahameed
 <saeedm@nvidia.com>, Daniel Zahka <daniel.zahka@gmail.com>,
 linux-omap@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RESEND, net-next] net: ethernet: ti-cpsw:: rename
 soft_reset() function
Message-ID: <20260331155306.6eb67153@kernel.org>
In-Reply-To: <20260331161814.3725730-1-arnd@kernel.org>
References: <20260331161254.3450606-1-arnd@kernel.org>
	<20260331161814.3725730-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 31 Mar 2026 18:17:55 +0200 Arnd Bergmann wrote:
> I just realized that this patch needs to come before
> https://lore.kernel.org/netdev/20260331161254.3450606-1-arnd@kernel.org/T/#u
> 
> The change itself is not important, but it renames a symbol that
> gets exported under the new name by the other patch, so either
> this gets applied first, or the other one needs a trivial change
> to fix the export.

Neither of the patches apply by themselves. Please post a proper series
once you're reading (and remember about the 24h spacing between postings
on netdev).
