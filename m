From: Viral Mehta <Viral.Mehta-oonXi/34qI7c+919tysfdA@public.gmane.org>
Subject: RE: USB on omap2430
Date: Fri, 26 Mar 2010 16:38:11 +0530
Message-ID: <70376CA23424B34D86F1C7DE6B997343017F5D5BE7@VSHINMSMBX01.vshodc.lntinfotech.com>
References: <70376CA23424B34D86F1C7DE6B997343017F5D5BE1@VSHINMSMBX01.vshodc.lntinfotech.com>,<5A47E75E594F054BAF48C5E4FC4B92AB032221A9F3@dbde02.ent.ti.com>,<70376CA23424B34D86F1C7DE6B997343017F5D5BE3@VSHINMSMBX01.vshodc.lntinfotech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <70376CA23424B34D86F1C7DE6B997343017F5D5BE3-fVvhrSDAkVjuuPCCJ6VnObSn4PsL5ZDKvpI+GvaZM4lBDgjK7y7TUQ@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viral Mehta <Viral.Mehta-oonXi/34qI7c+919tysfdA@public.gmane.org>, "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

I enabled "earlyprintk" and I have copy+pasted crashdump at the end of the email.

It is not able to get "otg_get_transceiver()" since transceiver was never set.
OMAP2430 uses ISP1301 (grepped from SDP manual).
It is on I2C1 bus and address 0x2D if I read the manual correctly.

I think it was not initialised in platform_init.
arch/arm/mach-omap2/board-3430sdp.c
========= Present Code=========
static struct i2c_board_info __initdata sdp2430_i2c_boardinfo[] = {
    {
        I2C_BOARD_INFO("twl4030", 0x48),
        .flags = I2C_CLIENT_WAKE,
        .irq = INT_24XX_SYS_NIRQ,
        .platform_data = &sdp2430_twldata,
    },
};
==========================
I think it needs to be modified something like this
=============
static struct i2c_board_info __initdata sdp2430_i2c_boardinfo[] = {
    {
        I2C_BOARD_INFO("twl4030", 0x48),
        .flags = I2C_CLIENT_WAKE,
        .irq = INT_24XX_SYS_NIRQ,
        .platform_data = &sdp2430_twldata,
    },
};

static struct i2c_board_info __initdata sdp2430_i2c_1_boardinfo[] = {
    { /* for camera sensor */
        I2C_BOARD_INFO("ex3691", 0x48),
/*      .flags = I2C_CLIENT_WAKE,
        .irq = INT_24XX_SYS_NIRQ,
        .platform_data = &sdp2430_twldata,*/
    },
    {
      /* for camera transceiver */
        I2C_BOARD_INFO("isp1301_omap", 0x2D),
    },

};
==========================

I think we also need to make one change in ./arch/arm/mach-omap2/Kconfig
======== Present Code ========
config ARCH_OMAP2430
    bool "OMAP2430 support"
    depends on ARCH_OMAP24XX
=====================
This should be changed to
===============
config ARCH_OMAP2430
    bool "OMAP2430 support"
    depends on ARCH_OMAP24XX
    select ARCH_OMAP_OTG
====================

The changes are not in form of "git diff" since it had lots of my other debug prints.
But, I hope this makes sense. Do let me know your comments.
=========== Crash dump with earlyprintk=========
"Switching to clocksource gp timer
musb_hdrc: version 6.0, musb-dma, host, debug=0
HS USB OTG: no transceiver configured
musb_hdrc musb_hdrc: musb_init_controller failed with status -19
Unhandled fault: imprecise external abort (0xc06) at 0x00000000
Internal error: : c06 [#1] PREEMPT
last sysfs file:
Modules linked in:
CPU: 0    Not tainted  (2.6.33 #56)
PC is at musb_platform_suspend+0x20/0x88
LR is at musb_platform_suspend+0x1c/0x88
pc : [<c01e1d44>]    lr : [<c01e1d40>]    psr: a0000013
sp : c1c19e28  ip : 22222222  fp : c03a4b9c
r10: c03a4bc0  r9 : 00000000  r8 : c03bf7a8
r7 : c03c0dd0  r6 : 00000000  r5 : c1c5e8f8  r4 : c1c5e8f8
r3 : c03a4460  r2 : c1c59608  r1 : 480ac414  r0 : fa0ac414
Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 00c5387d  Table: 80004000  DAC: 00000017
Process swapper (pid: 1, stack limit = 0xc1c18268)
Stack: (0xc1c19e28 to 0xc1c1a000)
9e20:                   c1c5e8f8 c01e1db8 00000000 c01e0da0 ffffffed c1c5e8f8
9e40: 00000000 c001a9d0 00000005 c1c19e8c c03af81c ffffffff c03a4bb8 0000005c
9e60: fa0ac000 00000008 c1c5ba80 00000002 c1c18000 c03e34a4 00000000 c01710d8
9e80: c1c19ed4 00000000 000080d0 c1c0e7a8 00000000 60000013 00000007 60000013
9ea0: c1c000c0 c03483b8 60000013 c1c2f158 c1c18000 00000008 c1c2f158 c1c2ff98
9ec0: 00000000 c02a9208 00000000 c1c19ef8 00000000 c00ef1a8 c1c19ef8 c00eed74
9ee0: c1c2f158 c1c2ff98 c1c19ef8 00000000 c1c2ff98 c00ef8d8 c1c59608 c03a4bc0
9f00: c03a4bf4 c03c0dd0 c03c0dd0 c03bf7a8 00000000 00000000 00000000 c01b5184
9f20: c03a4bc0 c01b4288 c03a4bc0 c03a4bf4 c03c0dd0 c03c0dd0 c03bf7a8 c01b4394
9f40: 00000000 c1c19f50 c01b4334 c01b376c c1c034d8 c1c63e30 c03c0dd0 00000001
9f60: c03c0dd0 c1c5a8a0 c0019e90 c01b3cd8 c02c1d7c c02c1d7c c1c19f70 00000001
9f80: c03c0dd0 c03cd040 c0019e90 00000001 00000000 c01b4744 00000001 c03c0dbc
9fa0: c03cd040 c0019e90 00000001 00000000 00000000 c01b5514 c0021528 00000000
9fc0: c03cd040 c002736c c0019e90 c0171c98 00000000 c002173c c0021528 00000000
9fe0: 00000000 00000000 00000000 c0008868 00000000 c0028ea8 000a050a 02050d09
[<c01e1d44>] (musb_platform_suspend+0x20/0x88) from [<c01e1db8>] (musb_platform_exit+0xc/0x20)
[<c01e1db8>] (musb_platform_exit+0xc/0x20) from [<c01e0da0>] (musb_free+0x80/0xb4)
[<c01e0da0>] (musb_free+0x80/0xb4) from [<c001a9d0>] (musb_probe+0x998/0xb5c)
[<c001a9d0>] (musb_probe+0x998/0xb5c) from [<c01b5184>] (platform_drv_probe+0x18/0x1c)
[<c01b5184>] (platform_drv_probe+0x18/0x1c) from [<c01b4288>] (driver_probe_device+0xa0/0x14c)
[<c01b4288>] (driver_probe_device+0xa0/0x14c) from [<c01b4394>] (__driver_attach+0x60/0x84)
[<c01b4394>] (__driver_attach+0x60/0x84) from [<c01b376c>] (bus_for_each_dev+0x44/0x78)
[<c01b376c>] (bus_for_each_dev+0x44/0x78) from [<c01b3cd8>] (bus_add_driver+0x9c/0x228)
[<c01b3cd8>] (bus_add_driver+0x9c/0x228) from [<c01b4744>] (driver_register+0xa8/0x130)
[<c01b4744>] (driver_register+0xa8/0x130) from [<c01b5514>] (platform_driver_probe+0x18/0x98)
[<c01b5514>] (platform_driver_probe+0x18/0x98) from [<c002736c>] (do_one_initcall+0x54/0x190)
[<c002736c>] (do_one_initcall+0x54/0x190) from [<c0008868>] (kernel_init+0xa0/0x120)
[<c0008868>] (kernel_init+0xa0/0x120) from [<c0028ea8>] (kernel_thread_exit+0x0/0x8)
Code: 0a000018 e59f0064 ebf961d8 e59f105c (e3800001)
---[ end trace 1b75b31a2719ed1c ]---
"
________________________________________
From: Viral Mehta
Sent: Wednesday, March 24, 2010 3:06 PM
To: Gadiyar, Anand; linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Subject: RE: USB on omap2430

________________________________________
From: Gadiyar, Anand [gadiyar-l0cyMroinI0@public.gmane.org]
Sent: Wednesday, March 24, 2010 2:46 PM
To: Viral Mehta; linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Subject: RE: USB on omap2430

Viral Mehta wrote:
>>
>> I am working on OMAP2430 and for me with linux2.6.33, USB is
>> simply not working. Board is not even able to boot if I just
>> enable Host Support.
>

> Maybe someone on the linux-omap list would be able to help with
> this - so adding linux-omap to the cc.

> Are you using the 2430SDP or some other board? I don't think
> anyone has tried booting one of those with mainline kernels
> in a long time. Does the default config for your board work?

I am using OMAP2430SDP (4.0.1).
I started with omap_2430sdp_defconfig
As a side note, USB works fine with 2.6.14-V3 kernel taken from linux.omap.com

>Maybe we can help get this working. Can you enable CONFIG_DEBUG_LL
>and CONFIG_EARLY_PRINTK in your build, then add "earlyprintk" to
>your bootargs?

>> If there is a crash during boot-up, this will let us know.
Ok, I will do that.

>Also, do you know which transceiver you have on the board?
>(TWL4030 or ISP1504 or something else?)
No.

>> I am seeing some patches for OMAP2430 USB support since few days.
>> Anyone really tested USB on OMAP2430 hardware? Or any idea
>> whether it will work with head of linus tree or anything like that ?
>>

>I posted one such patch - to remove some pin muxing code that
>was under a CONFIG_ARCH_OMAP2430 macro - this code should not
>be in a generic driver. I did not test on an actual 2430 board
>because I don't have one.

The only intention behind asking that question was to know whether I am missing any patch which should have been applied on top of the kernel that I am using. I am using 2.6.33 (linux-2.6.33.tar.bz2).

- Anand

______________________________________________________________________

This Email may contain confidential or privileged information for the intended recipient (s) If you are not the intended recipient, please do not use or disseminate the information, notify the sender and delete it from your system.

______________________________________________________________________
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
