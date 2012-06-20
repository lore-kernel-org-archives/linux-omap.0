From: Russ Dill <Russ.Dill-l0cyMroinI0@public.gmane.org>
Subject: Oops on boot for omap3xxx, EHCI fails.
Date: Wed, 20 Jun 2012 02:41:10 -0700
Message-ID: <CA+Bv8XZ-g26_3Hv9xgDvwRooUeZwaKtZJwvnxxEZHcFx06es7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>, Volodymyr Mieshkov <x0182794-l0cyMroinI0@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, yan-liu-l0cyMroinI0@public.gmane.org, aparnab-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

[PATCH] Fix OMAP EHCI suspend/resume failure (i693) '354ab856' causes
an oops on boot for all omap3xxx platforms that use usbhs_omap for
EHCI. The actual oops seems to come from faulty ehci-omap cleanup, but
the failure caused by the change is evidenced here:

[    3.655059] ehci-omap ehci-omap.0: utmi_p1_gfclk failed error:-2
[    3.661376] ehci-omap: probe of ehci-omap.0 failed with error -2

The problem is the call:

omap->utmi_p1_fck = clk_get(dev, "utmi_p1_gfclk");

Where dev here is ehci-omap. As shown below, clk_get will fail with
dev_id "ehci-omap" and clk_id "utmi_p1_gfclk" (but succeed on
omap44xx).

arch/arm/mach-omap2/clock3xxx_data.c:   CLK("usbhs_omap",       "utmi_p1_gfclk",
arch/arm/mach-omap2/clock44xx_data.c:   CLK(NULL,       "utmi_p1_gfclk",

The oops caused by bad cleanup is shown below:

[    3.951934] Unable to handle kernel NULL pointer dereference at
virtual address 00000000
[    3.960418] pgd = c0004000
[    3.963256] [00000000] *pgd=00000000
[    3.967010] Internal error: Oops: 5 [#1] SMP ARM
[    3.971801] Modules linked in:
[    3.975006] CPU: 0    Not tainted  (3.5.0-rc1-ktest-00040-g354ab85 #401)
[    3.981964] PC is at hub_port_init+0x28c/0x968
[    3.986602] LR is at hub_port_init+0xc4/0x968
[    3.991119] pc : [<c03304f8>]    lr : [<c0330330>]    psr: 60000013
[    3.991119] sp : de11deb8  ip : c05eae4c  fp : 00000000
[    4.003082] r10: 00000000  r9 : de38ac00  r8 : 00000032
[    4.008514] r7 : de388800  r6 : 00000002  r5 : 00000000  r4 : de391800
[    4.015289] r3 : 00000000  r2 : c05de444  r1 : c05de468  r0 : de391868
[    4.022094] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM
Segment kernel
[    4.029693] Control: 10c5387d  Table: 80004019  DAC: 00000017
[    4.035675] Process khubd (pid: 242, stack limit = 0xde11c2f8)
[    4.041748] Stack: (0xde11deb8 to 0xde11e000)
[    4.046264] dea0:
    00000002 de38ac00
[    4.054779] dec0: 00000002 00000000 00000004 c00891b0 00000001
00000002 00000003 de378000
[    4.063293] dee0: 00000000 c0479d28 00000001 de391800 de388800
de378000 de378018 de38ac00
[    4.071807] df00: 00000002 00000000 00000002 c0333d68 00000501
00000000 c05df1b0 c069d600
[    4.080322] df20: 10a5bb6a de38ac08 de388420 de38889c de388400
00000004 de38ac70 de38ac01
[    4.088806] df40: de388800 de38ac68 de388800 de388420 de378000
00000009 de11df8c c0064834
[    4.097320] df60: 00000000 de11c000 00000000 de11f440 c005c75c
de11df74 de11df74 00000000
[    4.105834] df80: 00000501 c00891b0 de02ff18 de02fef0 00000000
c03336fc 00000013 00000000
[    4.114349] dfa0: 00000000 00000000 00000000 c005c064 00000000
00000000 00000000 00000000
[    4.122863] dfc0: 00000000 dead4ead ffffffff ffffffff c0747830
00000000 00000000 c0597cd0
[    4.131378] dfe0: de11dfe0 de11dfe0 de02fef0 c005bfe0 c0014154
c0014154 00000200 00000000
[    4.139892] [<c03304f8>] (hub_port_init+0x28c/0x968) from
[<c0333d68>] (hub_thread+0x66c/0x13d8)
[    4.149047] [<c0333d68>] (hub_thread+0x66c/0x13d8) from
[<c005c064>] (kthread+0x84/0x90)
[    4.157501] [<c005c064>] (kthread+0x84/0x90) from [<c0014154>]
(kernel_thread_exit+0x0/0x8)
[    4.166168] Code: e59f2690 e5933080 e2840068 e59f1688 (e593e000)
[    4.172607] ---[ end trace f11541c260e8a205 ]---
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
