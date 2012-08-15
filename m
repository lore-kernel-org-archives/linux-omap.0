From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-V3] ARM: OMAP3+: hwmod: Add AM33XX HWMOD data
Date: Wed, 15 Aug 2012 09:10:57 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA8F4CD@DBDE01.ent.ti.com>
References: <1343214422-28718-1-git-send-email-hvaibhav@ti.com>
 <alpine.DEB.2.00.1207251438210.23542@utopia.booyaka.com>
 <alpine.DEB.2.00.1207261359500.14468@utopia.booyaka.com>
 <20120814082911.GG11011@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34678 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752607Ab2HOJLH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Aug 2012 05:11:07 -0400
In-Reply-To: <20120814082911.GG11011@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Mohammed, Afzal" <afzal@ti.com>, "Bedia, Vaibhav" <vaibhav.bedia@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Hilman, Kevin" <khilman@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>

On Tue, Aug 14, 2012 at 13:59:12, Tony Lindgren wrote:
> Hi,
> 
> * Paul Walmsley <paul@pwsan.com> [120726 13:07]:
> > On Wed, 25 Jul 2012, Paul Walmsley wrote:
> > 
> > > These IP blocks and the ECAP IP blocks have periods in their names.
> > > The rest of the IP block named in the file don't use periods -- which
> > > is also the style used by the rest of the OMAP SoCs.  Is there
> > > some reason that these have periods in their names?
> > 
> > I've changed those to match the rest of the names, and queued the 
> > following for 3.7.
> > 
> > Thanks again for all the hard work you all put into this.  I realize that 
> > with all the upstream changes, this was probably a little painful for you. 
> > But from my perspective you've been a pleasure to work with through the 
> > process.
> 
> As am33xx and omap5 are DT only, we should start moving towards getting
> rid of grep -E "irq|pa_start|pa_end|dma" in this patch and get the standard
> data from .dtsi files instead.
> 

It may not be so straight, given the fact that hwmod layer 
requires these resources, as hwmod is responsible to configure SYSCONF 
register of the device (happens very early at core_init level).

Somehow we have to have some mechanism to initialize " _mpu_rt_va" before 
core_init call, which will take DT resources and initialize accordingly.

Another dependency we will have is on system timers, Jon has already done 
some initial work on this, but I believe we did not concluded on the it.
I will re-start the thread again, since in any case DT support in timer is 
required.


> Alternatively we could get rid of the names and match the module based on
> pa_start and pa_end.
> 

Just FYI, from resource perspective, I have changed omap_device layer for DT 
resources only (still need hwmod resources as explained above) and patch 
looks something like (and it works) -


diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index c490240..cb481fe 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -528,10 +528,15 @@ struct omap_device *omap_device_alloc(struct platform_device *pdev,
         * HACK: Ideally the resources from DT should match, and hwmod
         * should just add the missing ones. Since the name is not
         * properly populated by DT, stick to hwmod resources only.
+        *
+        * But in case of all new devices, like AM33XX and OMAP5, where
+        * only DT boot is supported,  stick to DT resources only.
         */
-       if (pdev->num_resources && pdev->resource)
+       if (pdev->num_resources && pdev->resource) {
                dev_warn(&pdev->dev, "%s(): resources already allocated %d\n",
                        __func__, pdev->num_resources);
+               goto skip_res_override;
+       }

        res_count = omap_device_count_resources(od);
        if (res_count > 0) {
@@ -550,6 +555,7 @@ struct omap_device *omap_device_alloc(struct platform_device *pdev,
                        goto oda_exit3;
        }

+skip_res_override:
        if (!pm_lats) {
                pm_lats = omap_default_latency;
                pm_lats_cnt = ARRAY_SIZE(omap_default_latency);


Thanks,
Vaibhav
