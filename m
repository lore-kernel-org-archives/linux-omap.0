Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8621130B529;
	Mon,  6 Jul 2026 07:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783321646; cv=none; b=H0wJHJxwz/2UE2E3y8mbHi63Bc+SLJCkTChJII1jwbZqhuYHySY//kNESeZnO5nc0L3IJEXkYux9Lg2l2OdLKbZg/sz/GIJxy+rYJla7VZTfFwR+ywObIEHVCOVwx66Zl7aiW8Uz7nICIOSPGlmx5Ks/htjPppF28nQB4OV2mps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783321646; c=relaxed/simple;
	bh=mPdLGEvbcabL1ldHQnRh3rVH1sYbh3NqqOHQ/s7vJhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CS5EhkJ6ekX3aDTBwgbtTYqIKXsoAvs2fH/6gDw3hRl8FZk8yf9QLLpQcfRNskT7jM5+ZmTA/bdgSTWCa1PR8QffPJVryBUsjYUjVZRNja/fImsgNCEvZpljomk0hDwAvY+mWj/OuxBdXziiceWhP9XkShqEIRCKqNDfCSzm2CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gikjg/zV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gikjg/zV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 939CE1F00A3A;
	Mon,  6 Jul 2026 07:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783321639;
	bh=5/hcGctvwNPjPi5bBpjoXQsAdlYMzCbg/9xVDjdzAIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Gikjg/zVMqPx+4a5lHquUZ0ASxJvMKy6H1WKgXyrF4kji8uRwnllLKL2OyXITeCD9
	 /aryLly9mBRIYAvR+1UCw+kHqCep+1JYty6ub4ZOIs6NhVviZ8VDeA6jd3ZjUVJ6lC
	 1XXKk0pRwEU/Irc9B+Awz1dgz12gzPm/fOoQvcoWo8tj6UIQpfA5ebH1VwNuraMNoV
	 AvGjOLgc5N9bvsYu/LLj7liJfTwnqskzWuyetc8iZ7M/bbF29EVQSPzzveUZRhcVHz
	 s7iM1LBOBcGktqpvbGuw6a8vaHla38MS56M+nTe4uSOD/8yvxRyAOBl9leMQF2TbLZ
	 qIiqmzMh+34KQ==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1wgdQD-00000001dVL-260A;
	Mon, 06 Jul 2026 09:07:17 +0200
Date: Mon, 6 Jul 2026 09:07:17 +0200
From: Johan Hovold <johan@kernel.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Bin Liu <b-liu@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Wentao Liang <vulab@iscas.ac.cn>, linux-usb@vger.kernel.org,
	linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: musb: omap2430: Do not put borrowed of_node in probe
Message-ID: <aktUJSxhLBtlWoFF@hovoldconsulting.com>
References: <20260705091411.282560-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260705091411.282560-1-lgs201920130244@gmail.com>

On Sun, Jul 05, 2026 at 05:14:11PM +0800, Guangshuo Li wrote:
> omap2430_probe() stores pdev->dev.of_node in a local np variable. This is
> a borrowed pointer and the probe function does not take a reference to
> it.
> 
> The success and error paths nevertheless call of_node_put(np). This drops
> a reference that is owned by the platform device, and can leave
> pdev->dev.of_node with an unbalanced reference count.
> 
> Do not put the borrowed platform device node from omap2430_probe().
> References taken for the child MUSB device are handled by the device core,
> and the ctrl-module phandle reference is still released separately.
> 
> Fixes: e194ce048f5a ("usb: musb: omap2430: Fix use-after-free in omap2430_probe()")

This was not the commit that introduced the issue. This should be:

Fixes: ffbe2feac59b ("usb: musb: omap2430: Fix probe regression for missing resources")

and this should be backported to stable as well:

Cc: stable@vger.kernel.org

> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

And again, how are you finding these issues? Still no LLM involved?

With the above fixed:

Reviewed-by: Johan Hovold <johan@kernel.org>

Johan
