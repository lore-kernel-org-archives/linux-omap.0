From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: musb host mode suspend mode
Date: Wed, 11 Dec 2013 17:14:43 +0100
Message-ID: <CAOf5uw=NJ4XF5VsagEtsxKBVCx1shpWh1D1Eh-_uM58SA7_HCA@mail.gmail.com>
References: <CAOf5uwn0gqLNWMks6Cw_9szC-Mpq6n+G3x9tqU8QpYOJoOKhfA@mail.gmail.com>
	<CAOf5uwnJwE54wdwhJj90rJ0Lqv_ENrGL2vcdUtruw4zb0R+e+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:59127 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751036Ab3LKQOp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Dec 2013 11:14:45 -0500
Received: by mail-wi0-f173.google.com with SMTP id hn9so7301902wib.0
        for <linux-omap@vger.kernel.org>; Wed, 11 Dec 2013 08:14:44 -0800 (PST)
In-Reply-To: <CAOf5uwnJwE54wdwhJj90rJ0Lqv_ENrGL2vcdUtruw4zb0R+e+w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Hi

On Sat, Dec 7, 2013 at 6:22 PM, Michael Trimarchi
<michael@amarulasolutions.com> wrote:
> Hi
>
> On Wed, Nov 27, 2013 at 4:26 PM, Michael Trimarchi
> <michael@amarulasolutions.com> wrote:
>> Hi Felipe,
>>
>> I'm trying to understand how dpll_usb and vbus should work in suspend mode.
>> What I have in my kernel 3.0.31 from ti is that if I suspend the device with id
>> pin ground and no device connected I have:
>>
>> - vbus 5v
>> - dpll_usb locked problem so l3domain can not suspend
>>
>> If I have the id pin floating (device mode) and no device connected I
>> can suspend
>> without problem. I'm not care about remote wakeup and I would like to understand
>> what is the reason of having no complete suspend in host mode. Can you give
>> some insight?
>
> I get a bit further and if I do something like that so basically force
> device mode I can suspend.
>
> +       if (val) {
> +               twl->force_device = false;
> +               twl6030_writeb(twl, TWL_MODULE_USB, 0x14, USB_ID_CTRL_SET);
> +               twl6030_usb_irq(twl->irq2, twl);
> +               twl6030_usbotg_irq(twl->irq1, twl);
> +       } else {
> +               twl->force_device = true;
> +               twl6030_writeb(twl, TWL_MODULE_USB, 0x14, USB_ID_CTRL_CLR);
> +               twl6030_usb_irq(twl->irq2, twl);
> +               twl6030_usbotg_irq(twl->irq1, twl);
> +       }
>
> So my problem is let the device connect host mode (remote wakeup
> disable) and let the system suspend in the correct way.
>

I think that I have almost fixed the problem of suspend resume of the
otg host mode in this old
version of the kernel. But I would like to share my short summary:

- I have implemented the suspend/resume hooks of the omap2430 and manually
call the omap_device_idle and omap_device_disable because in old
version of the kernel
this hooks are not implemented in the omap_device structure

- I understand the reason in not having the runtime_suspend the otg in
host mode but I'm not sure:
  * the runtime_get_sync is taken on the ID_GND event so as soon it's
host connected the use_count
go to 1 but I did't find where it is released

- I still have a

<4>[   41.856445] WARNING: at
/home/michael/work/amarula/wincor/paypad/kernel/arch/arm/mach-omap2/omap_l3_noc.c:135
l3_interrupt_handler+0x254/0x344()
<4>[   41.856475] CUSTOM SRESP error with SOURCE:L4CFG
<4>[   41.856506] Modules linked in: pvrsrvkm_sgx540_120 gps_drv
wl12xx mac80211 cfg80211 compat
<4>[   41.856567] Backtrace:
<4>[   41.856597] [<c00e43e0>] (dump_backtrace+0x0/0x10c) from
[<c0679db0>] (dump_stack+0x18/0x1c)
<4>[   41.856628]  r7:00000009 r6:00000087 r5:c010652c r4:c783dc80
<4>[   41.856689] [<c0679d98>] (dump_stack+0x0/0x1c) from [<c012b31c>]
(warn_slowpath_common+0x54/0x6c)
<4>[   41.856750] [<c012b2c8>] (warn_slowpath_common+0x0/0x6c) from
[<c012b3d8>] (warn_slowpath_fmt+0x38/0x40)
<4>[   41.856781]  r9:00000000 r8:f8000400 r7:00080003 r6:c08ce948 r5:00000448
<4>[   41.856811] r4:f8000000
<4>[   41.856842] [<c012b3a0>] (warn_slowpath_fmt+0x0/0x40) from
[<c010652c>] (l3_interrupt_handler+0x254/0x344)
<4>[   41.856872]  r3:c07ee514 r2:c07ee4b0
<4>[   41.856933] [<c01062d8>] (l3_interrupt_handler+0x0/0x344) from
[<c017291c>] (handle_irq_event_percpu+0x6c/0x290)
<4>[   41.856964] [<c01728b0>] (handle_irq_event_percpu+0x0/0x290)
from [<c0172b84>] (handle_irq_event+0x44/0x64)
<4>[   41.857025] [<c0172b40>] (handle_irq_event+0x0/0x64) from
[<c01751fc>] (handle_fasteoi_irq+0xa0/0x144)
<4>[   41.857055]  r7:0000002a r6:c783c000 r5:c08a1b8c r4:c08a1b40
<4>[   41.857116] [<c017515c>] (handle_fasteoi_irq+0x0/0x144) from
[<c017246c>] (generic_handle_irq+0x3c/0x48)
<4>[   41.857116]  r5:c00d9020 r4:c08b0898
<4>[   41.857177] [<c0172430>] (generic_handle_irq+0x0/0x48) from
[<c00da054>] (asm_do_IRQ+0x54/0xb4)
<4>[   41.857238] [<c00da000>] (asm_do_IRQ+0x0/0xb4) from [<c067db88>]
(__irq_svc+0x48/0xe0)
<4>[   41.857238] Exception stack(0xc783dd80 to 0xc783ddc8)

But maybe somenthing is wrong in the sequence

+       struct omap2430_glue            *glue = dev_get_drvdata(dev);
+       struct musb                     *musb = glue_to_musb(glue);
+       struct platform_device          *pdev = to_platform_device(dev);
+
+       if (pm_runtime_suspended(dev))
+               return 0;
+
+       if (pdev)
+               omap_device_enable(pdev);
+
+       omap2430_low_level_init(musb);
+       musb_writel(musb->mregs, OTG_INTERFSEL,
+                                       musb->context.otg_interfsel);
+
+       otg_set_suspend(musb->xceiv, 0);
+
+       return 0;
+}


Michael



> Michael
>
>>
>> Michael



-- 
| Michael Nazzareno Trimarchi                     Amarula Solutions BV |
| COO  -  Founder
Cruquiuskade 47 |
| +31(0)851119172                                   Amsterdam 1018 AM NL |
