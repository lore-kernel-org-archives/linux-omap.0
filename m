Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FF72BEFFB;
	Wed, 28 Jan 2026 03:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769569718; cv=none; b=fKVGUdQN9bV6ED7fvh+dmKjDOJC1mKL958cT57VDokIgknSM+n+/hSZik1Jz4oH2QCLNnowEtz50STccpLpMFBWJoxhJSvoAQYj+ePNRNftD2vnx1i0XPU/sr4DF/InHU3OeCEUC5nzDLRZw7DGNQk01cyG5rfspHf1w89Rm3PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769569718; c=relaxed/simple;
	bh=K+jPoyIcGZvHdH9YE2PNHo/iyuXcU67bxo7VmhYd+WA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k4ff2xy+cISex/SYIrft2UJh1qiLQMcb8ZFcRGuQVP0bszwqimG3qwQIpElAKJz4Tv8HJ8CBWGhDA5Z0KiR11XIrZ0qzYisZLDRVdfTIvSVDG90Rud9ETuphhNWzVnBbu6YQBs9ZPY0SGm2rIboIBCuYUPCXT0qpOFw+U4jwiJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PC7WMf4k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PC7WMf4k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A5EC19425;
	Wed, 28 Jan 2026 03:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769569718;
	bh=K+jPoyIcGZvHdH9YE2PNHo/iyuXcU67bxo7VmhYd+WA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PC7WMf4kC/vrMZ/QOVvNFau0VkJFYxe4OOmEmRaw2ni/k8ATGCHj6kMQdoebn0UEG
	 e7/jj++AJQW/XOMHhYPN35wcZjLlUuTUVrOb03dyLZUHCPRb5PxY3TZuPRMwYYC/Ab
	 jXTL+8E8jhiBhqUKOr0Okxj9HVT8PhA6fEDAAIBh4n5zEqtq+qxZ/aMGfYWB9pESr8
	 AZq+rn0eWVYGRoO2VtPYcKQ9SiyFgglJSmqA4A75ZPpsXKp+yc8CoKy6qT29BW1y8Z
	 VEiP7Bd4AD0WOrlk7MudgtxxMbBieZTfbYgyh6jxiCpLGpDYJCvI/+csgAyQnczG9K
	 qdtEY1ZOwRbhw==
Date: Tue, 27 Jan 2026 19:08:36 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kevin Hao <haokexin@gmail.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 linux-omap@vger.kernel.org
Subject: Re: [PATCH net v3] net: cpsw_new: Execute ndo_set_rx_mode callback
 in a work queue
Message-ID: <20260127190836.6a420768@kernel.org>
In-Reply-To: <20260127-bbb-v3-1-5e71f340c1e9@gmail.com>
References: <20260127-bbb-v3-1-5e71f340c1e9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Jan 2026 16:02:07 +0800 Kevin Hao wrote:
> To resolve this issue, we opt to execute the actual processing within
> a work queue, following the approach used by the icssg-prueth driver.

Code looks good now, but why are you creating a workqueue for this one
work? Can't you use the system wq and just cancel it sync where you had
the wq destroy?

BTW you're fixing drivers/net/ethernet/ti/cpsw_new.c I think
drivers/net/ethernet/ti/cpsw.c has an identical bug, no?
-- 
pw-bot: cr
