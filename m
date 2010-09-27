From: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Subject: Re: [PATCH 9/9 v3] usb : musb: Offmode fix for idle path
Date: Mon, 27 Sep 2010 11:56:52 -0700
Message-ID: <87sk0vow0b.fsf@deeprootsystems.com>
References: <1285201846-26599-1-git-send-email-hemahk@ti.com>
	<877hib9bf5.fsf@deeprootsystems.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E9402DB3F8825@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E9402DB3F8825-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
	(Hema Kalliguddi's message of "Mon, 27 Sep 2010 10:49:26 +0530")
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Kalliguddi, Hema" <hemahk-l0cyMroinI0@public.gmane.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb@vger.kernel.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Mankad, Maulik Ojas" <x0082077-l0cyMroinI0@public.gmane.org>, "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

"Kalliguddi, Hema" <hemahk-l0cyMroinI0@public.gmane.org> writes:

>>-----Original Message-----
>>From: Kevin Hilman [mailto:khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org]
>>Sent: Saturday, September 25, 2010 1:12 AM
>>To: Kalliguddi, Hema
>>Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
>>Mankad, Maulik Ojas; Balbi, Felipe; Tony Lindgren; Cousson,
>>Benoit; Paul Walmsley
>>Subject: Re: [PATCH 9/9 v3] usb : musb: Offmode fix for idle path
>>
>>Hema HK <hemahk-l0cyMroinI0@public.gmane.org> writes:
>>
>>> With OMAP core-off support musb was not functional as
>>context was getting
>>> lost after wakeup from core-off.
>>
>>This should be a separate patch.
>>
>
> Let me give the description of the musb offmode support in the idle path.

The detail you provided below is very good, and this is the level of
detail that needs to go into the changelogs.

> With the current mainline code, offmode in the idle path is not supported with usb.
> When the core hits off and wakes up the musb will not be functional.
> This patch is to support the musb functionality with offmode enabled in the idle path.

OK, what about the PM branch.  I was under the impression that offmode
was working fine in the PM branch.

And, looking at the  PM branch, the only thing done in the idle path is
the disable of autoidle upon wakeup.  Everything else (context
save/restore etc.) is done in the driver.

> Below are the requirements to support retention and offmode of OMAP in idle path with usb enabled
> During idle and when there is no activity on the bus:
>
> 1.Since there is no hardware context save/restore supported in OMAP for musb, software
> has to save the context.
> 2.Configure the musb in force idle/standby mode during idle mode

This needs more detailed description (TRM reference, etc.)

> 3.May or may not disable the interface clock(as interface clock is autogated)
> and the functional clock is from ULPI phy on triton chip.
>
> When OMAP awakes:
>
> 1.enable the clock if it is disabled.and
> 2.Configure it back to no idle/standby or smart idle/standby after wakeup.

In the PM branch, this part is done in idle.

> 3.Restore the context back.

But this is done by the driver.

> Idling of device can be done when there is no activity on the bus by using the pm_runtime_put_sync
n> apis in when device disconnects or suspends, but resuming has to done as soon as the omap is wokenup from
> retention or core off, as we have to put back the musb in known state ie restore the conext atleast
> enabling D+/D- lines,enabling interrupts and configuring the no idle/standby or smart idle/standby
> to even capture the irqs. Otherwise we will not be able to capture the musb connect/reset or resume/remote
> wakeup events as D+/D- lines will disabled when the context is lost duribg offmode.
>
> If I use the pm_runtime_put_sync in disconnect/suspend handler when device suspends/disconnects
> and use pm_runtime_get_sync when OMAP wakesup, then there will be mismatch in the usecount.
>
> We could have achieved the same by using the triton connect/disconnect events to idle/resume musb,
> but some of the phys do not support the connect/disconnect events.
>
> So cameup with the design of idling musb device in idle loop and resume once the OMAP wakes up.
> All this done onl when the musb is not active.

Rather than seeing more work done in the idle path, I would rather be
moving code out of the idle path.

Did you consider using a (deferrable) timer during no-activity times
which periodically checks to be sure the IP is in force idle/standby?

> Since the IDLE REQ/ACK protocol is broken, the recommendation from ip team is to
> configure the musb in force idle/standby during omap retention and offmode.

Yes, this is in the PM branch and there is an errata number for it
there.  Please reference that errata when implementing this feature
(both in the changelog and in the code.)

Kevin

> Since we have to touch the sysconfig registers and context save/restore everytime,
> I am using the runtime pm apis.
>
>>> And also musb was blocking the core-off after loading the gadget
>>> driver even with no cable connected sometimes.
>>
>>this too
>>
>>> Added the idle and wakeup APIs in the platform layer which will
>>> be called in the idle and wakeup path.
>>
>>And this errata fix should be a separate patch, with reference to the
>>errata etc.
>>
> This is not an errata, this is requirement from the ip. it is mentioned in
> the functional spec that when device is not use put it in force idle/standby mode.
>
>
>>> Used the pm_runtime_put_sysc API to configure the
>>> musb to force idle/standby modes, saving the context and
>>disable the clk in
>>> while idling if there is no activity on the usb bus.
>>
>>Why?  This should not be part of the idle path.
>>
>
>
>>If there is no activity on the bus, why hasn't the musb driver already
>>runtime suspended itself?
>>
>>If the driver want's to runtime_suspend itself based on inactivity, it
>>should use an inactivity timer, not hook into the idle loop.   The
>>runtime PM API has a function for a deferred suspend
>>
>>    int pm_schedule_suspend(struct device *dev, unsigned int delay)
>>
>>The only thing in the idle loop in the current code is the errata fix,
>>and even that I'm not sure I'm ready to merge.
>>
>>I'd really like to see even the errata fix out of the idle
>>path.   I wonder if usb-musb.c could create a periodic,
>>deferrable timer
>>to fire that ensure that autoidle is disabled.
>>
>>> Used the pm_runtime_get_sync API to configure the musb to
>>> no idle/standby modes, enable the clock and restore the context
>>> after wakeup when there is no activity on the usb bus.
>>
>>Why would you wakeup MUSB in the idle path if there is no activity on
>>the bus?
>>
> This is because MUSB has to be in known good state to capture any musb interrupts.
>
>>I don't understand the motiviation or these last two changes, and they
>>are a departure from the behavior of the previous code.
>>
> Can you please let mw know which 2 changes you reering to?
> You mean assing function to check whether the device is active
> and adding 2 flags for conext save/restore?
>
>>At a minimum, they should be separated into a separate patch, and
>>thoroughly described, including an answer to "why?"
>>
>>Kevin
>>
>>> Signed-off-by: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
>>> Signed-off-by: Maulik Mankad <x0082077-l0cyMroinI0@public.gmane.org>
>>> Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
>>> Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
>>> Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
>>> Cc: Cousson, Benoit <b-cousson-l0cyMroinI0@public.gmane.org>
>>> Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
>>>
>>> ---
>>>  arch/arm/mach-omap2/cpuidle34xx.c     |    1
>>>  arch/arm/mach-omap2/pm34xx.c          |    3
>>>  arch/arm/mach-omap2/usb-musb.c        |  107
>>++++++++++++++++++++++++++++++++++
>>>  arch/arm/plat-omap/include/plat/usb.h |    2
>>>  drivers/usb/musb/musb_core.c          |   15 ++++
>>>  drivers/usb/musb/omap2430.c           |   14 ++++
>>>  include/linux/usb/musb.h              |    9 ++
>>>  7 files changed, 149 insertions(+), 2 deletions(-)
>>>
>>> Index: linux-omap-pm/arch/arm/mach-omap2/cpuidle34xx.c
>>> ===================================================================
>>> --- linux-omap-pm.orig/arch/arm/mach-omap2/cpuidle34xx.c
>>> +++ linux-omap-pm/arch/arm/mach-omap2/cpuidle34xx.c
>>> @@ -31,6 +31,7 @@
>>>  #include <plat/clockdomain.h>
>>>  #include <plat/control.h>
>>>  #include <plat/serial.h>
>>> +#include <plat/usb.h>
>>>
>>>  #include "pm.h"
>>>
>>> Index: linux-omap-pm/arch/arm/mach-omap2/pm34xx.c
>>> ===================================================================
>>> --- linux-omap-pm.orig/arch/arm/mach-omap2/pm34xx.c
>>> +++ linux-omap-pm/arch/arm/mach-omap2/pm34xx.c
>>> @@ -38,6 +38,7 @@
>>>  #include <plat/prcm.h>
>>>  #include <plat/gpmc.h>
>>>  #include <plat/dma.h>
>>> +#include <plat/usb.h>
>>>
>>>  #include <asm/tlbflush.h>
>>>
>>> @@ -324,11 +325,13 @@ static void restore_table_entry(void)
>>>  void omap3_device_idle(void)
>>>  {
>>>      omap2_gpio_prepare_for_idle();
>>> +    musb_prepare_for_idle();
>>>  }
>>>
>>>  void omap3_device_resume(void)
>>>  {
>>>      omap2_gpio_resume_after_idle();
>>> +    musb_wakeup_from_idle();
>>>  }
>>>
>>>  void omap_sram_idle(void)
>>> Index: linux-omap-pm/arch/arm/mach-omap2/usb-musb.c
>>> ===================================================================
>>> --- linux-omap-pm.orig/arch/arm/mach-omap2/usb-musb.c
>>> +++ linux-omap-pm/arch/arm/mach-omap2/usb-musb.c
>>> @@ -25,16 +25,21 @@
>>>  #include <linux/io.h>
>>>
>>>  #include <linux/usb/musb.h>
>>> +#include <linux/pm_runtime.h>
>>>
>>>  #include <mach/hardware.h>
>>>  #include <mach/irqs.h>
>>>  #include <plat/usb.h>
>>>  #include <plat/omap_device.h>
>>> +#include <plat/powerdomain.h>
>>>
>>>  #ifdef CONFIG_USB_MUSB_SOC
>>>  static const char name[] = "musb_hdrc";
>>>  #define MAX_OMAP_MUSB_HWMOD_NAME_LEN        16
>>>
>>> +struct omap_hwmod *oh_p;
>>> +static struct powerdomain *core_pwrdm;
>>> +
>>>  static struct musb_hdrc_config musb_config = {
>>>      .multipoint     = 1,
>>>      .dyn_fifo       = 1,
>>> @@ -58,6 +63,10 @@ static struct musb_hdrc_platform_data mu
>>>       * "mode", and should be passed to usb_musb_init().
>>>       */
>>>      .power          = 50,                   /* up to 100 mA */
>>> +
>>> +    /* OMAP supports offmode */
>>> +    .save_context   = 1,
>>> +    .restore_context        = 1,
>>>  };
>>>
>>>  static u64 musb_dmamask = DMA_BIT_MASK(32);
>>> @@ -80,6 +89,7 @@ void __init usb_musb_init(struct omap_mu
>>>      const char *oh_name = "usb_otg_hs";
>>>      struct musb_hdrc_platform_data *pdata;
>>>
>>> +    core_pwrdm = pwrdm_lookup("per_pwrdm");
>>>      oh = omap_hwmod_lookup(oh_name);
>>>
>>>      if (!oh) {
>>> @@ -97,6 +107,7 @@ void __init usb_musb_init(struct omap_mu
>>>      musb_plat.extvbus = board_data->extvbus;
>>>
>>>      pdata = &musb_plat;
>>> +    oh_p = oh;
>>>
>>>      od = omap_device_build(name, bus_id, oh, pdata,
>>>                             sizeof(struct musb_hdrc_platform_data),
>>> @@ -115,8 +126,101 @@ void __init usb_musb_init(struct omap_mu
>>>      put_device(dev);
>>>  }
>>>
>>> +void musb_prepare_for_idle()
>>> +{
>>> +    int core_next_state;
>>> +    struct omap_hwmod *oh = oh_p;
>>> +    struct omap_device *od;
>>> +    struct platform_device *pdev;
>>> +    struct musb_hdrc_platform_data *pdata;
>>> +    struct device *dev;
>>> +
>>> +    if (!core_pwrdm)
>>> +            return;
>>> +
>>> +    core_next_state = pwrdm_read_next_pwrst(core_pwrdm);
>>> +    if (core_next_state >= PWRDM_POWER_INACTIVE)
>>> +            return;
>>> +    if (!oh)
>>> +            return;
>>> +
>>> +    od = oh->od;
>>> +    pdev = &od->pdev;
>>> +
>>> +    if (!pdev)
>>> +            return;
>>> +    dev = &pdev->dev;
>>> +
>>> +    if (dev->driver) {
>>> +            pdata = dev->platform_data;
>>> +
>>> +    if (pdata->is_usb_active)
>>> +            if (!pdata->is_usb_active(dev)) {
>>> +                    if (core_next_state == PWRDM_POWER_OFF) {
>>> +                            pdata->save_context = 1;
>>> +                            pm_runtime_put_sync(dev);
>>> +                    } else if  (core_next_state ==
>>PWRDM_POWER_RET) {
>>> +                            pdata->save_context = 0;
>>> +                            pm_runtime_put_sync(dev);
>>> +                    }
>>> +            }
>>> +    }
>>> +}
>>> +
>>> +void musb_wakeup_from_idle()
>>> +{
>>> +    int core_next_state;
>>> +    int core_prev_state;
>>> +    struct omap_hwmod *oh = oh_p;
>>> +    struct omap_device *od;
>>> +    struct platform_device *pdev;
>>> +    struct device *dev;
>>> +    struct musb_hdrc_platform_data *pdata;
>>> +
>>> +    if (!core_pwrdm)
>>> +            return;
>>> +
>>> +    core_next_state = pwrdm_read_next_pwrst(core_pwrdm);
>>> +
>>> +    if (core_next_state >= PWRDM_POWER_INACTIVE)
>>> +            return;
>>> +     core_prev_state = pwrdm_read_prev_pwrst(core_pwrdm);
>>> +
>>> +     if (!oh)
>>> +            return;
>>> +     od = oh->od;
>>> +     pdev = &od->pdev;
>>> +
>>> +     if (!pdev)
>>> +            return;
>>> +
>>> +     dev = &pdev->dev;
>>> +
>>> +     if (dev->driver) {
>>> +            pdata = dev->platform_data;
>>> +
>>> +            if (pdata->is_usb_active)
>>> +                    if (!pdata->is_usb_active(dev)) {
>>> +                            if (core_prev_state ==
>>PWRDM_POWER_OFF) {
>>> +                                    pdata->restore_context = 1;
>>> +                                     pm_runtime_get_sync(dev);
>>> +                            } else {
>>> +                                     pdata->restore_context = 0;
>>> +                                     pm_runtime_get_sync(dev);
>>> +                            }
>>> +                     }
>>> +     }
>>> +}
>>>  #else
>>>  void __init usb_musb_init(struct omap_musb_board_data *board_data)
>>>  {
>>>  }
>>> +
>>> +void musb_prepare_for_idle()
>>> +{
>>> +}
>>> +
>>> +void musb_wakeup_from_idle()
>>> +{
>>> +}
>>>  #endif /* CONFIG_USB_MUSB_SOC */
>>> Index: linux-omap-pm/arch/arm/plat-omap/include/plat/usb.h
>>> ===================================================================
>>> --- linux-omap-pm.orig/arch/arm/plat-omap/include/plat/usb.h
>>> +++ linux-omap-pm/arch/arm/plat-omap/include/plat/usb.h
>>> @@ -79,6 +79,8 @@ extern void usb_ehci_init(const struct e
>>>
>>>  extern void usb_ohci_init(const struct
>>ohci_hcd_omap_platform_data *pdata);
>>>
>>> +extern void musb_prepare_for_idle(void);
>>> +extern void musb_wakeup_from_idle(void);
>>>  #endif
>>>
>>>
>>> Index: linux-omap-pm/drivers/usb/musb/musb_core.c
>>> ===================================================================
>>> --- linux-omap-pm.orig/drivers/usb/musb/musb_core.c
>>> +++ linux-omap-pm/drivers/usb/musb/musb_core.c
>>> @@ -2410,6 +2410,7 @@ static int musb_suspend(struct device *d
>>>      struct platform_device *pdev = to_platform_device(dev);
>>>      unsigned long   flags;
>>>      struct musb     *musb = dev_to_musb(&pdev->dev);
>>> +    struct musb_hdrc_platform_data *plat = dev->platform_data;
>>>
>>>      if (!musb->clock)
>>>              return 0;
>>> @@ -2425,6 +2426,9 @@ static int musb_suspend(struct device *d
>>>               * they will even be wakeup-enabled.
>>>               */
>>>      }
>>> +
>>> +    if (plat->save_context)
>>> +            plat->save_context = 1;
>>>      pm_runtime_put_sync(dev);
>>>
>>>  #ifndef CONFIG_PM_RUNTIME
>>> @@ -2443,10 +2447,13 @@ static int musb_resume_noirq(struct devi
>>>  {
>>>      struct platform_device *pdev = to_platform_device(dev);
>>>      struct musb     *musb = dev_to_musb(&pdev->dev);
>>> +    struct musb_hdrc_platform_data *plat = dev->platform_data;
>>>
>>>      if (!musb->clock)
>>>              return 0;
>>>
>>> +    if (plat->restore_context)
>>> +            plat->restore_context = 1;
>>>      pm_runtime_get_sync(dev);
>>>
>>>  #ifndef CONFIG_PM_RUNTIME
>>> @@ -2468,16 +2475,20 @@ static int musb_resume_noirq(struct devi
>>>  static int musb_runtime_suspend(struct device *dev)
>>>  {
>>>      struct musb     *musb = dev_to_musb(dev);
>>> +    struct musb_hdrc_platform_data *plat = dev->platform_data;
>>>
>>> -    musb_save_context(musb);
>>> +    if (plat->save_context)
>>> +            musb_save_context(musb);
>>>      return 0;
>>>  }
>>>
>>>  static int musb_runtime_resume(struct device *dev)
>>>  {
>>>      struct musb     *musb = dev_to_musb(dev);
>>> +    struct musb_hdrc_platform_data *plat = dev->platform_data;
>>>
>>> -    musb_restore_context(musb);
>>> +    if (plat->restore_context)
>>> +            musb_restore_context(musb);
>>>      return 0;
>>>  }
>>>  static const struct dev_pm_ops musb_dev_pm_ops = {
>>> Index: linux-omap-pm/drivers/usb/musb/omap2430.c
>>> ===================================================================
>>> --- linux-omap-pm.orig/drivers/usb/musb/omap2430.c
>>> +++ linux-omap-pm/drivers/usb/musb/omap2430.c
>>> @@ -189,6 +189,19 @@ int musb_platform_set_mode(struct musb *
>>>      return 0;
>>>  }
>>>
>>> +int is_musb_active(struct device *dev)
>>> +{
>>> +    struct musb *musb;
>>> +
>>> +#ifdef CONFIG_USB_MUSB_HDRC_HCD
>>> +    /* usbcore insists dev->driver_data is a "struct hcd *" */
>>> +    musb = hcd_to_musb(dev_get_drvdata(dev));
>>> +#else
>>> +    musb = dev_get_drvdata(dev);
>>> +#endif
>>> +    return musb->is_active;
>>> +}
>>> +
>>>  int __init musb_platform_init(struct musb *musb)
>>>  {
>>>      u32 l;
>>> @@ -232,6 +245,7 @@ int __init musb_platform_init(struct mus
>>>              musb->board_set_vbus = omap_set_vbus;
>>>
>>>      setup_timer(&musb_idle_timer, musb_do_idle, (unsigned
>>long) musb);
>>> +    plat->is_usb_active = is_musb_active;
>>>
>>>      return 0;
>>>  }
>>> Index: linux-omap-pm/include/linux/usb/musb.h
>>> ===================================================================
>>> --- linux-omap-pm.orig/include/linux/usb/musb.h
>>> +++ linux-omap-pm/include/linux/usb/musb.h
>>> @@ -93,6 +93,8 @@ struct musb_hdrc_config {
>>>
>>>  };
>>>
>>> +struct device;
>>> +
>>>  struct musb_hdrc_platform_data {
>>>      /* MUSB_HOST, MUSB_PERIPHERAL, or MUSB_OTG */
>>>      u8              mode;
>>> @@ -126,6 +128,17 @@ struct musb_hdrc_platform_data {
>>>
>>>      /* Architecture specific board data     */
>>>      void            *board_data;
>>> +
>>> +    /* check usb device active state*/
>>> +    int             (*is_usb_active)(struct device *dev);
>>> +
>>> +    /*
>>> +     * Used for saving and restoring the registers only when core
>>> +     * next state is off and previous state was off.
>>> +     * Otherwise avoid save restore.
>>> +     */
>>> +    int             save_context;
>>> +    int             restore_context;
>>>  };
>>>
>>>
>>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
