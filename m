From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: [RESEND PATCH v6 4/4] usb: musb: da8xx: Add a primary support of
 PM runtime
Date: Mon, 3 Apr 2017 15:14:08 -0500
Message-ID: <66c2ba1d-8da2-3932-afc7-5fe00eaad932@ti.com>
References: <20170324143600.4704-1-abailon@baylibre.com>
 <20170324143600.4704-5-abailon@baylibre.com>
 <703e5e95-8bde-2b1c-0d63-4ed3e03f53b8@ti.com>
 <03cc95cd-5967-c0c7-06a7-89cf08dbde47@baylibre.com>
 <1552a8e0-9efe-3658-e511-76e056ed5588@ti.com>
 <322bdb6b-72c4-01e1-8ae7-bf04ea89a1ee@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <322bdb6b-72c4-01e1-8ae7-bf04ea89a1ee-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org



On 03/27/2017 02:54 PM, Alexandre Bailon wrote:
> On 03/27/2017 07:38 PM, Grygorii Strashko wrote:
>>
>>
>> On 03/27/2017 11:39 AM, Alexandre Bailon wrote:
>>> Hello Grygorii,
>>> On 03/24/2017 06:26 PM, Grygorii Strashko wrote:
>>>>
>>>>
>>>> On 03/24/2017 09:36 AM, Alexandre Bailon wrote:
>>>>> Currently, MUSB DA8xx glue driver doesn't have PM runtime support.
>>>>> Because the CPPI 4.1 is using the same clock as MUSB DA8xx and
>>>>> CPPI 4.1 is a child of MUSB DA8xx glue, add support of PM runtime
>>>>> to the DA8xx glue driver in order to let the CPPI 4.1 driver manage
>>>>> the clock by using PM runtime.
>>>>>
>>>>> Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
>>>>> ---
>>>>>  drivers/usb/musb/da8xx.c | 27 ++++++++-------------------
>>>>>  1 file changed, 8 insertions(+), 19 deletions(-)
>>>>>
>>>>> diff --git a/drivers/usb/musb/da8xx.c b/drivers/usb/musb/da8xx.c
>>>>> index ed28afd..89e12f6 100644
>>>>> --- a/drivers/usb/musb/da8xx.c
>>>>> +++ b/drivers/usb/musb/da8xx.c
>>>>> @@ -30,7 +30,6 @@
>>>>>   */
>>>>>
>>>>
>>>> [...]
>>>>
>>>>>
>>>>> @@ -527,12 +520,6 @@ static int da8xx_probe(struct platform_device
>>>> *pdev)
>>>>>      if (!glue)
>>>>>          return -ENOMEM;
>>>>>
>>>>> -    clk = devm_clk_get(&pdev->dev, "usb20");
>>>>> -    if (IS_ERR(clk)) {
>>>>> -        dev_err(&pdev->dev, "failed to get clock\n");
>>>>> -        return PTR_ERR(clk);
>>>>> -    }
>>>>> -
>>>>>      glue->phy = devm_phy_get(&pdev->dev, "usb-phy");
>>>>>      if (IS_ERR(glue->phy)) {
>>>>>          if (PTR_ERR(glue->phy) != -EPROBE_DEFER)
>>>>> @@ -541,7 +528,6 @@ static int da8xx_probe(struct platform_device
>>>> *pdev)
>>>>>      }
>>>>>
>>>>>      glue->dev            = &pdev->dev;
>>>>> -    glue->clk            = clk;
>>>>>
>>>>>      if (IS_ENABLED(CONFIG_OF) && np) {
>>>>>          pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
>>>>> @@ -587,6 +573,8 @@ static int da8xx_probe(struct platform_device
>>>> *pdev)
>>>>>      pinfo.data = pdata;
>>>>>      pinfo.size_data = sizeof(*pdata);
>>>>>
>>>>> +    pm_runtime_enable(&pdev->dev);
>>>>> +
>>>>>      glue->musb = platform_device_register_full(&pinfo);
>>>>>      ret = PTR_ERR_OR_ZERO(glue->musb);
>>>>>      if (ret) {
>>>>> @@ -603,6 +591,7 @@ static int da8xx_remove(struct platform_device
>>>> *pdev)
>>>>>
>>>>>      platform_device_unregister(glue->musb);
>>>>>      usb_phy_generic_unregister(glue->usb_phy);
>>>>> +    pm_runtime_disable(&pdev->dev);
>>>>>
>>>>>      return 0;
>>>>>  }
>>>>> @@ -616,7 +605,7 @@ static int da8xx_suspend(struct device *dev)
>>>>>      ret = phy_power_off(glue->phy);
>>>>>      if (ret)
>>>>>          return ret;
>>>>> -    clk_disable_unprepare(glue->clk);
>>>>> +    pm_runtime_put_sync(dev);
>>>>
>>>> This, most probably will do nothing as Suspend framework will increase
>>>> ref counter.
>>>> Better way might be to use PM runtime force API.
>>>> pm_runtime_force_suspend()
>>> Good catch. Effectively, the device remain active.
>>> But we can't use pm_runtime_force_suspend() because it expect that all
>>> child have been
>>> runtime suspended which is usually not the case.
>>
>> If this is the parent - it should be suspended the last and any
>> children are
>> not expected to be accessible after that.
> Yes but suspended doesn't mean runtime suspended.
> In the case of system suspend, the MUSB core will be suspended but its
> runtime_status
> will remain active and so pm_runtime_force_suspend() will refuse to work
> because it will
> not consider the MUSB core as suspend.
>>
>> Also, if there are will be force_suspend() here and force_resume() in
>> da8xx_resume()
>> then parent should always be active before any child.
>>
>> So, I seems didn't get your point :(
> I think with an example and some logs it should be more clear:
> rtcwake -d /dev/rtc0 -m mem -s 1
> rtcwake: assuming RTC uses UTC ...
> rtcwake: wakeup from "mem" using /dev/rtc0 at Wed Mar 22 00:43:07 2017
> PM: Syncing filesystems ... done.
> Freezing user space processes ... (elapsed 0.002 seconds) done.
> Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
> Suspending console(s) (use no_console_suspend to debug)
> davinci_mdio davinci_mdio.0: resetting idled controller
> musb-da8xx musb-da8xx: runtime PM trying to suspend device but active child
> PM: suspend of devices complete after 167.287 msecs
> PM: late suspend of devices complete after 8.752 msecs
> PM: noirq suspend of devices complete after 8.389 msecs
> PM: noirq resume of devices complete after 4.385 msecs
> PM: early resume of devices complete after 5.880 msecs
> davinci_mdio davinci_mdio.0: resetting idled controller
> SMSC LAN8710/LAN8720 davinci_mdio.0:07: attached PHY driver [SMSC
> LAN8710/LAN8720] (mii_bus:phy_addr=davinci_mdio.0:07, irq=-1)
> tilcdc da8xx_lcdc.0: tilcdc_crtc_irq(0x00000161): FIFO underflow
> Suspended for 1.454 seconds
> davinci_emac davinci_emac.1 eth0: Link is Up - 100Mbps/Full - flow
> control off
> PM: resume of devices complete after 4178.211 msecs
> Restarting tasks ...
> usb 2-1: USB disconnect, device number 3
> done.
> 
> I'm using rtcwake to test suspend / resume.
> As you can see in the log, musb-da8xx doesn't complete the suspend
> because it child is active
> (though it doesn't prevent the suspend to happen).
> On resume, the USB device disconnects and from here the USB controller
> is dead.
> It will not detect any connect / disconnect anymore. This happens
> because pm_runtime_force_resume()
> fails and the resume callback exit before to turn on the OTG phy.
>>

More simple way to test it (at least on am335x-evm):
   33  echo platform > /sys/power/pm_test 
   34  echo 1 > /sys/power/pm_print_times 
   35  echo mem > /sys/power/state 


I was able to reproduce and play with it on am335x-evm, unfortunately you are right
and  pm_runtime_force_x() APIs will not work out of the box, because USB framework
keeps a lot of devices in its hierarchy in PM runtime Active state
(and this hierarchy is not static - depends on what is plugged in port during suspend).

So, I see two option here:
1) use pm_clk_suspend/pm_clk_resume() directly in .suspend()/.resume()


2) do some hacks as in diff below
you might not need get/put in suspend as you going do get in .probe() without put.

>From ac0178455f8dfda635d8d45e8235d73b936a19a9 Mon Sep 17 00:00:00 2001
From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Date: Mon, 3 Apr 2017 14:53:57 -0500
Subject: [PATCH] [draft] drivers/usb/musb/musb_dsps: do suspend

Signed-off-by: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/musb/musb_dsps.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index 9c7ee26..43306a7 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -1011,6 +1011,8 @@ static int dsps_suspend(struct device *dev)
 	struct musb *musb = platform_get_drvdata(glue->musb);
 	void __iomem *mbase;
 
+	pm_runtime_get_sync(dev);
+
 	del_timer_sync(&glue->timer);
 
 	if (!musb)
@@ -1027,8 +1029,9 @@ static int dsps_suspend(struct device *dev)
 	glue->context.rx_mode = musb_readl(mbase, wrp->rx_mode);
 
 	dsps_dma_controller_suspend(glue);
+	pm_suspend_ignore_children(dev, true);
 
-	return 0;
+	return pm_runtime_force_suspend(dev);
 }
 
 static int dsps_resume(struct device *dev)
@@ -1040,6 +1043,8 @@ static int dsps_resume(struct device *dev)
 
 	if (!musb)
 		return 0;
+	pm_suspend_ignore_children(dev, false);
+	pm_runtime_force_resume(dev);
 
 	dsps_dma_controller_resume(glue);
 
@@ -1055,6 +1060,8 @@ static int dsps_resume(struct device *dev)
 	    musb->port_mode == MUSB_PORT_MODE_DUAL_ROLE)
 		dsps_mod_timer(glue, -1);
 
+	pm_runtime_put(dev);
+
 	return 0;
 }
 #endif
-- 
2.10.1


-- 
regards,
-grygorii
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
