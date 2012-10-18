From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [RFC/NOT FOR MERGING 1/5] arm: omap: fix up _od_suspend_noirq and _od_resume_noirq
Date: Thu, 18 Oct 2012 09:34:15 -0700
Message-ID: <871ugvivso.fsf@deeprootsystems.com>
References: <1350488043-5053-1-git-send-email-balbi@ti.com>
	<1350488043-5053-2-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:46044 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932480Ab2JRQeB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Oct 2012 12:34:01 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so8450887pad.19
        for <linux-omap@vger.kernel.org>; Thu, 18 Oct 2012 09:34:01 -0700 (PDT)
In-Reply-To: <1350488043-5053-2-git-send-email-balbi@ti.com> (Felipe Balbi's
	message of "Wed, 17 Oct 2012 18:33:59 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

Felipe Balbi <balbi@ti.com> writes:

> current implementation doesn't take care about
> drivers which don't provide *_noirq methods 

The generic ops handle this.  See below.

> and we could fall into a situation where we would suspend/resume
> devices even though they haven't asked for it.

The following explanation doesn't explain this, so I dont' follow
the "even though they haven't asked for it" part.

> One such case happened with the I2C driver which
> was getting suspended during suspend_noirq() just
> to be resume right after by any other device doing
> an I2C transfer on its suspend method.

In order to be I2C to be runtime resumed after its noirq method has been
called, that means the other device is doing an I2C xfer in its noirq
method.  That is a bug.

> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  arch/arm/plat-omap/omap_device.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
> index 7a7d1f2..935f416 100644
> --- a/arch/arm/plat-omap/omap_device.c
> +++ b/arch/arm/plat-omap/omap_device.c
> @@ -804,8 +804,12 @@ static int _od_suspend_noirq(struct device *dev)
>  {
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct omap_device *od = to_omap_device(pdev);
> +	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
>  	int ret;
>  
> +	if (!pm || !pm->suspend_noirq)
> +		return 0;
> +

you just re implemented pm_generic_suspend_noirq() (c.f. drivers/base/power/generic_ops.c)

>  	/* Don't attempt late suspend on a driver that is not bound */
>  	if (od->_driver_status != BUS_NOTIFY_BOUND_DRIVER)
>  		return 0;
> @@ -827,6 +831,10 @@ static int _od_resume_noirq(struct device *dev)
>  {
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct omap_device *od = to_omap_device(pdev);
> +	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
> +
> +	if (!pm || !pm->resume_noirq)
> +		return 0;

and this is basically pm_generic_resume_noirq()

>  
>  	if ((od->flags & OMAP_DEVICE_SUSPENDED) &&
>  	    !pm_runtime_status_suspended(dev)) {

Kevin
