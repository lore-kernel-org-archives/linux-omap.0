From: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v4 03/12] mfd: twl-core: Add initial DT support for
 twl4030/twl6030
Date: Mon, 9 Jan 2012 00:38:20 +0100
Message-ID: <20120108233820.GH13679@sortiz-mobl>
References: <1324565806-31142-1-git-send-email-b-cousson@ti.com>
 <1324565806-31142-4-git-send-email-b-cousson@ti.com>
 <20120102090454.GO18381@ponder.secretlab.ca>
 <4F030C2D.3000808@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4F030C2D.3000808-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>, Graeme Gregory <gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Benoit,

On Tue, Jan 03, 2012 at 03:09:49PM +0100, Cousson, Benoit wrote:
> On 1/2/2012 10:04 AM, Grant Likely wrote:
> > On Thu, Dec 22, 2011 at 03:56:37PM +0100, Benoit Cousson wrote:
> >> Add initial device-tree support for twl familly chips.
> >> The current version is missing the regulator entries due
> >> to the lack of DT regulator bindings for the moment.
> >> Only the simple sub-modules that do not depend on
> >> platform_data information can be initialized properly.
> >>
> >> Add irqdomain support.
> >>
> >> Add documentation for the Texas Instruments TWL Integrated Chip.
> >>
> >> Signed-off-by: Benoit Cousson<b-cousson-l0cyMroinI0@public.gmane.org>
> >> Cc: Balaji T K<balajitk-l0cyMroinI0@public.gmane.org>
> >> Cc: Graeme Gregory<gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>
> >> Cc: Samuel Ortiz<sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> >> ---
> >> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> >> index f1391c2..f0de088 100644
> >> --- a/drivers/mfd/Kconfig
> >> +++ b/drivers/mfd/Kconfig
> >> @@ -200,6 +200,7 @@ config MENELAUS
> >>   config TWL4030_CORE
> >>   	bool "Texas Instruments TWL4030/TWL5030/TWL6030/TPS659x0 Support"
> >>   	depends on I2C=y&&  GENERIC_HARDIRQS
> >> +	select IRQ_DOMAIN
> > 
> > As discussed on linux-next, this breaks powerpc.  Drivers cannot select
> > IRQ_DOMAIN, it can only be selected by architectures.  Drivers must depend
> > on it instead.
> 
> OK, good to know. The previous version was already breaking non-ARM platform because the IRQ_DOMAIN was not defined, hence this update.
> I was able to check that this patch was fixing at least x86... but did not have any way to check the PPC build.
> 
> To be honest, I did not fully understand that this flag was there because some arch does not support IRQ domain yet and thus it should be selected at arch level.
> 
> Samuel,
> Here is the updated version, and hopefully the last one, including Grant's fix.
> 
Thanks, I applied it now.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
