From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC/RFT PATCH v2 7/7] gpio: omap: ensure that runtime pm will
 disable unused gpio banks
Date: Fri, 22 May 2015 11:10:16 -0700
Message-ID: <20150522181016.GC10274@atomide.com>
References: <1432305354-5968-1-git-send-email-grygorii.strashko@linaro.org>
 <1432305354-5968-8-git-send-email-grygorii.strashko@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1432305354-5968-8-git-send-email-grygorii.strashko@linaro.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Javier Martinez Canillas <javier@dowhile0.org>, ssantosh@kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Grygorii Strashko <grygorii.strashko@linaro.org> [150522 07:37]:
> Now there are some points related to Runtime PM usage:
> 1) bank state doesn't need to be checked in places where
> Rintime PM is used, bacause Runtime PM maintains its
> own usage counter:
>       if (!BANK_USED(bank))
>                pm_runtime_get_sync(bank->dev);
> so, it's safe to drop such checks.
> 
> 2) Such implementation is racy, because check !BANK_USED(bank)
>    is not protected, like:
>  CPU0				CPU1
>  gpio_request(bankX.A)
>  ...
>  gpio_free(bankX.A)		gpio_request(bankX.Y)
> 
>  and bankX can be unpowered in the middle of processing
>  gpio_request(bankX.Y)
> 
> 3) There is a call of pm_runtime_get_sync() in omap_gpio_irq_type(),
> but no corresponding put. As result, GPIO devices could be
> powered on forever if at least one GPIO was used as IRQ.
> Hence, allow powering off GPIO banks by adding missed
> pm_runtime_put(bank->dev) at the end of omap_gpio_irq_type().
> 
> As, part of this change update omap2_gpio_xxxx_idle() functions
> to use pm_runtime_force_suspend()/pm_runtime_force_resume().
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@linaro.org>
> ---
> Changes in v2:
>  - omap2_gpio_xxxx_idle() functions switched to use 
>    pm_runtime_force_suspend()/pm_runtime_force_resume() API.
> 
> v1:
>     http://marc.info/?l=linux-gpio&m=142567003515626&w=2

This one causes an abort during boot on at least omap3.

Maybe try to get a beagleboard xm to test with? It has Ethernet
over USB though, so that does not work with PM over NFSroot.

If you want something to test with PM with mainline over
NFSroot, maybe you can get hold of some of the better supported
ones out of these boards:

$ git grep "ethernet@gpmc" arch/arm/boot/dts/*.dts*

For those Ethernet has a GPIO interrupt ;)

Regards,

Tony


[    6.150238] Unhandled fault: external abort on non-linefetch (0x1028) at 0xfb05601c
[    6.158355] pgd = c0004000
[    6.161224] [fb05601c] *pgd=49011452(bad)
[    6.165496] Internal error: : 1028 [#1] SMP ARM
[    6.170288] Modules linked in:
[    6.173522] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.1.0-rc4-next-20150522-00021-g6d8613e #94
[    6.182800] Hardware name: Generic OMAP36xx (Flattened Device Tree)
[    6.189422] task: c09b0678 ti: c09aa000 task.ti: c09aa000
[    6.195129] PC is at omap_gpio_irq_handler+0x9c/0x234
[    6.200469] LR is at trace_hardirqs_off+0x14/0x18
[    6.205444] pc : [<c03d9b68>]    lr : [<c0095924>]    psr: a0000193
[    6.205444] sp : c09abcf0  ip : c09abca8  fp : c09abd2c
[    6.217529] r10: c06786c0  r9 : fb056000  r8 : 00000000
[    6.223052] r7 : c59fa010  r6 : c5816300  r5 : 00000001  r4 : c59fa084
[    6.229949] r3 : ffffffff  r2 : fb05601c  r1 : c0a2461c  r0 : 0000001c
[    6.236846] Flags: NzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
[    6.244628] Control: 10c5387d  Table: 80004019  DAC: 00000015
[    6.250701] Process swapper/0 (pid: 0, stack limit = 0xc09aa218)
[    6.257049] Stack: (0xc09abcf0 to 0xc09ac000)
[    6.261657] bce0:                                     c09abd1c c5816300 c5802c64 fb056018
[    6.270294] bd00: 00000000 00000031 00000031 c09adacc 00000000 00000001 c5802000 c06786c0
[    6.278900] bd20: c09abd44 c09abd30 c00a674c c03d9ad8 00000177 c09a6110 c09abd6c c09abd48
[    6.287536] bd40: c00a6aa0 c00a6720 c12536c0 c09abd98 c0a22f40 00000021 00000001 00000001
[    6.296173] bd60: c09abd94 c09abd70 c0009510 c00a6a38 00001bb6 c0671c0c 20000113 ffffffff
[    6.304809] bd80: c09abdcc 00000001 c09abdf4 c09abd98 c06725e4 c0009464 00000001 00000001
[    6.313446] bda0: 00000000 00000000 a0000113 c09c610c a0000113 00000001 00000001 00000001
[    6.322082] bdc0: c06786c0 c09abdf4 c09abdb0 c09abde0 c0098d44 c0671c0c 20000113 ffffffff
[    6.330718] bde0: c09c60ac c09c610c c09abe14 c09abdf8 c002cd60 c0671bd4 c59ff200 00000000
[    6.339355] be00: c59ff240 00000000 c09abe2c c09abe18 c002e21c c002cd2c 00000000 c5a03010
[    6.347961] be20: c09abe44 c09abe30 c002e288 c002e1e0 c5a03010 c0a245dc c09abe5c c09abe48
[    6.356597] be40: c0446588 c002e268 c59fa010 c0a245dc c09abe7c c09abe60 c03da610 c044654c
[    6.365234] be60: fa306ae0 c0a64d28 00000003 00000000 c09abea4 c09abe80 c0030d4c c03da5cc
[    6.373870] be80: 00000001 00000008 00000002 c0a64d68 c06786b8 00000001 c09abedc c09abea8
[    6.382507] bea0: c00323a4 c0030c1c 65a0bc00 00000001 c0513e94 00000000 c09b3af4 6b46e923
[    6.391143] bec0: 00000001 c6e75380 00000003 00000000 c09abf2c c09abee0 c0512550 c003229c
[    6.399780] bee0: c09b3af4 000014a4 6b46e923 00000001 00000000 c09abf00 6b46e923 00000001
[    6.408386] bf00: 00000000 c09b3af4 c6e75380 00000003 c6e75380 c09b3af4 c09adacc c0679fa8
[    6.417022] bf20: c09abf4c c09abf30 c0512854 c05124c0 00000000 00000003 c0a5f8c8 c09ac988
[    6.425659] bf40: c09abf64 c09abf50 c008dc40 c051281c 00007530 c09ac9ec c09abf84 c09abf68
[    6.434295] bf60: c008de70 c008dc14 c09a7378 c09a34c4 c066cc98 c09ac8c0 c09abfac c09abf88
[    6.442932] bf80: c06653d4 c008dc74 00000000 00000000 c06652a0 ffffffff c0a64050 c0a64000
[    6.451568] bfa0: c09abff4 c09abfb0 c0921ccc c06652ac ffffffff ffffffff 00000000 c09216d4
[    6.460205] bfc0: 00000000 c0975368 00000000 c0a64214 c09ac96c c0975364 c09b20f0 80004059
[    6.468841] bfe0: 413fc082 00000000 00000000 c09abff8 8000807c c0921954 00000000 00000000
[    6.477508] [<c03d9b68>] (omap_gpio_irq_handler) from [<c00a674c>] (generic_handle_irq+0x38/0x4c)
[    6.486877] [<c00a674c>] (generic_handle_irq) from [<c00a6aa0>] (__handle_domain_irq+0x74/0xf0)
[    6.496063] [<c00a6aa0>] (__handle_domain_irq) from [<c0009510>] (omap_intc_handle_irq+0xb8/0xc8)
[    6.505432] [<c0009510>] (omap_intc_handle_irq) from [<c06725e4>] (__irq_svc+0x44/0x5c)
[    6.513854] Exception stack(0xc09abd98 to 0xc09abde0)
[    6.519195] bd80:                                                       00000001 00000001
[    6.527832] bda0: 00000000 00000000 a0000113 c09c610c a0000113 00000001 00000001 00000001
[    6.536468] bdc0: c06786c0 c09abdf4 c09abdb0 c09abde0 c0098d44 c0671c0c 20000113 ffffffff
[    6.545104] [<c06725e4>] (__irq_svc) from [<c0671c0c>] (_raw_spin_unlock_irqrestore+0x44/0x54)
[    6.554229] [<c0671c0c>] (_raw_spin_unlock_irqrestore) from [<c002cd60>] (omap_hwmod_idle+0x40/0x50)
[    6.563873] [<c002cd60>] (omap_hwmod_idle) from [<c002e21c>] (omap_device_idle+0x48/0x88)
[    6.572509] [<c002e21c>] (omap_device_idle) from [<c002e288>] (_od_runtime_suspend+0x2c/0x34)
[    6.581512] [<c002e288>] (_od_runtime_suspend) from [<c0446588>] (pm_runtime_force_suspend+0x48/0x84)
[    6.591247] [<c0446588>] (pm_runtime_force_suspend) from [<c03da610>] (omap2_gpio_prepare_for_idle+0x50/0x64)
[    6.601745] [<c03da610>] (omap2_gpio_prepare_for_idle) from [<c0030d4c>] (omap_sram_idle+0x13c/0x24c)
[    6.611480] [<c0030d4c>] (omap_sram_idle) from [<c00323a4>] (omap3_enter_idle_bm+0x114/0x228)
[    6.620483] [<c00323a4>] (omap3_enter_idle_bm) from [<c0512550>] (cpuidle_enter_state+0x9c/0x330)
[    6.629852] [<c0512550>] (cpuidle_enter_state) from [<c0512854>] (cpuidle_enter+0x44/0x50)
[    6.638580] [<c0512854>] (cpuidle_enter) from [<c008dc40>] (call_cpuidle+0x38/0x60)
[    6.646667] [<c008dc40>] (call_cpuidle) from [<c008de70>] (cpu_startup_entry+0x208/0x38c)
[    6.655303] [<c008de70>] (cpu_startup_entry) from [<c06653d4>] (rest_init+0x134/0x170)
[    6.663665] [<c06653d4>] (rest_init) from [<c0921ccc>] (start_kernel+0x384/0x3fc)
[    6.671569] [<c0921ccc>] (start_kernel) from [<8000807c>] (0x8000807c)
[    6.678466] Code: e1d101b4 e1a03315 e0822000 e2433001 (e5926000) 
[    6.684936] ---[ end trace 56ea2e3fa23d8248 ]---

