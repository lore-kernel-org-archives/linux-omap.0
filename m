From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP HDQ: was Re: DSS2/PM on 3.2 broken?
Date: Thu, 26 Jan 2012 07:19:19 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1201260647570.11174@utopia.booyaka.com>
References: <WC20120109124643.880164@terrafix.co.uk> <20120110080849.5a242adf@notabene.brown> <alpine.DEB.2.00.1201110632100.31702@utopia.booyaka.com> <20120112095940.0a54413e@notabene.brown> <alpine.DEB.2.00.1201130253070.3659@utopia.booyaka.com>
 <20120113222045.37f9b4ec@notabene.brown> <alpine.DEB.2.00.1201130423280.3659@utopia.booyaka.com> <20120114100915.01c96727@notabene.brown> <20120118082410.48262777@notabene.brown> <alpine.DEB.2.00.1201211704430.26641@utopia.booyaka.com>
 <20120124213705.49f042bf@notabene.brown>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42137 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318Ab2AZOTU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Jan 2012 09:19:20 -0500
In-Reply-To: <20120124213705.49f042bf@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Joe Woodward <jw@terrafix.co.uk>, khilman@ti.com, t-kristo@ti.com, govindraj.raja@ti.com, linux-omap@vger.kernel.org

On Tue, 24 Jan 2012, NeilBrown wrote:

> On Sat, 21 Jan 2012 17:07:18 -0700 (MST) Paul Walmsley <paul@pwsan.com> wrote:
> 
> > On Wed, 18 Jan 2012, NeilBrown wrote:
> > 
> > > Oh - another thing.
> > > Sometimes during early boot I get:
> > > 
> > > [    0.158447] omap_hwmod: usbtll_fck: missing clockdomain for usbtll_fck.
> > > [    0.176879] omap_hwmod: hdq: softreset failed (waited 10000 usec)
> > 
> > This latter bug just got fixed, it's updated in the new HDQ series that I 
> > sent out:
> > 
> > http://marc.info/?l=linux-omap&m=132719073710874&w=2
> > 
> > BTW, if you could give that a spin for us at some point, it would be 
> > greatly appreciated; I don't think I have a board with a 1-wire device on 
> > it (at least, not that I know of).
> 
> Yes, the patch series seems to work OK - at least it doesn't break anything:
> I can still access my battery charge meter.

Thanks.  Should I add a Tested-by: from you on those patches?

> It doesn't fix the problem I am having where HDQ gets confused when CPUIDLE
> kicks in, but I think I might have a handle on that now.
> 
> Unlike other modules, HDQ doesn't have SIDLEMODE.
> According to 18.4.5 (AM/DM37x Multimedia Device Silicon Revision) it acts as
> though SIDLEMODE were set to SIDLE_FORCE so if the clock-domain trys to
> switch off, HDQ lets it.

Hmm.  Do you know if the problem occurs in the middle of the HDQ 
transaction, or when HDQ is completely idle?  I'd suspect the former.

Here's a theory: perhaps the MPU powerdomain is hitting a low-power state 
while waiting for an HDQ interrupt.  When the MPU powerdomain is in a low 
power state, so is the MPU interrupt controller, so the only way that the 
MPU can wake up is if the HDQ can issue a wakeup event to the PRCM.  And I 
don't see any evidence that the HDQ is capable of doing this, based on the 
HDQ sections of the TRM.  What a huge energy waste, if true.

Maybe try something like the following patch -- compile-tested only here.

If this works, you might want to try dropping this patch and using the pad 
mux to set a wakeup event on the 1-wire pad when the signal goes low.  
That might be a more power-efficient approach.  You may still have to use 
some PM QoS request there to ensure that the HDQ can wake up fast enough 
to see the pulse, but the constraint shouldn't need to be as ludicrously 
low as it is in the following patch.


- Paul

commit 92fa561191b60ddf1296e02a6206160e8a5718f0
Author: Paul Walmsley <paul@pwsan.com>
Date:   Thu Jan 26 07:04:40 2012 -0700

    Attempt to work around lack of HDQ wakeup support

diff --git a/drivers/w1/masters/omap_hdq.c b/drivers/w1/masters/omap_hdq.c
index 63e3eda..990e38b 100644
--- a/drivers/w1/masters/omap_hdq.c
+++ b/drivers/w1/masters/omap_hdq.c
@@ -17,6 +17,7 @@
 #include <linux/io.h>
 #include <linux/sched.h>
 #include <linux/pm_runtime.h>
+#include <linux/pm_qos.h>
 
 #include <asm/irq.h>
 #include <mach/hardware.h>
@@ -61,6 +62,8 @@ struct hdq_data {
 	/* lock status update */
 	struct  mutex		hdq_mutex;
 	int			hdq_usecount;
+	struct pm_qos_request	pm_qos_request;
+
 	u8			hdq_irqstatus;
 	/* device lock */
 	spinlock_t		hdq_spinlock;
@@ -409,6 +412,18 @@ static int omap_hdq_get(struct hdq_data *hdq_data)
 		goto rtn;
 	}
 
+	/*
+	 * XXX Horrible hack to keep the MPU powerdomain out of a
+	 * low-power state during HDQ transfers, since the HDQ doesn't
+	 * appear to be able to wake the system.  This constraint is
+	 * way too short - it will probably keep the MPU out of WFI
+	 * which is a total waste - but we don't have a
+	 * platform-independent way to control powerdomain states at
+	 * the moment and there is no obvious replacement for platform_data
+	 * fn ptrs AFAIK
+	 */
+	pm_qos_update_request(&hdq_data->pm_qos_request, 1);
+
 	if (OMAP_HDQ_MAX_USER == hdq_data->hdq_usecount) {
 		dev_dbg(hdq_data->dev, "attempt to exceed the max use count");
 		ret = -EINVAL;
@@ -464,6 +479,10 @@ static int omap_hdq_put(struct hdq_data *hdq_data)
 		if (0 == hdq_data->hdq_usecount)
 			pm_runtime_put_sync(hdq_data->dev);
 	}
+
+	pm_qos_update_request(&hdq_data->pm_qos_request,
+			      PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE);
+
 	mutex_unlock(&hdq_data->hdq_mutex);
 
 	return ret;
@@ -578,6 +597,10 @@ static int __devinit omap_hdq_probe(struct platform_device *pdev)
 	hdq_data->hdq_usecount = 0;
 	mutex_init(&hdq_data->hdq_mutex);
 
+	pm_qos_add_request(&hdq_data->pm_qos_request,
+			   PM_QOS_CPU_DMA_LATENCY,
+			   PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE);
+
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_get_sync(&pdev->dev);
 
