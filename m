From: "Kalliguddi, Hema" <hemahk@ti.com>
Subject: RE: [PATCH 8/8 ]usb : musb:Using runtime pm apis for musb.
Date: Tue, 10 Aug 2010 10:37:41 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94027094403E@dbde02.ent.ti.com>
References: <1281115749-1601-1-git-send-email-hemahk@ti.com>
 <4C600B9F.4050403@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53362 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751522Ab0HJFHw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Aug 2010 01:07:52 -0400
In-Reply-To: <4C600B9F.4050403@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Basak, Partha" <p-basak2@ti.com>, Felipe Balbi <felipe.balbi@nokia.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>

 Hi,

>-----Original Message-----
>From: Cousson, Benoit
>Sent: Monday, August 09, 2010 7:37 PM
>To: Kalliguddi, Hema
>Cc: linux-usb@vger.kernel.org; linux-omap@vger.kernel.org;
>Basak, Partha; Felipe Balbi; Tony Lindgren; Kevin Hilman
>Subject: Re: [PATCH 8/8 ]usb : musb:Using runtime pm apis for musb.
>
>On 8/6/2010 7:29 PM, Hema HK wrote:
>> From: Hema HK<hemahk@ti.com>
>>
>> Calling runtime pm APIs pm_runtime_put_sync() and
>pm_runtime_get_sync()
>> for enabling/disabling the clocks,sysconfig settings.
>>
>> used omap_hwmod_enable_wakeup&  omap_hwmod_disable_wakeup
>apis to set/clear
>> the wakeup enable bit.
>> Also need to put the USB in force standby and force idle
>mode when usb not used
>> and set it back to smart idle and smart stndby after wakeup.
>> these cases are handled using the oh flags.
>> For omap3430 auto idle bit has to be disabled because of the
>errata.So using
>> HWMOD_NO_OCP_AUTOIDLE flag for OMAP3430.
>>
>> Signed-off-by: Hema HK<hemahk@ti.com>
>> Signed-off-by: Basak, Partha<p-basak2@ti.com>
>>
>> Cc: Felipe Balbi<felipe.balbi@nokia.com>
>> Cc: Tony Lindgren<tony@atomide.com>
>> Cc: Kevin Hilman<khilman@deeprootsystems.com>
>> ---
>>
>>   arch/arm/mach-omap2/pm34xx.c          |   10 +++-
>>   arch/arm/mach-omap2/usb-musb.c        |   72
>++++++++++++++++++++++++++++++-
>>   arch/arm/plat-omap/include/plat/usb.h |    9 +++
>>   drivers/usb/musb/musb_core.c          |   12 +++++
>>   drivers/usb/musb/omap2430.c           |   77
>+++++-----------------------------
>>   include/linux/usb/musb.h              |   18 +++++++
>>   6 files changed, 126 insertions(+), 72 deletions(-)
>>
>> Index: linux-omap-pm/arch/arm/mach-omap2/pm34xx.c
>> ===================================================================
>> --- linux-omap-pm.orig/arch/arm/mach-omap2/pm34xx.c
>2010-08-06 10:44:06.000000000 -0400
>> +++ linux-omap-pm/arch/arm/mach-omap2/pm34xx.c  2010-08-06
>10:44:42.942112875 -0400
>> @@ -418,7 +418,9 @@
>>                          omap3_core_save_context();
>>                          omap3_prcm_save_context();
>>                          /* Save MUSB context */
>> -                       musb_context_save_restore(1);
>> +                       musb_context_save_restore(save_context);
>> +               } else {
>> +                       musb_context_save_restore(disable_clk);
>>                  }
>>          }
>>
>> @@ -462,8 +464,10 @@
>>                          omap3_sram_restore_context();
>>                          omap2_sms_restore_context();
>>                          /* restore MUSB context */
>> -                       musb_context_save_restore(0);
>> -               }
>> +                       musb_context_save_restore(restore_context);
>> +               } else {
>> +                       musb_context_save_restore(enable_clk);
>> +               }
>>                  omap_uart_resume_idle(0);
>>                  omap_uart_resume_idle(1);
>>                  if (core_next_state == PWRDM_POWER_OFF)
>> Index: linux-omap-pm/arch/arm/mach-omap2/usb-musb.c
>> ===================================================================
>> --- linux-omap-pm.orig/arch/arm/mach-omap2/usb-musb.c
>2010-08-06 10:44:06.000000000 -0400
>> +++ linux-omap-pm/arch/arm/mach-omap2/usb-musb.c
>2010-08-06 10:44:42.942112875 -0400
>> @@ -25,11 +25,13 @@
>>   #include<linux/io.h>
>>
>>   #include<linux/usb/musb.h>
>> +#include<linux/pm_runtime.h>
>>
>>   #include<mach/hardware.h>
>>   #include<mach/irqs.h>
>>   #include<plat/usb.h>
>>   #include<plat/omap_device.h>
>> +#include<plat/omap_hwmod.h>
>>
>>   #ifdef CONFIG_USB_MUSB_SOC
>>
>> @@ -99,6 +101,18 @@
>>                  musb_plat.board_data = board_data;
>>                  musb_plat.power = board_data->power>>  1;
>>                  musb_plat.mode = board_data->mode;
>> +               musb_plat.device_enable = omap_device_enable;
>> +               musb_plat.device_idle = omap_device_idle;
>> +               musb_plat.enable_wakeup = omap_device_enable_wakeup;
>> +               musb_plat.disable_wakeup =
>omap_device_disable_wakeup;
>> +               /*
>> +                * Errata 1.166 idle_req/ack is broken in omap3430
>> +                * workaround is to disable the autodile bit
>for omap3430.
>> +                */
>
>As written in the errata document: Unique reference to be used for
>communication, Errata ID: i479. You should not use 1.166.
>Also the description is a little bit different:
>idle_req / idle_ack mechanism potentially broken when autoidle
>is enabled.
>OK, it looks like it can occur randomly during run time, meaning that
>"potentially" can be probably removed.
>
I will update it accordingly.

>In that case, what is the point of the previous patch that separate
>smartidle and autoidle modification?

This errata is applicable to only OMAP3430. The previous patch required
for OMAP4.
>
>> +               if (cpu_is_omap3430())
>> +                       oh->flags |= HWMOD_NO_OCP_AUTOIDLE;
>
>You should not access omap_hwmod structure from here and moreover the
>flags attribute is a not supposed to be changed dynamically. It is
>reflecting the capability of the hwmod and should considered
>as a constant.
>For that kind of fix, you just have to modified the omap3
>hwmod data file.

Agreed. Thought of it... But did not do it.
>
>> +
>> +               musb_plat.oh = oh;
>>                  pdata =&musb_plat;
>>
>>                  od = omap_device_build(name, bus_id, oh, pdata,
>> @@ -120,7 +134,7 @@
>>          }
>>   }
>>
>> -void musb_context_save_restore(int save)
>> +void musb_context_save_restore(enum musb_state state)
>>   {
>>          struct omap_hwmod *oh = omap_hwmod_lookup("usb_otg_hs");
>>          struct omap_device *od = oh->od;
>> @@ -129,14 +143,64 @@
>>          struct device_driver *drv = dev->driver;
>>
>>          if (drv) {
>> +#ifdef CONFIG_PM_RUNTIME
>>                  struct musb_hdrc_platform_data *pdata =
>dev->platform_data;
>>                  const struct dev_pm_ops *pm = drv->pm;
>> -               if (!pdata->is_usb_active(dev)) {
>>
>> -                       if (save)
>> +               if (!pdata->is_usb_active(dev)) {
>> +                       switch (state) {
>> +                       case save_context:
>> +                               /* If the usb device not
>active then Save
>> +                                * the context,set the
>sysconfig setting to
>> +                                * force standby force idle
>during idle and
>> +                                * disable the clock.
>> +                                */
>> +                               oh->flags |= HWMOD_SWSUP_SIDLE
>> +                                               |
>HWMOD_SWSUP_MSTANDBY;
>
>You should not access this directly. Moreover, since the autoidle is
>broken, you can just set HWMOD_SWSUP_SIDLE, and that will take care of
>changing the modes during enable / idle.

By setting HWMOD_SWSUP_SIDLE, the enable /idle will set the modes to no-idle and
Force-idle. But required setting is smart idle/standby and force idle/standby.
Without accessing these flags I will not be able to set force idle/standby and
Smart idle/standby using idle/enable functions.


>
>>                                  pm->suspend(dev);
>> -                       else
>> +                               pdata->device_idle(pdev);
>> +
>> +                               break;
>> +                       case disable_clk:
>> +                               /* If the usb device not active then
>> +                                * Save the context, set the
>sysconfig setting
>> +                                * to force standby force
>idle during idle and
>> +                                * disable the clock.
>> +                                */
>> +
>> +                               oh->flags |= HWMOD_SWSUP_SIDLE
>> +                                       | HWMOD_SWSUP_MSTANDBY;
>> +                               pdata->device_idle(pdev);
>
>How is this mode used? What is point of all these different states?
>Is musb_context_save_restore saving anything in that case?
This mode is to just set the sysc setting to force idle/standby and disable the clock.
In this state there is no context save. The comment needs correction.

In case save_context: there will will context save, sysconfig settings and disable clock.

>
>> +
>> +                               break;
>> +
>> +                       case restore_context:
>> +                               /* Enable the clock, set the
>sysconfig
>> +                                * back to smart idle and
>smart stndby after
>> +                                * wakeup. restore the context.
>> +                                */
>> +                               oh->flags&= ~(HWMOD_SWSUP_SIDLE
>> +                                       | HWMOD_SWSUP_MSTANDBY);
>> +                               pdata->device_enable(pdev);
>>                                  pm->resume_noirq(dev);
>> +
>> +                               break;
>> +
>> +                       case enable_clk:
>> +                               /* Set the sysconfig back to smart
>> +                                * idle and smart stndby
>after wakeup and
>> +                                * enable the clock
>> +                                */
>> +                               oh->flags&= ~(HWMOD_SWSUP_SIDLE
>> +                                       | HWMOD_SWSUP_MSTANDBY);
>> +                               pdata->device_enable(pdev);
>> +
>> +                               break;
>> +
>> +                       default:
>> +                               break;
>> +                       }
>> +#endif
>>                  }
>>          }
>>   }
>> Index: linux-omap-pm/arch/arm/plat-omap/include/plat/usb.h
>> ===================================================================
>> --- linux-omap-pm.orig/arch/arm/plat-omap/include/plat/usb.h
>   2010-08-06 10:44:06.000000000 -0400
>> +++ linux-omap-pm/arch/arm/plat-omap/include/plat/usb.h
>2010-08-06 10:44:42.942112875 -0400
>> @@ -71,6 +71,13 @@
>>          unsigned extvbus:1;
>>   };
>>
>> +enum musb_state {
>> +       save_context = 1,
>> +       disable_clk,
>> +       restore_context,
>> +       enable_clk,
>> +       };
>> +
>>   enum musb_interface    {MUSB_INTERFACE_ULPI, MUSB_INTERFACE_UTMI};
>>
>>   extern void usb_musb_init(struct omap_musb_board_data *board_data);
>> @@ -80,7 +87,7 @@
>>   extern void usb_ohci_init(const struct
>ohci_hcd_omap_platform_data *pdata);
>>
>>   /* For saving and restoring the musb context during off/wakeup*/
>> -extern void musb_context_save_restore(int save);
>> +extern void musb_context_save_restore(enum musb_state state);
>>   #endif
>>
>>
>> Index: linux-omap-pm/drivers/usb/musb/musb_core.c
>> ===================================================================
>> --- linux-omap-pm.orig/drivers/usb/musb/musb_core.c
>2010-08-06 10:44:06.000000000 -0400
>> +++ linux-omap-pm/drivers/usb/musb/musb_core.c  2010-08-06
>10:44:42.942112875 -0400
>> @@ -2447,9 +2447,21 @@
>>          return 0;
>>   }
>>
>> +static int musb_runtime_suspend(struct device *dev)
>> +{
>> +       return 0;
>> +}
>> +
>> +static int musb_runtime_resume(struct device *dev)
>> +{
>> +       return 0;
>> +}
>> +
>>   static const struct dev_pm_ops musb_dev_pm_ops = {
>>          .suspend        = musb_suspend,
>>          .resume_noirq   = musb_resume_noirq,
>> +       .runtime_suspend = musb_runtime_suspend,
>> +       .runtime_resume  = musb_runtime_resume,
>>   };
>
>These are probably not needed, considering that they are both empty.

Agreed.
>
>>
>>   #define MUSB_DEV_PM_OPS (&musb_dev_pm_ops)
>> Index: linux-omap-pm/drivers/usb/musb/omap2430.c
>> ===================================================================
>> --- linux-omap-pm.orig/drivers/usb/musb/omap2430.c
>2010-08-06 10:44:30.093914217 -0400
>> +++ linux-omap-pm/drivers/usb/musb/omap2430.c   2010-08-06
>10:44:42.942112875 -0400
>> @@ -31,6 +31,7 @@
>>   #include<linux/list.h>
>>   #include<linux/clk.h>
>>   #include<linux/io.h>
>> +#include<linux/pm_runtime.h>
>>
>>   #include<plat/mux.h>
>>
>> @@ -209,10 +210,6 @@
>>          struct musb_hdrc_platform_data *plat = dev->platform_data;
>>          struct omap_musb_board_data *data = plat->board_data;
>>
>> -#if defined(CONFIG_ARCH_OMAP2430)
>> -       omap_cfg_reg(AE5_2430_USB0HS_STP);
>> -#endif
>> -
>>          /* We require some kind of external transceiver, hooked
>>           * up through ULPI.  TWL4030-family PMICs include one,
>>           * which needs a driver, drivers aren't always needed.
>> @@ -224,22 +221,6 @@
>>          }
>>
>>          musb_platform_resume(musb);
>> -
>> -       l = musb_readl(musb->mregs, OTG_SYSCONFIG);
>> -       l&= ~ENABLEWAKEUP;     /* disable wakeup */
>> -       l&= ~NOSTDBY;          /* remove possible nostdby */
>> -       l |= SMARTSTDBY;        /* enable smart standby */
>> -       l&= ~AUTOIDLE;         /* disable auto idle */
>> -       l&= ~NOIDLE;           /* remove possible noidle */
>> -       l |= SMARTIDLE;         /* enable smart idle */
>> -       /*
>> -        * MUSB AUTOIDLE don't work in 3430.
>> -        * Workaround by Richard Woodruff/TI
>> -        */
>> -       if (!cpu_is_omap3430())
>> -               l |= AUTOIDLE;          /* enable auto idle */
>> -       musb_writel(musb->mregs, OTG_SYSCONFIG, l);
>> -
>>          l = musb_readl(musb->mregs, OTG_INTERFSEL);
>>
>>          if (data->interface_type == MUSB_INTERFACE_UTMI) {
>> @@ -273,48 +254,26 @@
>>   void musb_platform_save_context(struct musb *musb,
>>                  struct musb_context_registers *musb_context)
>>   {
>> -       /*
>> -        * As per the omap-usbotg specification, configure
>it to forced standby
>> -        * and  force idle mode when no activity on usb.
>> -        */
>>          void __iomem *musb_base = musb->mregs;
>>
>> -       musb_writel(musb_base, OTG_FORCESTDBY, 0);
>> -
>> -       musb_writel(musb_base, OTG_SYSCONFIG, musb_readl(musb_base,
>> -                               OTG_SYSCONFIG)&  ~(NOSTDBY |
>SMARTSTDBY));
>> -
>> -       musb_writel(musb_base, OTG_SYSCONFIG, musb_readl(musb_base,
>> -                                       OTG_SYSCONFIG)&
>~(AUTOIDLE));
>> -
>> -       musb_writel(musb_base, OTG_SYSCONFIG, musb_readl(musb_base,
>> -                               OTG_SYSCONFIG)&  ~(NOIDLE |
>SMARTIDLE));
>> -
>>          musb_writel(musb_base, OTG_FORCESTDBY, 1);
>>   }
>>
>>   void musb_platform_restore_context(struct musb *musb,
>>                  struct musb_context_registers *musb_context)
>>   {
>> -       /*
>> -        * As per the omap-usbotg specification, configure
>it smart standby
>> -        * and smart idle during operation.
>> -        */
>>          void __iomem *musb_base = musb->mregs;
>>
>>          musb_writel(musb_base, OTG_FORCESTDBY, 0);
>> -
>> -       musb_writel(musb_base, OTG_SYSCONFIG, musb_readl(musb_base,
>> -                               OTG_SYSCONFIG) | (SMARTSTDBY));
>> -
>> -       musb_writel(musb_base, OTG_SYSCONFIG, musb_readl(musb_base,
>> -                               OTG_SYSCONFIG) | (SMARTIDLE));
>>   }
>>   #endif
>>
>>   static int musb_platform_suspend(struct musb *musb)
>>   {
>>          u32 l;
>> +       struct device *dev = musb->controller;
>> +       struct musb_hdrc_platform_data *pdata = dev->platform_data;
>> +       struct omap_hwmod *oh = pdata->oh;
>>
>>          if (!musb->clock)
>>                  return 0;
>> @@ -324,16 +283,9 @@
>>          l |= ENABLEFORCE;       /* enable MSTANDBY */
>>          musb_writel(musb->mregs, OTG_FORCESTDBY, l);
>>
>> -       l = musb_readl(musb->mregs, OTG_SYSCONFIG);
>> -       l |= ENABLEWAKEUP;      /* enable wakeup */
>> -       musb_writel(musb->mregs, OTG_SYSCONFIG, l);
>> -
>> +       pdata->enable_wakeup(oh->od);
>
>Why do you have to explicitely enable and disable wakeup?
Existing code was doing this. I just migrated to  use new APIs
But I will check why is this needed.


Rehards,
Hema
>
>Benoit
>
