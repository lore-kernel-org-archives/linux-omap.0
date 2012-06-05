From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [GIT PULL] OMAP DSS for v3.5
Date: Tue, 5 Jun 2012 14:17:48 +0200
Message-ID: <CAORVsuXLhGCEHMbZB_8FrzfL-sMH76wMH9rdUjOzOfL06bLH4w@mail.gmail.com>
References: <1337681363.4125.10.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:40293 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980Ab2FEMRu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jun 2012 08:17:50 -0400
Received: by lbbgm6 with SMTP id gm6so3823482lbb.19
        for <linux-omap@vger.kernel.org>; Tue, 05 Jun 2012 05:17:48 -0700 (PDT)
In-Reply-To: <1337681363.4125.10.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-omap@vger.kernel.org, linux-fbdev <linux-fbdev@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

Hi Tomi,

On Tue, May 22, 2012 at 12:09 PM, Tomi Valkeinen <tomi.valkeinen@ti.com=
> wrote:
> Hi Florian,
>
> Here are the OMAP DSS changes for 3.5.
>
> I really tried this time to send the pull request early, but here I a=
m
> again, sending it when the merge window has already opened... A few
> late-found bugs caused some unnecessary delays.
>
> I'm using github this time instead of gitorious, as gitorious seems t=
o
> be down. This is my first pull request with a signed tag, I hope
> everything is correct.
>
> Note that there's a merge for small branch with omap board file chang=
es
> (e4a9e94cc58ed6e4efb02b80be3a9bf57f448d07) that is also pulled by Ton=
y
> for the linux-omap tree. This is meant to help avoid conflicts in the
> board files.
>
> =A0Tomi
>
>
> The following changes since commit 66f75a5d028beaf67c931435fdc3e78231=
25730c:
>
> =A0Linux 3.4-rc4 (2012-04-21 14:47:52 -0700)
>
> are available in the git repository at:
>
> =A0git://github.com/tomba/linux.git tags/omapdss-for-3.5
>
> for you to fetch changes up to e92a5b28f71aea01b281f9c89d97a4bc5b2474=
8f:
>
> =A0OMAPDSS: HDMI: OMAP4: Update IRQ flags for the HPD IRQ request (20=
12-05-22 11:00:09 +0300)
>
> ----------------------------------------------------------------
> Omapdss driver changes for 3.5 merge window.
>
> Lots of normal development commits, but perhaps most notable changes =
are:
>
> * HDMI rework to properly decouple the HDMI audio part from the HDMI =
video part.
> * Restructure omapdss core driver so that it's possible to implement =
device
> =A0tree support. This included changing how platform data is passed t=
o the
> =A0drivers, changing display device registration and improving the pa=
nel driver's
> =A0ability to configure the underlying video output interface.
> * Basic support for DSI packet interleaving
>

I am using a mainline kernel (3.5.0-rc1) with the patches below integra=
ted.
I have an issue with suspend/resume on OMAP3 Beagleboard, where the
system hangs at resume time.

Here below is a log with the option no_console_suspend set and a few
added messages in case of null pointer in _od_resume_noirq.
It looks like there is no omap_device associated to the "omapdss_dpi" p=
dev.

What do you think? How to fix this?
Sorry I know there have been some discussions on the lists but I am
not aware of all the details in the devices creation for DSS.

/ # echo mem > /sys/power/state
[   23.262298] PM: Syncing filesystems ... done.
[   23.295501] Freezing user space processes ... (elapsed 0.02 seconds)=
 done.
[   23.326507] Freezing remaining freezable tasks ... (elapsed 0.02 sec=
onds) don
e.
[   23.502197] PM: suspend of devices complete after 163.766 msecs
[   23.511932] PM: late suspend of devices complete after 3.418 msecs
[   23.524444] PM: noirq suspend of devices complete after 5.860 msecs
[   23.531249] Disabling non-boot CPUs ...
[   24.476562] Powerdomain (per_pwrdm) didn't enter target state 1
[   24.482818] Powerdomain (core_pwrdm) didn't enter target state 1
[   24.489166] Could not enter target state in pm_suspend
[   24.495147] *** _od_resume_noirq: od=3DNULL, dev=3D0xc78bcc08
[   24.500915] *** _od_resume_noirq: od=3DNULL, pdev=3D0xc78bcc00
[   24.506805] *** _od_resume_noirq: od=3DNULL, pdev->name:omapdss_dpi
[   24.513336] Unable to handle kernel NULL pointer dereference at virt=
ual addre
ss 00000018
[   24.521942] pgd =3D c62f0000
[   24.524841] [00000018] *pgd=3D862c1831, *pte=3D00000000, *ppte=3D000=
00000
[   24.531524] Internal error: Oops: 17 [#1] SMP ARM
[   24.536529] Modules linked in:
[   24.539764] CPU: 0    Not tainted  (3.5.0-rc1-00010-g5041caa-dirty #=
131)
[   24.546844] PC is at _od_resume_noirq+0x1c/0xac
[   24.551635] LR is at _od_resume_noirq+0x94/0xac
=2E..

Regards,
Jean

> ----------------------------------------------------------------
> Archit Taneja (19):
> =A0 =A0 =A0OMAPDSS: DISPC/RFBI: Use dispc_mgr_set_lcd_timings() for s=
etting lcd size
> =A0 =A0 =A0OMAPDSS: DISPC: Use a common function to set manager timin=
gs
> =A0 =A0 =A0OMAPDSS: DISPC: Clean up manager timing/size functions
> =A0 =A0 =A0OMAPDSS: HDMI: Fix ti_hdmi_4xxx_core_dump
> =A0 =A0 =A0OMAPDSS: HDMI: define and dump CORE registers in correct o=
rder
> =A0 =A0 =A0OMAPDSS: Fix DSI_FCLK clock source selection
> =A0 =A0 =A0OMAPDSS: DISPC: Remove Fake VSYNC support
> =A0 =A0 =A0OMAPDSS: APPLY: Add manager timings as extra_info in priva=
te data
> =A0 =A0 =A0OMAPDSS: Apply manager timings instead of direct DISPC wri=
tes
> =A0 =A0 =A0OMAPDSS: MANAGER: Create a function to check manager timin=
gs
> =A0 =A0 =A0OMAPDSS: APPLY: Don't check manager settings if it is disa=
bled
> =A0 =A0 =A0OMAPDSS: APPLY: Remove display dependency from overlay and=
 manager checks
> =A0 =A0 =A0OMAPDSS: DPI/HDMI: Apply manager timings even if panel is =
disabled
> =A0 =A0 =A0OMAPDSS: APPLY: Remove an unnecessary omap_dss_device poin=
ter
> =A0 =A0 =A0OMAPDSS: DISPC: Remove omap_dss_device pointer usage from =
dispc_mgr_pclk_rate()
> =A0 =A0 =A0OMAPDSS: DISPC: Remove usage of dispc_mgr_get_device()
> =A0 =A0 =A0OMAPDSS: DSI: Support command mode interleaving during vid=
eo mode blanking periods
> =A0 =A0 =A0OMAPDSS: VENC/DISPC: Delay dividing Y resolution for manag=
ers connected to VENC
> =A0 =A0 =A0OMAPDSS: Apply VENC timings even if panel is disabled
>
> Axel Castaneda Gonzalez (1):
> =A0 =A0 =A0OMAPDSS: HDMI: Decouple wrapper enable/disable and audio s=
tart/stop
>
> Chandrabhanu Mahapatra (5):
> =A0 =A0 =A0OMAPDSS: DISPC: Enable predecimation
> =A0 =A0 =A0OMAPDSS: DISPC: Handle synclost errors in OMAP3
> =A0 =A0 =A0OMAPDSS: DISPC: Correct DISPC functional clock usage
> =A0 =A0 =A0OMAPDSS: DISPC: Update Accumulator configuration for chrom=
a plane
> =A0 =A0 =A0OMAPDSS: DISPC: Support rotation through TILER
>
> Grazvydas Ignotas (5):
> =A0 =A0 =A0OMAPDSS: OMAPFB: check for matching memory size early
> =A0 =A0 =A0OMAPDSS: provide default get_timings function for panels
> =A0 =A0 =A0OMAPDSS: TPO-TD03MTEA1: add set/check timing functions
> =A0 =A0 =A0OMAPDSS: VENC: allow switching venc output type at runtime
> =A0 =A0 =A0OMAPDSS: OMAPFB: always allow to configure overlay
>
> Jan Weitzel (1):
> =A0 =A0 =A0ARM: OMAP2+ Add Primview displays to panel-generic
>
> Mark Brown (4):
> =A0 =A0 =A0OMAP: DSS2: Remove suspicous and unused TAAL regulator API=
 usage
> =A0 =A0 =A0OMAPDSS: VENC: Check for errors from regulator_enable()
> =A0 =A0 =A0OMAPDSS: TPO-TD03MTEA1: Check for errors from regulator_en=
able()
> =A0 =A0 =A0OMAPDSS: TPO-TD03MTEA1: Correct comment for power on delay
>
> Peter Meerwald (1):
> =A0 =A0 =A0OMAPFB: remove unused FB_OMAP_BOOTLOADER_INIT config optio=
n
>
> Ricardo Neri (15):
> =A0 =A0 =A0OMAPDSS: Provide an interface for audio support
> =A0 =A0 =A0OMAPDSS: HDMI: Split audio_enable into audio_enable/disabl=
e
> =A0 =A0 =A0OMAPDSS: HDMI: Split video_enable into video_enable/disabl=
e
> =A0 =A0 =A0OMAPDSS: HDMI: Remove ASoC codec
> =A0 =A0 =A0OMAPDSS: HDMI: OMAP4: Remove CEA-861 audio infoframe and I=
EC-60958 enums
> =A0 =A0 =A0OMAPDSS: HDMI: OMAP4: Remove invalid I2S settings
> =A0 =A0 =A0OMAPDSS: HDMI: Decouple HDMI audio from ASoC
> =A0 =A0 =A0OMAPDSS: HDMI: OMAP4: Expand configuration for IEC-60958 a=
udio
> =A0 =A0 =A0OMAPDSS: HDMI: Relocate N/CTS calculation
> =A0 =A0 =A0OMAPDSS: HDMI: Add support for more audio sample rates in =
N/CTS calculation
> =A0 =A0 =A0OMAPDSS: HDMI: Add an audio configuration function
> =A0 =A0 =A0OMAPDSS: HDMI: OMAP4: Remap speaker order to match ALSA or=
der
> =A0 =A0 =A0OMAPDSS: HDMI: Panel: Simplify the name of the HDMI mutex
> =A0 =A0 =A0OMAPDSS: HDMI: Implement DSS driver interface for audio
> =A0 =A0 =A0OMAPDSS: HDMI: OMAP4: Update IRQ flags for the HPD IRQ req=
uest
>
> Russ Dill (1):
> =A0 =A0 =A0OMAPDSS: TFP410: use gpio_set_value_cansleep
>
> Thomas Weber (2):
> =A0 =A0 =A0OMAPDSS: Add Mitsubishi AA084SB01 display support
> =A0 =A0 =A0OMAPDSS: Add EDT ET0500G0DH6 display support
>
> Tomi Valkeinen (38):
> =A0 =A0 =A0OMAPDSS: add set_min_bus_tput pointer to omapdss's platfor=
m data
> =A0 =A0 =A0OMAPDSS: Ensure OPP100 when DSS is operational
> =A0 =A0 =A0OMAPDSS: DSI: remove option to use pck for DSI PLL clkin
> =A0 =A0 =A0OMAPDSS: panel-dvi: add PD gpio handling
> =A0 =A0 =A0OMAP: board-files: remove custom PD GPIO handling for DVI =
output
> =A0 =A0 =A0OMAPDSS: TFP410: rename dvi -> tfp410
> =A0 =A0 =A0OMAPDSS: TFP410: rename dvi files to tfp410
> =A0 =A0 =A0OMAPDSS: Taal: move reset gpio handling to taal driver
> =A0 =A0 =A0OMAPDSS: DSI: implement generic DSI pin config
> =A0 =A0 =A0Merge branch 'archit/set-timing-work'
> =A0 =A0 =A0Merge branch 'for-l-o-3.5'
> =A0 =A0 =A0OMAPFB: fix parsing of vram parameter
> =A0 =A0 =A0OMAPDSS: TFP410: pdata rewrite
> =A0 =A0 =A0OMAPDSS: DSI: use dsi_get_dsidev_id(dsidev) instead of dsi=
dev->id
> =A0 =A0 =A0OMAPDSS: clean up the omapdss platform data mess
> =A0 =A0 =A0OMAPDSS: remove return from platform_driver_unreg
> =A0 =A0 =A0OMAPDSS: use platform_driver_probe for core/dispc/dss
> =A0 =A0 =A0OMAPDSS: create custom pdevs for DSS omap_devices
> =A0 =A0 =A0OMAPDSS: create DPI & SDI devices
> =A0 =A0 =A0OMAPDSS: create DPI & SDI drivers
> =A0 =A0 =A0OMAPDSS: remove uses of dss_runtime_get/put
> =A0 =A0 =A0OMAPDSS: handle output-driver reg/unreg more dynamically
> =A0 =A0 =A0OMAPDSS: move the creation of debugfs files
> =A0 =A0 =A0OMAPDSS: use platform_driver_probe for dsi/hdmi/rfbi/venc/=
dpi/sdi
> =A0 =A0 =A0OMAPDSS: add __init & __exit
> =A0 =A0 =A0OMAPFB: add __init & __exit
> =A0 =A0 =A0OMAPDSS: change default_device handling
> =A0 =A0 =A0OMAPDSS: interface drivers register their panel devices
> =A0 =A0 =A0OMAPDSS: init omap_dss_devices internally
> =A0 =A0 =A0OMAPDSS: DSI: improve DSI module id handling
> =A0 =A0 =A0OMAPDSS: separate pdata based initialization
> =A0 =A0 =A0Merge branch 'dss-devtree-cleanup'
> =A0 =A0 =A0Merge branch 'omapdss-hdmi-audio'
> =A0 =A0 =A0OMAPDSS: use DSI_FIFO_BUG workaround only for manual updat=
e displays
> =A0 =A0 =A0OMAPDSS: DISPC: fix usage of dispc_ovl_set_accu_uv
> =A0 =A0 =A0OMAPDSS: remove compiler warnings when CONFIG_BUG=3Dn
> =A0 =A0 =A0OMAPFB: remove compiler warnings when CONFIG_BUG=3Dn
> =A0 =A0 =A0OMAPDSS: VRFB: remove compiler warnings when CONFIG_BUG=3D=
n
>
> =A0Documentation/arm/OMAP/DSS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | =A0 46 ++
> =A0arch/arm/mach-omap2/board-3430sdp.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 38 +-
> =A0arch/arm/mach-omap2/board-4430sdp.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 37 +-
> =A0arch/arm/mach-omap2/board-am3517evm.c =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 25 +-
> =A0arch/arm/mach-omap2/board-cm-t35.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 30 +-
> =A0arch/arm/mach-omap2/board-devkit8000.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 30 +-
> =A0arch/arm/mach-omap2/board-igep0020.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0 32 +-
> =A0arch/arm/mach-omap2/board-omap3beagle.c =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 37 +-
> =A0arch/arm/mach-omap2/board-omap3evm.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0 29 +-
> =A0arch/arm/mach-omap2/board-omap3stalker.c =A0 =A0 =A0 =A0 =A0 | =A0=
 29 +-
> =A0arch/arm/mach-omap2/board-omap4panda.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 39 +-
> =A0arch/arm/mach-omap2/board-overo.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 25 +-
> =A0arch/arm/mach-omap2/display.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0196 ++++-
> =A0drivers/video/omap/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | =A0 =A08 -
> =A0drivers/video/omap2/displays/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0 =A08 +-
> =A0drivers/video/omap2/displays/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 =A02 +-
> =A0drivers/video/omap2/displays/panel-acx565akm.c =A0 =A0 | =A0 =A07 =
-
> =A0drivers/video/omap2/displays/panel-generic-dpi.c =A0 | =A0107 ++-
> =A0drivers/video/omap2/displays/panel-n8x0.c =A0 =A0 =A0 =A0 =A0| =A0=
 =A08 -
> =A0drivers/video/omap2/displays/panel-taal.c =A0 =A0 =A0 =A0 =A0| =A0=
108 +--
> =A0.../omap2/displays/{panel-dvi.c =3D> panel-tfp410.c} | =A0186 ++--=
-
> =A0.../video/omap2/displays/panel-tpo-td043mtea1.c =A0 =A0| =A0 22 +-
> =A0drivers/video/omap2/dss/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0 13 +-
> =A0drivers/video/omap2/dss/apply.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0134 +++-
> =A0drivers/video/omap2/dss/core.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0255 ++++---
> =A0drivers/video/omap2/dss/dispc.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0747 ++++++++++++++------
> =A0drivers/video/omap2/dss/dispc.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0 72 ++
> =A0drivers/video/omap2/dss/display.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 49 +-
> =A0drivers/video/omap2/dss/dpi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0 75 +-
> =A0drivers/video/omap2/dss/dsi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0537 ++++++++------
> =A0drivers/video/omap2/dss/dss.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0 65 +-
> =A0drivers/video/omap2/dss/dss.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0151 ++--
> =A0drivers/video/omap2/dss/dss_features.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 30 +-
> =A0drivers/video/omap2/dss/dss_features.h =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 =A05 +
> =A0drivers/video/omap2/dss/hdmi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0443 +++++-------
> =A0drivers/video/omap2/dss/hdmi_panel.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0236 ++++++-
> =A0drivers/video/omap2/dss/manager.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 19 +-
> =A0drivers/video/omap2/dss/overlay.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 16 +-
> =A0drivers/video/omap2/dss/rfbi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0 84 ++-
> =A0drivers/video/omap2/dss/sdi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0 63 +-
> =A0drivers/video/omap2/dss/ti_hdmi.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 32 +-
> =A0drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c =A0 =A0 =A0 =A0 =A0| =A0=
480 ++++++++-----
> =A0drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h =A0 =A0 =A0 =A0 =A0| =A0=
161 +----
> =A0drivers/video/omap2/dss/venc.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0133 +++-
> =A0drivers/video/omap2/omapfb/omapfb-ioctl.c =A0 =A0 =A0 =A0 =A0| =A0=
 17 +-
> =A0drivers/video/omap2/omapfb/omapfb-main.c =A0 =A0 =A0 =A0 =A0 | =A0=
 12 +-
> =A0drivers/video/omap2/omapfb/omapfb.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 =A01 +
> =A0drivers/video/omap2/vrfb.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | =A0 =A04 +-
> =A0include/video/omap-panel-nokia-dsi.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0 =A03 +
> =A0.../{omap-panel-dvi.h =3D> omap-panel-tfp410.h} =A0 =A0 =A0| =A0 1=
8 +-
> =A0include/video/omapdss.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0| =A0 75 +-
> =A051 files changed, 2983 insertions(+), 1996 deletions(-)
> =A0rename drivers/video/omap2/displays/{panel-dvi.c =3D> panel-tfp410=
=2Ec} (56%)
> =A0rename include/video/{omap-panel-dvi.h =3D> omap-panel-tfp410.h} (=
63%)
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
