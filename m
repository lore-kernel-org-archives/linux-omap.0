From: Bryan Wu <bryan.wu@canonical.com>
Subject: Re: [PATCH 1/6] ARM: Add inline function smp_on_up() for early init testing
Date: Thu, 9 Sep 2010 11:45:18 +0800
Message-ID: <AANLkTikZSws0ORT5Lvdt90_7n9ap8yB8RUEV8KzzT_2P@mail.gmail.com>
References: <20100820120622.GL25742@atomide.com>
	<20100830225527.GC11597@atomide.com>
	<20100902133637.GJ26319@n2100.arm.linux.org.uk>
	<20100902161659.GJ11597@atomide.com>
	<20100902161846.GK11597@atomide.com>
	<20100902170830.GW26319@n2100.arm.linux.org.uk>
	<20100902174244.GU11597@atomide.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02CCFE75A2@dbde02.ent.ti.com>
	<AANLkTik2FNBv-72C4L7PxBoMsTENSds-PvbAzxGd-h4y@mail.gmail.com>
	<20100908032642.GL22507@atomide.com>
	<20100908202611.GV22507@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:58074 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751152Ab0IIDpT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Sep 2010 23:45:19 -0400
Received: by vws3 with SMTP id 3so879208vws.19
        for <linux-omap@vger.kernel.org>; Wed, 08 Sep 2010 20:45:18 -0700 (PDT)
In-Reply-To: <20100908202611.GV22507@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Will Deacon <will.deacon@arm.com>

Tony,

Awesome, this makes SMP kernel work on my omap3 board.
Thanks a lot. I will test the same kernel on my omap4 one.

-Bryan.

On Thu, Sep 9, 2010 at 4:26 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Tony Lindgren <tony@atomide.com> [100907 20:19]:
>> * Bryan Wu <bryan.wu@canonical.com> [100906 03:09]:
>> > Tony,
>> >
>> > I tried your latest branch: devel-smp-on-unicore, kernel boots up =
but
>> > got lots of WARN_ON fired:
>> >
>> > ---
>> > ------------[ cut here ]------------
>> > [ =A0 =A01.149719] WARNING: at mm/percpu-vm.c:320 pcpu_alloc+0x2fc=
/0x888()
>> > [ =A0 =A01.149780] Modules linked in:
>> > [ =A0 =A01.149841] [<c01b34c8>] (unwind_backtrace+0x0/0xe4) from
>> > [<c01e939c>] (warn_slowpath_common+0x4c/0x64)
>> > [ =A0 =A01.149902] [<c01e939c>] (warn_slowpath_common+0x4c/0x64) f=
rom
>> > [<c01e93cc>] (warn_slowpath_null+0x18/0x1c)
>> > [ =A0 =A01.149993] [<c01e93cc>] (warn_slowpath_null+0x18/0x1c) fro=
m
>> > [<c0274730>] (pcpu_alloc+0x2fc/0x888)
>> > [ =A0 =A01.150085] [<c0274730>] (pcpu_alloc+0x2fc/0x888) from [<c0=
279578>]
>> > (sget+0x198/0x43c)
>> > [ =A0 =A01.150146] [<c0279578>] (sget+0x198/0x43c) from [<c0279adc=
>]
>> > (get_sb_ns+0x20/0x90)
>> > [ =A0 =A01.150238] [<c0279adc>] (get_sb_ns+0x20/0x90) from [<c0279=
1a4>]
>> > (vfs_kern_mount+0x9c/0x18c)
>> > [ =A0 =A01.150299] [<c02791a4>] (vfs_kern_mount+0x9c/0x18c) from
>> > [<c0022280>] (init_mqueue_fs+0x68/0xc8)
>> > [ =A0 =A01.150390] [<c0022280>] (init_mqueue_fs+0x68/0xc8) from
>> > [<c01ac5d0>] (do_one_initcall+0xcc/0x1a4)
>> > [ =A0 =A01.150451] [<c01ac5d0>] (do_one_initcall+0xcc/0x1a4) from
>> > [<c0008760>] (kernel_init+0x148/0x210)
>> > [ =A0 =A01.150543] [<c0008760>] (kernel_init+0x148/0x210) from
>> > [<c01adcf8>] (kernel_thread_exit+0x0/0x8)
>> > [ =A0 =A01.150604] ---[ end trace 1b75b31a2719ed74 ]---
>> > ---
>> >
>> > It looks like we still missed to set some flag for chuck.
>>
>> Yeah I think there's some .config option that needs to be handled
>> properly to fix this.
>
> This seems to disappear when CONFIG_LOCK_STAT is disabled,
> I wonder why?
>
> Here are my current changes to omap3_defconfig that I use for testing=
=2E
>
> Tony
> --- a/arch/arm/configs/omap3_defconfig
> +++ b/arch/arm/configs/omap3_defconfig
> @@ -55,6 +55,7 @@ CONFIG_MACH_OMAP_4430SDP=3Dy
> =A0CONFIG_ARM_THUMBEE=3Dy
> =A0CONFIG_NO_HZ=3Dy
> =A0CONFIG_HIGH_RES_TIMERS=3Dy
> +CONFIG_SMP=3Dy
> =A0CONFIG_AEABI=3Dy
> =A0CONFIG_LEDS=3Dy
> =A0CONFIG_ZBOOT_ROM_TEXT=3D0x0
> @@ -218,9 +219,9 @@ CONFIG_USB_DEVICEFS=3Dy
> =A0CONFIG_USB_SUSPEND=3Dy
> =A0# CONFIG_USB_OTG_WHITELIST is not set
> =A0CONFIG_USB_MON=3Dy
> -CONFIG_USB_MUSB_HDRC=3Dy
> -CONFIG_USB_MUSB_OTG=3Dy
> -CONFIG_USB_GADGET_MUSB_HDRC=3Dy
> +# CONFIG_USB_MUSB_HDRC is not set
> +# CONFIG_USB_MUSB_OTG is not set
> +# CONFIG_USB_GADGET_MUSB_HDRC is not set
> =A0CONFIG_USB_MUSB_DEBUG=3Dy
> =A0CONFIG_USB_WDM=3Dy
> =A0CONFIG_USB_STORAGE=3Dy
> @@ -276,7 +277,7 @@ CONFIG_DEBUG_KERNEL=3Dy
> =A0CONFIG_SCHEDSTATS=3Dy
> =A0CONFIG_TIMER_STATS=3Dy
> =A0CONFIG_PROVE_LOCKING=3Dy
> -CONFIG_LOCK_STAT=3Dy
> +# CONFIG_LOCK_STAT is not set
> =A0CONFIG_DEBUG_SPINLOCK_SLEEP=3Dy
> =A0# CONFIG_DEBUG_BUGVERBOSE is not set
> =A0CONFIG_DEBUG_INFO=3Dy
>



--=20
Bryan Wu <bryan.wu@canonical.com>
Kernel Developer =A0 =A0+86.138-1617-6545 Mobile
Ubuntu Kernel Team
Canonical Ltd. =A0 =A0 =A0www.canonical.com
Ubuntu - Linux for human beings | www.ubuntu.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
