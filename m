Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795183704;
	b=kWpLCoJIifFOuCcRdH6CoRktAVJXyWu+Sk6ZLqR/GzIUTEKswfqi4LITNO8XNM3dshsM
	 atZVtN+oBCo1cCkxi3rHu8SDXoSB14arfAiQUEjg8NCDilYt/JsEwnpvTMXn/4/1PjI4y
	 nA3CY7ErQxvtICd4M/StsEjlK/QCXf+/Gc12j/XwuUX/VVvGkGt64YGQe5bFXvnZQFcs0
	 o0+IymhZzeKVSxaYyplJf3vLa2MkK+4KFEnp+KAEC1VCflCk2XaKCxTXetivp0ZNOpPqF
	 PZRMSJ3vSugzpL2b8WlXcuh6y6VsFZXgkxwV0qfYT1yKc8PGfpAqP9L9ETPOGJjVYew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795183704;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=udFez81mLzzfz96x1FuR88RJ2TvJhuSa2geiVMDZwOo=;
	b=MzXdjDl3zqcdP6mhMBLlJKa8jvtGRKfbac34afCkCrHVfByzjOEYPMC3WjcfO6/qPCyY
	 MeLleI0w+X9gx1gUoKDDMma02jTNGntQQMdxI9X1R6/qe2VCQ7PjWFqoPRxelNHh3Gf6d
	 lkVcHDB7n0wxp0IkMuoah8pSsxvkRzbyVJOUw5nExOEDMNffouIsa5PVjPhLrToumwhzo
	 6nJUyzr1oKrYSA7Q0FWRPvE1GZXk85zSipXWNZG5hLmqsJroK+NswsxxE449/3gWr5wu/
	 btEB+woJQYfCSr11jv6LmkZDdBcLN2bvKu1p9m1HLmjQuF/JqeKcMQYr8+5L9BpNoMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=0mFjsRZx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835BB606A320;
	Fri, 20 Nov 2026 14:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=0mFjsRZx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0C0F1F000C4;
	Fri, 20 Nov 2026 14:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795183704;
	bh=udFez81mLzzfz96x1FuR88RJ2TvJhuSa2geiVMDZwOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=0mFjsRZxPozn3Rd/junBDqcAYRsZanvM9mDMRQlsOfvGRuSgJIhMVx6ccMu+xRLJz
	 ZApxeQPXGCPBCe63CDHkBMw6CO1H07jm4P0PbNM8puMndMPcl0xu+BKRmiLmXlMurz
	 fLjXvSSdARG09RtN3CAzJ6dPhsCYNZ0xDyerrbUg=
Date: Fri, 20 Nov 2026 15:08:21 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Pengpeng Hou <hppiscas@163.com>
Cc: b-liu@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org, s.nawrocki@samsung.com,
	kishon@kernel.org, balbi@ti.com, tony@atomide.com
Subject: Re: [PATCH v2 3/3] usb: musb: omap2430: report system-resume PHY
 setup failures
Message-ID: <2026112013-rubbing-busily-8bfc@gregkh>
References: <20260922004414.4192-1-hppiscas@163.com>
 <20260922004414.4192-4-hppiscas@163.com>
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922004414.4192-4-hppiscas@163.com>

On Tue, Sep 22, 2026 at 08:44:14AM +0800, Pengpeng Hou wrote:
> omap2430_resume() ignores PHY setup failures and always reports success.
> 
> Return the result of the ownership-aware PHY setup helper. End the
> system-sleep deferral even on failure: leaving phy_suspended set would
> make later runtime resumes skip the PHY permanently. The independent
> reference flags still record which resources need cleanup or retry.
> 
> A later suspend or platform exit therefore releases only references
> actually held, while a runtime resume can retry setup without adding a
> second initialization reference left over from a failed cleanup.
> 
> The issue was found by our static-analysis tool.
> 
> Fixes: 68d9f95d6fd5 ("usb: musb: Fix suspend and resume issues for PHYs on I2C and SPI")
> Assisted-by: gpt 5
> Signed-off-by: Pengpeng Hou <hppiscas@163.com>
> ---
>  drivers/usb/musb/omap2430.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
> index 382d6cd4a9e6..951e60906f2c 100644
> --- a/drivers/usb/musb/omap2430.c
> +++ b/drivers/usb/musb/omap2430.c
> @@ -657,14 +657,16 @@ static int omap2430_resume(struct device *dev)
>  {
>  	struct omap2430_glue *glue = dev_get_drvdata(dev);
>  	struct musb *musb = glue_to_musb(glue);
> +	int ret;
>  
>  	if (!musb)
>  		return 0;
>  
> -	omap2430_phy_power_on(glue);
> +	ret = omap2430_phy_power_on(glue);
> +	/* End system-sleep deferral so a later runtime resume can retry. */

Why is this comment needed?
