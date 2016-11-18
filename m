From: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [RFC 1/6] drm/etnaviv: add binding for the gc320 found in ti
 socs
Date: Fri, 18 Nov 2016 14:34:28 +0100
Message-ID: <1479476068.20533.19.camel@pengutronix.de>
References: <20161118024436.13447-1-robertcnelson@gmail.com>
         <0bf288ee-33bc-c3b5-389f-08d9bb89ccb5@ti.com>
         <20161118121340.GC23750@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161118121340.GC23750-l+eeeJia6m9URfEZ8mYm6t73F7V6hmMc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Julien <jboulnois-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Christian Gmeiner <christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Am Freitag, den 18.11.2016, 12:13 +0000 schrieb Russell King - ARM
Linux:
> On Thu, Nov 17, 2016 at 08:53:38PM -0600, Nishanth Menon wrote:
> > >diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> > >index a6799b0..ce51270 100644
> > >--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> > >+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> > >@@ -653,6 +653,7 @@ static int etnaviv_pdev_remove(struct platform_device *pdev)
> > > static const struct of_device_id dt_match[] = {
> > > 	{ .compatible = "fsl,imx-gpu-subsystem" },
> > > 	{ .compatible = "marvell,dove-gpu-subsystem" },
> > >+	{ .compatible = "ti,gc320-gpu-subsystem" },
> 
> We need to get away from this ever-increasing set of compatible
> strings here, as this is not long-term maintainable.
> 
> What we should have is a common compatible which describes that
> the node is compatible with this driver, and then use SoC specific
> compatible strings later if we need to (eg, because of some GPU
> subsystem SoC specifics.)
> 
> So, I'd suggest that we update the documentation and add:
> 
> 	"vivante,gc-gpu-subsystem"
> 
> as a common compatible now, and if necessary move on to more specific
> compatibles if we need to later.
> 
> Also, I'd strongly suggest that no compatibles should contain the ID
> number of the GPU core for exactly the same reason - Vivante GPU cores
> vary according to features, and we don't want to end up with a long
> list of specific compatibles (eg)
> 	"ti,gc2000-and-gc320-and-gc355-gpu-subsystem" because TI
> decides to integrate a 3d, 2d and VG core.
> 
All of the above sounds sensible and I would prefer if the patches are
reworked to take those things into account.

Regards,
Lucas

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
