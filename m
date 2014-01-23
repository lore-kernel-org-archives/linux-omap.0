From: Tero Kristo <t-kristo@ti.com>
Subject: Re: next boot: 34 pass, 5 fail (next-20140122)
Date: Thu, 23 Jan 2014 14:27:32 +0200
Message-ID: <52E10AB4.9060002@ti.com>
References: <52e06652.c103450a.79d7.6517@mx.google.com> <CAGa+x86=gKh11g1pzLqxdimeCxuZ478+ZAxd9GjO-m7Aa8L2fg@mail.gmail.com> <52E0B569.8000809@ti.com> <52E0CF58.5040109@epfl.ch> <52E0DA13.9090302@ti.com> <52E0DD9F.8000100@epfl.ch> <52E0E3D1.5050202@epfl.ch>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="------------040208030902030408020203"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59754 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751359AbaAWM1o (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Jan 2014 07:27:44 -0500
In-Reply-To: <52E0E3D1.5050202@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: florian.vaussard@epfl.ch, Kevin Hilman <khilman@linaro.org>, kernel-build-reports@lists.linaro.org, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "tony@atomide.com" <tony@atomide.com>
Cc: Mike Turquette <mturquette@linaro.org>, linux-omap <linux-omap@vger.kernel.org>, Olof Johansson <olof@lixom.net>, Ash Charles <ash@gumstix.com>

--------------040208030902030408020203
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

On 01/23/2014 11:41 AM, Florian Vaussard wrote:
>
>
> On 01/23/2014 10:15 AM, Florian Vaussard wrote:
>>
>>
>> On 01/23/2014 10:00 AM, Tero Kristo wrote:
>>> On 01/23/2014 10:14 AM, Florian Vaussard wrote:
>>>> Hello,
>>>>
>>>> On 01/23/2014 07:23 AM, Tero Kristo wrote:
>>>>> On 01/23/2014 03:35 AM, Kevin Hilman wrote:
>>>>>> On Wed, Jan 22, 2014 at 4:46 PM, Kevin's boot bot <khilman@linaro.org>
>>>>>> wrote:
>>>>>>> Automated DT boot report for various ARM defconfigs.
>>>>>>>
>>>>>>>
>>>>>>> Tree/Branch: next
>>>>>>> Git describe: next-20140122
>>>>>>> Failed boot tests (console logs at the end)
>>>>>>> ===========================================
>>>>>>>            omap3-tobi,3730storm:     FAIL:    omap2plus_defconfig
>>>>>> [...]
>>>>>>>            omap3-tobi,3730storm:     FAIL:    multi_v7_defconfig
>>>>>>
>>>>>> These OMAP3 failures are new regressions.  Full failure boot log
>>>>>> attached.
>>>>>> Bisected down to:
>>>>>>
>>>>>> cfa9667d4ac9da8b3ba2269f934ecd69ae504d39 is the first bad commit
>>>>>> commit cfa9667d4ac9da8b3ba2269f934ecd69ae504d39
>>>>>> Author: Tero Kristo <t-kristo@ti.com>
>>>>>> Date:   Tue Oct 22 11:53:02 2013 +0300
>>>>>>
>>>>>>        ARM: OMAP2+: io: use new clock init API
>>>>>>
>>>>>>        clk_init is now separated to a common function which gets called
>>>>>> for all
>>>>>>        SoC:s, which initializes the DT clocks and calls the SoC specific
>>>>>> clock init.
>>>>>>
>>>>>>        Signed-off-by: Tero Kristo <t-kristo@ti.com>
>>>>>>        Acked-by: Tony Lindgren <tony@atomide.com>
>>>>>>        Signed-off-by: Mike Turquette <mturquette@linaro.org>
>>>>>>
>>>>>> Kevin
>>>>>>
>>>>>
>>>>> Hi,
>>>>>
>>>>> I think this is because the tobi board is including wrong omap3-soc.dtsi
>>>>> file (omap34xx.dtsi) through omap3-overo.dtsi.
>>>>>
>>>>> The board should include omap36xx.dtsi at least based on the boot log:
>>>>>
>>>>> [    0.000000] OMAP3630 ES1.2 (l2cache iva sgx neon isp 192mhz_clk )
>>>>>
>>>>
>>>> The problem is that the Overo (processor card on the Tobi extension
>>>> board) can have a variety of processor depending on the exact model:
>>>>
>>>> - OMAP 35xx (1st generation: Air, Earth, Fire, Sand, Tide, Water, FE)
>>>> - OMAP 3730
>>>> - AM/DM 37xx
>>>>
>>>> omap3-overo.dtsi includes omap34xx.dtsi to be compatible with the first
>>>> generation.
>>>>
>>>>
>>>> omap34xx.dtsi
>>>>        |
>>>>        -> omap3-overo.dtsi (processor card)
>>>>                   |
>>>>                   -> omap3-tobi.dtsi (expansion board)
>>>>
>>>>
>>>> What is the fundamental incompatibility here? If we have to specifically
>>>> include omap36xx for newer Overo, it will become hard to maintain as it
>>>> will double the number of Overo / expansion boards possibilities.
>>>
>>> Well, you get different board declaration inside
>>> mach-omap2/board-generic.c for omap34xx vs omap36xx.
>>>
>>> The clock data issues can be fixed by adding cpu_is_omap34xx() vs.
>>> cpu_is_omap3630() checks within the mach-omap2/io.c file, but this is
>>> probably for Tony/Kevin to comment whether we can/should do that.
>>>
>>
>> I just tested next-20140123 with an OMAP3630 ES1.2 Overo/Tobi. Changing
>> the include to omap36xx.dtsi do not fix the issue. I still get the
>> external abort on non-linefetch (full log here [1]).
>>
>
> So the issue is clearly caused by the hwmod warning just before the
> panic I think:
>
> omap_hwmod: usb_tll_hs: enabled state can only be entered from
> initialized, idle, or disabled state
>
> usb_tll_hs is thus not enabled, and we get a panic when trying to read
> the revision register
>
>          ver =  usbtll_read(tll->base, OMAP_USBTLL_REVISION);
>
> at drivers/mfd/omap-usb-tll.c:237.
>
> I do not know enough about hwmod to efficiently debug why usb_tll_hs is
> not _HWMOD_STATE_INITIALIZED before trying to enable it. Are we missing
> some DT data?

The problem is the point before this one, uart4_fck lookup fails. This 
causes the hwmod code to bail out early and not init anything after it.

I guess you are still mapping wrong clock init as it fails with uart4. 
Give the attached patch a shot and see how it behaves.

-Tero

--------------040208030902030408020203
Content-Type: text/x-patch;
	name="0001-ARM-OMAP3-change-all-omap3-boards-to-use-common-earl.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-ARM-OMAP3-change-all-omap3-boards-to-use-common-earl.pa";
	filename*1="tch"

>From b42055fb5c1712348a757d766dbd7c09140cfe66 Mon Sep 17 00:00:00 2001
From: Tero Kristo <t-kristo@ti.com>
Date: Thu, 23 Jan 2014 14:24:57 +0200
Subject: [PATCH] ARM: OMAP3: change all omap3 boards to use common early_init

early_init now checks the cpu type for the corresponding clock init
function. Mainly needed by the overo board which can have almost
any OMAP3 subtype installed on it.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c        |    2 +-
 arch/arm/mach-omap2/board-am3517crane.c    |    2 +-
 arch/arm/mach-omap2/board-am3517evm.c      |    2 +-
 arch/arm/mach-omap2/board-cm-t35.c         |    4 ++--
 arch/arm/mach-omap2/board-cm-t3517.c       |    2 +-
 arch/arm/mach-omap2/board-devkit8000.c     |    2 +-
 arch/arm/mach-omap2/board-generic.c        |    8 +++----
 arch/arm/mach-omap2/board-ldp.c            |    2 +-
 arch/arm/mach-omap2/board-omap3logic.c     |    4 ++--
 arch/arm/mach-omap2/board-omap3pandora.c   |    2 +-
 arch/arm/mach-omap2/board-omap3stalker.c   |    2 +-
 arch/arm/mach-omap2/board-omap3touchbook.c |    2 +-
 arch/arm/mach-omap2/board-overo.c          |    2 +-
 arch/arm/mach-omap2/board-rx51.c           |    2 +-
 arch/arm/mach-omap2/io.c                   |   35 +++++++---------------------
 15 files changed, 27 insertions(+), 46 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index d95d0ef..a1a5413 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -623,7 +623,7 @@ MACHINE_START(OMAP_3430SDP, "OMAP3430 3430SDP board")
 	.atag_offset	= 0x100,
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
-	.init_early	= omap3430_init_early,
+	.init_early	= omap3_init_early,
 	.init_irq	= omap3_init_irq,
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap_3430sdp_init,
diff --git a/arch/arm/mach-omap2/board-am3517crane.c b/arch/arm/mach-omap2/board-am3517crane.c
index 0d499a1..d44f029 100644
--- a/arch/arm/mach-omap2/board-am3517crane.c
+++ b/arch/arm/mach-omap2/board-am3517crane.c
@@ -140,7 +140,7 @@ MACHINE_START(CRANEBOARD, "AM3517/05 CRANEBOARD")
 	.atag_offset	= 0x100,
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
-	.init_early	= am35xx_init_early,
+	.init_early	= omap3_init_early,
 	.init_irq	= omap3_init_irq,
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= am3517_crane_init,
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 543d9a8..22ce07f 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -369,7 +369,7 @@ MACHINE_START(OMAP3517EVM, "OMAP3517/AM3517 EVM")
 	.atag_offset	= 0x100,
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
-	.init_early	= am35xx_init_early,
+	.init_early	= omap3_init_early,
 	.init_irq	= omap3_init_irq,
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= am3517_evm_init,
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 8dd0ec8..5296dd0 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -748,7 +748,7 @@ MACHINE_START(CM_T35, "Compulab CM-T35")
 	.atag_offset	= 0x100,
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
-	.init_early	= omap35xx_init_early,
+	.init_early	= omap3_init_early,
 	.init_irq	= omap3_init_irq,
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= cm_t35_init,
@@ -761,7 +761,7 @@ MACHINE_START(CM_T3730, "Compulab CM-T3730")
 	.atag_offset	= 0x100,
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
-	.init_early	= omap3630_init_early,
+	.init_early	= omap3_init_early,
 	.init_irq	= omap3_init_irq,
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= cm_t3730_init,
diff --git a/arch/arm/mach-omap2/board-cm-t3517.c b/arch/arm/mach-omap2/board-cm-t3517.c
index 4eb5e6f..37d8577 100644
--- a/arch/arm/mach-omap2/board-cm-t3517.c
+++ b/arch/arm/mach-omap2/board-cm-t3517.c
@@ -327,7 +327,7 @@ MACHINE_START(CM_T3517, "Compulab CM-T3517")
 	.atag_offset	= 0x100,
 	.reserve        = omap_reserve,
 	.map_io		= omap3_map_io,
-	.init_early	= am35xx_init_early,
+	.init_early	= omap3_init_early,
 	.init_irq	= omap3_init_irq,
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= cm_t3517_init,
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index cdc4fb9..4836c19 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -645,7 +645,7 @@ MACHINE_START(DEVKIT8000, "OMAP3 Devkit8000")
 	.atag_offset	= 0x100,
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
-	.init_early	= omap35xx_init_early,
+	.init_early	= omap3_init_early,
 	.init_irq	= omap3_init_irq,
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= devkit8000_init,
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 8d972ff1..d1d211f 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -85,7 +85,7 @@ static const char *omap3_boards_compat[] __initdata = {
 DT_MACHINE_START(OMAP3_DT, "Generic OMAP3 (Flattened Device Tree)")
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
-	.init_early	= omap3430_init_early,
+	.init_early	= omap3_init_early,
 	.init_irq	= omap_intc_of_init,
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap_generic_init,
@@ -103,7 +103,7 @@ static const char *omap36xx_boards_compat[] __initdata = {
 DT_MACHINE_START(OMAP36XX_DT, "Generic OMAP36xx (Flattened Device Tree)")
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
-	.init_early	= omap3630_init_early,
+	.init_early	= omap3_init_early,
 	.init_irq	= omap_intc_of_init,
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap_generic_init,
@@ -122,7 +122,7 @@ static const char *omap3_gp_boards_compat[] __initdata = {
 DT_MACHINE_START(OMAP3_GP_DT, "Generic OMAP3-GP (Flattened Device Tree)")
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
-	.init_early	= omap3430_init_early,
+	.init_early	= omap3_init_early,
 	.init_irq	= omap_intc_of_init,
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap_generic_init,
@@ -140,7 +140,7 @@ static const char *am3517_boards_compat[] __initdata = {
 DT_MACHINE_START(AM3517_DT, "Generic AM3517 (Flattened Device Tree)")
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
-	.init_early	= am35xx_init_early,
+	.init_early	= omap3_init_early,
 	.init_irq	= omap_intc_of_init,
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap_generic_init,
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 44a59c3..6534c4a 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -420,7 +420,7 @@ MACHINE_START(OMAP_LDP, "OMAP LDP board")
 	.atag_offset	= 0x100,
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
-	.init_early	= omap3430_init_early,
+	.init_early	= omap3_init_early,
 	.init_irq	= omap3_init_irq,
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap_ldp_init,
diff --git a/arch/arm/mach-omap2/board-omap3logic.c b/arch/arm/mach-omap2/board-omap3logic.c
index bab51e6..0b942c4 100644
--- a/arch/arm/mach-omap2/board-omap3logic.c
+++ b/arch/arm/mach-omap2/board-omap3logic.c
@@ -228,7 +228,7 @@ MACHINE_START(OMAP3_TORPEDO, "Logic OMAP3 Torpedo board")
 	.atag_offset	= 0x100,
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
-	.init_early	= omap35xx_init_early,
+	.init_early	= omap3_init_early,
 	.init_irq	= omap3_init_irq,
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap3logic_init,
@@ -241,7 +241,7 @@ MACHINE_START(OMAP3530_LV_SOM, "OMAP Logic 3530 LV SOM board")
 	.atag_offset	= 0x100,
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
-	.init_early	= omap35xx_init_early,
+	.init_early	= omap3_init_early,
 	.init_irq	= omap3_init_irq,
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap3logic_init,
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index de1bc6b..bf256ed 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -620,7 +620,7 @@ MACHINE_START(OMAP3_PANDORA, "Pandora Handheld Console")
 	.atag_offset	= 0x100,
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
-	.init_early	= omap35xx_init_early,
+	.init_early	= omap3_init_early,
 	.init_irq	= omap3_init_irq,
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap3pandora_init,
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index 119efaf..d7245e3 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -428,7 +428,7 @@ MACHINE_START(SBC3530, "OMAP3 STALKER")
 	/* Maintainer: Jason Lam -lzg@ema-tech.com */
 	.atag_offset		= 0x100,
 	.map_io			= omap3_map_io,
-	.init_early		= omap35xx_init_early,
+	.init_early		= omap3_init_early,
 	.init_irq		= omap3_init_irq,
 	.handle_irq		= omap3_intc_handle_irq,
 	.init_machine		= omap3_stalker_init,
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index 7da48bc..8385192 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -386,7 +386,7 @@ MACHINE_START(TOUCHBOOK, "OMAP3 touchbook Board")
 	.atag_offset	= 0x100,
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
-	.init_early	= omap3430_init_early,
+	.init_early	= omap3_init_early,
 	.init_irq	= omap3_init_irq,
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap3_touchbook_init,
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index f6d3841..c3c2a7f 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -562,7 +562,7 @@ MACHINE_START(OVERO, "Gumstix Overo")
 	.atag_offset	= 0x100,
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
-	.init_early	= omap35xx_init_early,
+	.init_early	= omap3_init_early,
 	.init_irq	= omap3_init_irq,
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= overo_init,
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index db168c9..0ca29b9 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -132,7 +132,7 @@ MACHINE_START(NOKIA_RX51, "Nokia RX-51 board")
 	.atag_offset	= 0x100,
 	.reserve	= rx51_reserve,
 	.map_io		= omap3_map_io,
-	.init_early	= omap3430_init_early,
+	.init_early	= omap3_init_early,
 	.init_irq	= omap3_init_irq,
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= rx51_init,
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index b8097fe..fa9919d 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -483,34 +483,15 @@ void __init omap3_init_early(void)
 	omap3xxx_hwmod_init();
 	omap_hwmod_init_postsetup();
 	omap_clk_soc_init = omap3xxx_clk_init;
-}
-
-void __init omap3430_init_early(void)
-{
-	omap3_init_early();
-	if (of_have_populated_dt())
-		omap_clk_soc_init = omap3430_dt_clk_init;
-}
-
-void __init omap35xx_init_early(void)
-{
-	omap3_init_early();
-	if (of_have_populated_dt())
-		omap_clk_soc_init = omap3430_dt_clk_init;
-}
-
-void __init omap3630_init_early(void)
-{
-	omap3_init_early();
-	if (of_have_populated_dt())
-		omap_clk_soc_init = omap3630_dt_clk_init;
-}
 
-void __init am35xx_init_early(void)
-{
-	omap3_init_early();
-	if (of_have_populated_dt())
-		omap_clk_soc_init = am35xx_dt_clk_init;
+	if (of_have_populated_dt()) {
+		if (soc_is_am35xx())
+			omap_clk_soc_init = am35xx_dt_clk_init;
+		else if (cpu_is_omap3630())
+			omap_clk_soc_init = omap3630_dt_clk_init;
+		else if (cpu_is_omap34xx())
+			omap_clk_soc_init = omap3430_dt_clk_init;
+	}
 }
 
 void __init ti81xx_init_early(void)
-- 
1.7.9.5


--------------040208030902030408020203--
