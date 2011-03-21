From: John S <john.schi15@gmail.com>
Subject: Re: [GIT PULL] omap display subsystem changes for 2.6.39
Date: Mon, 21 Mar 2011 23:13:21 +0530
Message-ID: <AANLkTi=_zTJ0XeVC=MxqN6CzFqaXW0H6TbHEao3OihRb@mail.gmail.com>
References: <1300701083.2891.77.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:35032 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752604Ab1CURnY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Mar 2011 13:43:24 -0400
In-Reply-To: <1300701083.2891.77.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Paul Mundt <lethal@linux-sh.org>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org

On Mon, Mar 21, 2011 at 3:21 PM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
> Hi Paul,
>
> Here are OMAP display subsystem patches for 2.6.39 merge window. Quit=
e a
> bit of them, and many changes also in arch/arm/mach-omap2, which
> unfortunately couldn't go through Tony's linux-omap tree due to
> dependencies on DSS driver code.
>
> The patches are mostly aiming to get OMAP4 display support up and
> running and both HDMI and DVI outputs should now work on Blaze and Pa=
nda
> boards.
>
> One problem I noticed just now, the committer names seem a bit messed
> up. For example, Archit Taneja has three different style names there.=
 Do
> you think I should rebase and fix them? Not a big job, but it'll mean=
,
> well, rebasing.
>
> There's a minor conflict in Overo's board file. I have pushed
> "for-paul-merged" branch to gitorious, which contains a merge with
> Linus' tree. I'm not sure that is the best way to show how to fix the
> conflict, but hopefully it'll give the idea.
>
> =A0Tomi
>
>
> The following changes since commit a44f99c7efdb88fa41128065c9a9445c19=
894e34:
>
> =A0Merge branch 'trivial' of git://git.kernel.org/pub/scm/linux/kerne=
l/git/mmarek/kbuild-2.6 (2011-03-20 18:14:55 -0700)
>
> are available in the git repository at:
>
> =A0git://gitorious.org/linux-omap-dss2/linux.git for-paul
>
> Archit Taneja (9):
> =A0 =A0 =A0OMAP2PLUS: DSS2: Generalize naming of PRCM related clock e=
nums in DSS driver
> =A0 =A0 =A0OMAP2PLUS: DSS2: Generalize external clock names in struct=
 dss of dss.c
> =A0 =A0 =A0OMAP2PLUS: DSS2: FEATURES: DISPC overlay code cleanup
> =A0 =A0 =A0OMAP2PLUS: DSS2: FEATURES: Function to Provide the max fck=
 supported
> =A0 =A0 =A0OMAP2PLUS: DSS2: Make members of dss_clk_source generic
> =A0 =A0 =A0OMAP2PLUS: DSS2: Use dss features to get clock source name=
s of current OMAP
> =A0 =A0 =A0OMAP2PLUS: DSS2: DSI: Generalize DSI PLL Clock Naming
> =A0 =A0 =A0OMAP: DSS2: Functions to request/release DSI VCs
> =A0 =A0 =A0OMAP: DSS2: Use request / release calls in Taal for DSI Vi=
rtual Channels.
>
> Jani Nikula (1):
> =A0 =A0 =A0OMAP: DSS2: Fix def_disp module param description
>
> Janorkar, Mayuresh (2):
> =A0 =A0 =A0OMAPFB: Adding a check for timings in set_def_mode
> =A0 =A0 =A0OMAP: OMAPFB: Adding help for FB_OMAP_LCD_VGA option
>
> Jarkko Nikula (1):
> =A0 =A0 =A0omapfb: Fix linker error in drivers/video/omap/lcd_2430sdp=
=2Ec
>
> K, Mythri P (1):
> =A0 =A0 =A0OMAP4: HDMI: Add HDMI structure in the board file for OMAP=
4 PANDA
>
> Mayuresh Janorkar (2):
> =A0 =A0 =A0OMAP2PLUS: DSS2: Add OMAP4 Kconfig support
> =A0 =A0 =A0OMAP4: DSS2: Add hwmod device names for OMAP4.
>
> Murthy, Raghuveer (5):
> =A0 =A0 =A0OMAP: DSS2: Adding dss_features for independent core clk d=
ivider
> =A0 =A0 =A0OMAP: DSS2: Renaming register macro DISPC_DIVISOR(ch)
> =A0 =A0 =A0OMAP4: DSS2: Using dss_features to set independent core cl=
ock divider
> =A0 =A0 =A0OMAP: DSS2: Implement OMAP4 DSS fclk support
> =A0 =A0 =A0OMAP4: PandaBoard: Adding DVI support
>
> Mythri P K (9):
> =A0 =A0 =A0OMAP4: DSS2: Add display type HDMI to DSS2
> =A0 =A0 =A0OMAP4: DSS2: HDMI: Select between HDMI VENC clock source.
> =A0 =A0 =A0OMAP4: DSS2: HDMI: Dispc gamma enable set/reset function f=
or TV.
> =A0 =A0 =A0OMAP4: DSS2: HDMI: HDMI driver header file addition
> =A0 =A0 =A0OMAP4: DSS2: HDMI: HDMI driver addition in the DSS
> =A0 =A0 =A0OMAP4: DSS2: HDMI: HDMI panel driver addition in the DSS
> =A0 =A0 =A0OMAP4: DSS2: HDMI: Add makefile and kconfig changes to ena=
ble HDMI in OMAP4
> =A0 =A0 =A0OMAP4: DSS: HDMI: Call to HDMI module init to register dri=
ver.
> =A0 =A0 =A0OMAP4: HDMI: Add HDMI structure in the board file for OMAP=
4 SDP
>
> Samreen (1):
> =A0 =A0 =A0OMAP2/3/4: DSS2: Enable Display SubSystem as modules
>
> Semwal, Sumit (2):
> =A0 =A0 =A0OMAP2PLUS:DSS2: add opt_clock_available in pdata
> =A0 =A0 =A0OMAP2PLUS:DSS2: Use opt_clock_available from pdata
>
> Senthilvadivu Guruswamy (9):
> =A0 =A0 =A0OMAP2,3: DSS2: Build omap_device for each DSS HWIP
> =A0 =A0 =A0OMAP2, 3: DSS2: DSS: create platform_driver, move init, ex=
it to driver
> =A0 =A0 =A0OMAP2, 3: DSS2: Move clocks from core driver to dss driver
> =A0 =A0 =A0OMAP2, 3: DSS2: RFBI: create platform_driver, move init, e=
xit to driver
> =A0 =A0 =A0OMAP2, 3: DSS2: DISPC: create platform_driver, move init, =
exit to driver
> =A0 =A0 =A0OMAP2, 3: DSS2: VENC: create platform_driver, move init, e=
xit to driver
> =A0 =A0 =A0OMAP2, 3: DSS2: DSI: create platform_driver, move init, ex=
it to driver
> =A0 =A0 =A0OMAP2,3: DSS2: Use platform device to get baseaddr
> =A0 =A0 =A0OMAP2,3: DSS2: Get DSS IRQ from platform device
>
> Steve Sakoman (5):
> =A0 =A0 =A0OMAP: DSS2: Add support for LG Philips LB035Q02 panel
> =A0 =A0 =A0OMAP: DSS2: Add DSS2 support for Overo
> =A0 =A0 =A0omap: overo: Add regulator for ads7846
> =A0 =A0 =A0OMAP: Add gpio-leds support for Overo
> =A0 =A0 =A0OMAP: Add gpio-keys support for Overo
>
> Sumit Semwal (4):
> =A0 =A0 =A0OMAP2, 3: DSS2: remove forced clk-disable from omap_dss_re=
move
> =A0 =A0 =A0OMAP2,3: DSS2: replace printk with dev_dbg in init
> =A0 =A0 =A0OMAP2PLUS: clocks: Align DSS clock names and roles
> =A0 =A0 =A0OMAP4: DSS2: clocks: Add ick as dummy clock
>
> Taneja, Archit (5):
> =A0 =A0 =A0OMAP2PLUS: DSS2: Cleanup clock source related code
> =A0 =A0 =A0OMAP4: DSS2: Clock source changes for OMAP4
> =A0 =A0 =A0OMAP2PLUS: DSS2: FEATURES: Fix usage of dss_reg_field and =
dss_clk_source_name
> =A0 =A0 =A0OMAP: DSS2: FEATURES: Functions to return min and max valu=
es of parameters
> =A0 =A0 =A0OMAP: DSS2: FEATURES: DSI PLL parameter cleanup
>
> Tomi Valkeinen (25):
> =A0 =A0 =A0OMAP: 3430SDP: Remove unused vdda_dac supply
> =A0 =A0 =A0OMAP: DSS2: Delay regulator_get() calls
> =A0 =A0 =A0OMAP: DSS2: Support for Samsung LTE430WQ-F0C
> =A0 =A0 =A0MAINTAINERS: Update OMAP DSS maintainer
> =A0 =A0 =A0OMAP: DSS2: Clean up a switch-case
> =A0 =A0 =A0OMAP: DSS2: FEATURES: Remove SDI from 3630 displays
> =A0 =A0 =A0OMAP: DSS2: FEATURES: Remove DSI & SDI from OMAP2
> =A0 =A0 =A0OMAP: DSS2: Check for SDI HW before accessing SDI register=
s
> =A0 =A0 =A0OMAP: DSS2: Remove unused list
> =A0 =A0 =A0OMAP: DSS2: DSI: remove unused function
> =A0 =A0 =A0OMAP: DSS2: Remove FB_OMAP_BOOTLOADER_INIT support
> =A0 =A0 =A0OMAP: DSS2: Remove pdev argument from dpi_init
> =A0 =A0 =A0OMAP: DSS2: Move DPI & SDI init into DSS plat driver
> =A0 =A0 =A0OMAP: DSS2: Remove unneeded cpu_is_xxx checks
> =A0 =A0 =A0HACK: OMAP: DSS2: Fix OMAP2_DSS_USE_DSI_PLL
> =A0 =A0 =A0HACK: OMAP: DSS2: add delay after enabling clocks
> =A0 =A0 =A0OMAP: DSS2: fix omap_dispc_register_isr() fail path
> =A0 =A0 =A0HACK: OMAP: DSS2: VENC: disable VENC on OMAP4 to prevent c=
rash
> =A0 =A0 =A0OMAP: DSS2: DSI: Restructure IRQ handler
> =A0 =A0 =A0OMAP: DSS2: DSI: Add ISR support
> =A0 =A0 =A0OMAP: DSS2: DSI: use ISR in send_bta_sync
> =A0 =A0 =A0OMAP: DSS2: DSI: use ISR for BTA in framedone
> =A0 =A0 =A0OMAP: DSS2: DSI: catch DSI errors in send_bta_sync
> =A0 =A0 =A0OMAP: DSS2: DSI: fix IRQ debug prints
> =A0 =A0 =A0OMAP: DSS2: Clean up for dpll4_m4_ck handling
>
> archit taneja (1):
> =A0 =A0 =A0OMAP: DSS2: Have separate irq handlers for DISPC and DSI
>

some of these patches had problems related to HDMI:
http://www.spinics.net/lists/linux-omap/msg48740.html
Was this issue resolved?

> =A0MAINTAINERS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A04 +-
> =A0arch/arm/configs/omap2plus_defconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0 11 +
> =A0arch/arm/mach-omap2/board-3430sdp.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 =A06 +-
> =A0arch/arm/mach-omap2/board-4430sdp.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 75 ++
> =A0arch/arm/mach-omap2/board-cm-t35.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 =A02 +-
> =A0arch/arm/mach-omap2/board-devkit8000.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 12 +-
> =A0arch/arm/mach-omap2/board-igep0020.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0 10 +-
> =A0arch/arm/mach-omap2/board-omap3beagle.c =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 12 +-
> =A0arch/arm/mach-omap2/board-omap3evm.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0 12 +-
> =A0arch/arm/mach-omap2/board-omap3pandora.c =A0 =A0 =A0 =A0 =A0 | =A0=
 =A03 +-
> =A0arch/arm/mach-omap2/board-omap3stalker.c =A0 =A0 =A0 =A0 =A0 | =A0=
 12 +-
> =A0arch/arm/mach-omap2/board-omap4panda.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
203 +++-
> =A0arch/arm/mach-omap2/board-overo.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0357 +++++-
> =A0arch/arm/mach-omap2/board-rx51-peripherals.c =A0 =A0 =A0 | =A0 =A0=
2 +-
> =A0arch/arm/mach-omap2/board-zoom-peripherals.c =A0 =A0 =A0 | =A0 12 =
+-
> =A0arch/arm/mach-omap2/clock2420_data.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0 =A08 +-
> =A0arch/arm/mach-omap2/clock2430_data.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0 =A08 +-
> =A0arch/arm/mach-omap2/clock3xxx_data.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0 14 +-
> =A0arch/arm/mach-omap2/clock44xx_data.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0 15 +-
> =A0arch/arm/mach-omap2/display.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0 80 ++
> =A0arch/arm/mach-omap2/omap_hwmod_2420_data.c =A0 =A0 =A0 =A0 | =A0 1=
3 +-
> =A0arch/arm/mach-omap2/omap_hwmod_2430_data.c =A0 =A0 =A0 =A0 | =A0 1=
2 +-
> =A0arch/arm/mach-omap2/omap_hwmod_3xxx_data.c =A0 =A0 =A0 =A0 | =A0 2=
3 +-
> =A0arch/arm/plat-omap/include/plat/display.h =A0 =A0 =A0 =A0 =A0| =A0=
 15 +-
> =A0drivers/video/omap/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | =A0 =A07 +-
> =A0drivers/video/omap2/displays/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0 =A06 +
> =A0drivers/video/omap2/displays/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 =A01 +
> =A0drivers/video/omap2/displays/panel-generic-dpi.c =A0 | =A0 25 +
> =A0.../omap2/displays/panel-lgphilips-lb035q02.c =A0 =A0 =A0| =A0279 =
++++
> =A0drivers/video/omap2/displays/panel-taal.c =A0 =A0 =A0 =A0 =A0| =A0=
123 +-
> =A0drivers/video/omap2/dss/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0 14 +-
> =A0drivers/video/omap2/dss/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 =A02 +
> =A0drivers/video/omap2/dss/core.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0480 +-------
> =A0drivers/video/omap2/dss/dispc.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0335 ++++--
> =A0drivers/video/omap2/dss/display.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 35 +-
> =A0drivers/video/omap2/dss/dpi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0 45 +-
> =A0drivers/video/omap2/dss/dsi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0967 +++++++++++----
> =A0drivers/video/omap2/dss/dss.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0763 +++++++++--
> =A0drivers/video/omap2/dss/dss.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0153 ++-
> =A0drivers/video/omap2/dss/dss_features.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
163 ++-
> =A0drivers/video/omap2/dss/dss_features.h =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 27 +
> =A0drivers/video/omap2/dss/hdmi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | 1332 ++++++++++++++++++++
> =A0drivers/video/omap2/dss/hdmi.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0415 ++++++
> =A0drivers/video/omap2/dss/hdmi_omap4_panel.c =A0 =A0 =A0 =A0 | =A022=
2 ++++
> =A0drivers/video/omap2/dss/manager.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 13 +-
> =A0drivers/video/omap2/dss/overlay.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 10 +-
> =A0drivers/video/omap2/dss/rfbi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0128 ++-
> =A0drivers/video/omap2/dss/sdi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0 62 +-
> =A0drivers/video/omap2/dss/venc.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0128 ++-
> =A0drivers/video/omap2/omapfb/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 =A06 +-
> =A0drivers/video/omap2/omapfb/omapfb-main.c =A0 =A0 =A0 =A0 =A0 | =A0=
 23 +-
> =A051 files changed, 5323 insertions(+), 1362 deletions(-)
> =A0create mode 100644 drivers/video/omap2/displays/panel-lgphilips-lb=
035q02.c
> =A0create mode 100644 drivers/video/omap2/dss/hdmi.c
> =A0create mode 100644 drivers/video/omap2/dss/hdmi.h
> =A0create mode 100644 drivers/video/omap2/dss/hdmi_omap4_panel.c
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
