From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: Re: [RFC/PATCH 09/14] dt: omap: prepare hwmod to support dt
Date: Tue, 16 Aug 2011 20:32:25 +0530
Message-ID: <20110816150224.GA22182@manju-desktop>
References: <1312897232-4792-1-git-send-email-manjugk@ti.com>
 <1312897232-4792-10-git-send-email-manjugk@ti.com>
 <4E4270D3.8070807@ti.com>
 <20110810162846.GC2091@manju-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:47093 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753044Ab1HPPCk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Aug 2011 11:02:40 -0400
Received: by mail-yx0-f169.google.com with SMTP id 22so4111399yxn.0
        for <linux-omap@vger.kernel.org>; Tue, 16 Aug 2011 08:02:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110810162846.GC2091@manju-desktop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, Aug 10, 2011 at 09:58:46PM +0530, G, Manjunath Kondaiah wrote:
> On Wed, Aug 10, 2011 at 01:51:47PM +0200, Cousson, Benoit wrote:
> > Hi Manju,
> > 
> > On 8/9/2011 4:10 PM, G, Manjunath Kondaiah wrote:
> > >
> > >The omap dt requires new omap hwmod api to be added for in order
> > >to support omap dt.
> > 
> > Both the subject and the changelog are misleading. You are not doing
> > any hwmod stuff in it.
> > You are just passing an "of_node" pointer during omap_device_build_ss.
> > 
> > The subject should start with OMAP: omap_device: because it does not
> > belong to the DT subsystem.
> > The same comment apply to most patches in that series.
> 
> The goal of this patch is to make omap-hwmod ready for dt adaptation hence
> I used the title "dt: omap: prepare hwmod to support dt" and "of_node" pointer
> is passed from dt and it is required for dt build.
> 
> And as you mentioned, patch does not do anything related to omap_device.
> 
> > 
> > >The new api is added and new parameter "np" is added for existing
> > >api.
> > 
> > I don't think np is not a super meaningful name. Some more
> > explanation are needed as well.
> 
> ok. I can expand it.
> 
> > 
> > >The users of hwmod api is changed accrodingly.
> > 
> > omap_device API + typo.
> > 
> > >Build and boot tested on omap3 beagle for both dt and not dt build.
> > >
> > >Signed-off-by: G, Manjunath Kondaiah<manjugk@ti.com>
> > >---
> > >  arch/arm/mach-omap2/devices.c                 |    2 +-
> > >  arch/arm/mach-omap2/mcbsp.c                   |    2 +-
> > >  arch/arm/plat-omap/include/plat/omap_device.h |   11 +++++-
> > >  arch/arm/plat-omap/omap_device.c              |   53 ++++++++++++++++++++++---
> > >  4 files changed, 59 insertions(+), 9 deletions(-)
> > >
> > >diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> > >index 458f7be..d7ff1ae 100644
> > >--- a/arch/arm/mach-omap2/devices.c
> > >+++ b/arch/arm/mach-omap2/devices.c
> > >@@ -92,7 +92,7 @@ static int __init omap4_l3_init(void)
> > >  			pr_err("could not look up %s\n", oh_name);
> > >  	}
> > >
> > >-	pdev = omap_device_build_ss("omap_l3_noc", 0, oh, 3, NULL,
> > >+	pdev = omap_device_build_ss(NULL, "omap_l3_noc", 0, oh, 3, NULL,
> > >  						     0, NULL, 0, 0);
> > 
> > OK, maybe that is just me, but in order to extend an API, I'd rather
> > add the new parameter at the end.
> 
> I feel it's fine since node pointer is first parameter is all dt api's.
> 
> > 
> > >  	WARN(IS_ERR(pdev), "could not build omap_device for %s\n", oh_name);
> > >diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
> > >index 7a42f32..98eb95d 100644
> > >--- a/arch/arm/mach-omap2/mcbsp.c
> > >+++ b/arch/arm/mach-omap2/mcbsp.c
> > >@@ -144,7 +144,7 @@ static int omap_init_mcbsp(struct omap_hwmod *oh, void *unused)
> > >  		(struct omap_mcbsp_dev_attr *)(oh->dev_attr))->sidetone);
> > >  		count++;
> > >  	}
> > >-	pdev = omap_device_build_ss(name, id, oh_device, count, pdata,
> > >+	pdev = omap_device_build_ss(NULL, name, id, oh_device, count, pdata,
> > >  				sizeof(*pdata), omap2_mcbsp_latency,
> > >  				ARRAY_SIZE(omap2_mcbsp_latency), false);
> > >  	kfree(pdata);
> > >diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
> > >index 7a3ec4f..5e2424b 100644
> > >--- a/arch/arm/plat-omap/include/plat/omap_device.h
> > >+++ b/arch/arm/plat-omap/include/plat/omap_device.h
> > >@@ -33,6 +33,7 @@
> > >
> > >  #include<linux/kernel.h>
> > >  #include<linux/platform_device.h>
> > >+#include<linux/of.h>
> > >
> > >  #include<plat/omap_hwmod.h>
> > >
> > >@@ -89,12 +90,20 @@ struct platform_device *omap_device_build(const char *pdev_name, int pdev_id,
> > >  				      struct omap_device_pm_latency *pm_lats,
> > >  				      int pm_lats_cnt, int is_early_device);
> > >
> > >-struct platform_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
> > >+struct platform_device *omap_device_build_ss(struct device_node *np,
> > >+					 const char *pdev_name, int pdev_id,
> > >  					 struct omap_hwmod **oh, int oh_cnt,
> > >  					 void *pdata, int pdata_len,
> > >  					 struct omap_device_pm_latency *pm_lats,
> > >  					 int pm_lats_cnt, int is_early_device);
> > >
> > >+struct platform_device *omap_device_build_dt(struct device_node *np,
> > >+				      const char *pdev_name, int pdev_id,
> > >+				      struct omap_hwmod *oh, void *pdata,
> > >+				      int pdata_len,
> > >+				      struct omap_device_pm_latency *pm_lats,
> > >+				      int pm_lats_cnt, int is_early_device);
> > >+
> > >  void __iomem *omap_device_get_rt_va(struct omap_device *od);
> > >
> > >  /* OMAP PM interface */
> > >diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
> > >index 7d5e76b..fa49168 100644
> > >--- a/arch/arm/plat-omap/omap_device.c
> > >+++ b/arch/arm/plat-omap/omap_device.c
> > >@@ -85,6 +85,7 @@
> > >  #include<linux/clk.h>
> > >  #include<linux/clkdev.h>
> > >  #include<linux/pm_runtime.h>
> > >+#include<linux/of_device.h>
> > >
> > >  #include<plat/omap_device.h>
> > >  #include<plat/omap_hwmod.h>
> > >@@ -377,6 +378,7 @@ static int omap_device_fill_resources(struct omap_device *od,
> > >  /**
> > >   * omap_device_build - build and register an omap_device with one omap_hwmod
> > 
> > Need to update the kerneldoc.
> ok.

As these API's are interim API's and we might have alternate setup to handle
hwmod in the coming days, the documentation part will be taken care along with
final solution for hwmod issue.

> > 
> > >   * @pdev_name: name of the platform_device driver to use
> > >+ * @np: device node pointer for attaching it to of_node pointer
> > >   * @pdev_id: this platform_device's connection ID
> > >   * @oh: ptr to the single omap_hwmod that backs this omap_device
> > >   * @pdata: platform_data ptr to associate with the platform_device
> > >@@ -391,7 +393,8 @@ static int omap_device_fill_resources(struct omap_device *od,
> > >   * information.  Returns ERR_PTR(-EINVAL) if @oh is NULL; otherwise,
> > >   * passes along the return value of omap_device_build_ss().
> > >   */
> > >-struct platform_device *omap_device_build(const char *pdev_name, int pdev_id,
> > >+struct platform_device *omap_device_build_dt(struct device_node *np,
> > >+				      const char *pdev_name, int pdev_id,
> > >  				      struct omap_hwmod *oh, void *pdata,
> > >  				      int pdata_len,
> > >  				      struct omap_device_pm_latency *pm_lats,
> > 
> > That function should not be needed. You have to export
> > omap_device_build_ss, otherwise you will not build any device with
> > multiple hwmods.
> ok.

confused here. All the three API's *_dt/*_ss/*_dt are exported and can be
accessed for single or multiple hwmods. Am I missing anything?

-M

