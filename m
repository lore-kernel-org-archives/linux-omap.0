From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: Boot hang regression 3.10.0-rc4 -> 3.10.0
Date: Thu, 11 Jul 2013 14:47:00 +0530
Message-ID: <51DE780C.2070701@ti.com>
References: <20130705115959.GQ5523@atomide.com> <B5906170F1614E41A8A28DE3B8D121433EE94489@DBDE04.ent.ti.com> <B5906170F1614E41A8A28DE3B8D121433EE94520@DBDE04.ent.ti.com> <20130708112553.GU5523@atomide.com> <51DAB394.3050104@ti.com> <20130708131033.GA5523@atomide.com> <51DABC81.3080409@ti.com> <20130708133512.GD31221@arwen.pp.htv.fi> <87mwpuakod.fsf@linaro.org> <20130710142633.GV5523@atomide.com> <20130710160704.GH18966@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45545 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932211Ab3GKJRa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Jul 2013 05:17:30 -0400
In-Reply-To: <20130710160704.GH18966@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@linaro.org>, "Bedia, Vaibhav" <vaibhav.bedia@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Mark Jackson <mpfj-list@newflow.co.uk>, Sourav Poddar <sourav.poddar@ti.com>, Paul Walmsley <paul@pwsan.com>

On Wednesday 10 July 2013 09:37 PM, Felipe Balbi wrote:
> how about something like below ? It makes omap_device/hwmod and
> pm_runtime agree on the initial state of the device and will prevent
> ->runtime_resume() from being called on first pm_runtime_get*() done
> during probe.
> 
> This is similar to what PCI bus does (if you look at pci_pm_init()).

I tried something similar [1] but what I found is that the serial
runtime resume was called despite it being marked as active using
pm_runtime_set_active().

That seems to be because of the pm_runtime_set_autosuspend_delay()
because we have the autosuspend_delay = -1

-----
static void update_autosuspend(struct device *dev, int old_delay, int old_use)
{
        int delay = dev->power.autosuspend_delay;

        /* Should runtime suspend be prevented now? */
        if (dev->power.use_autosuspend && delay < 0) {

                /* If it used to be allowed then prevent it. */
                if (!old_use || old_delay >= 0) {
                        atomic_inc(&dev->power.usage_count);
                        rpm_resume(dev, 0); <------------------------------- calls serial runtime resume.
                }
        }
-----

So we end up with the same issue with serial resume being called before set_termios()

[1]

diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
index 5cc9287..c71d47d 100644
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -129,6 +129,7 @@ static int omap_device_build_from_dt(struct platform_device *pdev)
        struct device_node *node = pdev->dev.of_node;
        const char *oh_name;
        int oh_cnt, i, ret = 0;
+       bool device_active = false;
 
        oh_cnt = of_property_count_strings(node, "ti,hwmods");
        if (oh_cnt <= 0) {
@@ -152,6 +153,9 @@ static int omap_device_build_from_dt(struct platform_device *pdev)
                        goto odbfd_exit1;
                }
                hwmods[i] = oh;
+               if (oh->flags & HWMOD_INIT_NO_IDLE)
+                       device_active = true;
+                       
        }
 
        od = omap_device_alloc(pdev, hwmods, oh_cnt);
@@ -172,6 +176,11 @@ static int omap_device_build_from_dt(struct platform_device *pdev)
 
        pdev->dev.pm_domain = &omap_device_pm_domain;
 
+       if (device_active) {
+               omap_device_enable(pdev);
+               pm_runtime_set_active(&pdev->dev);
+       }
+       
 odbfd_exit1:
        kfree(hwmods);
 odbfd_exit:

