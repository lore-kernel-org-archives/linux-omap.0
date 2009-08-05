From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH 00/15] OMAP: DSS intro
Date: Wed,  5 Aug 2009 17:15:26 +0300
Message-ID: <1249481741-14008-1-git-send-email-tomi.valkeinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:25028 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934465AbZHEOQv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Aug 2009 10:16:51 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-omap@vger.kernel.org

This patch set implement new display subsystem driver (DSS2) and omapfb=
 driver
for OMAP2/3. The patches can also be found from
http://gitorious.org/linux-omap-dss2/linux

The patches include DSS documentation patch that includes more instruct=
ions for
module parameters, sysfs files etc.

The patches enable DSS2 for SDP, Beagle and Overo boards.

I don't currently have any OMAP2 board to test DSS2, but it has worked =
on OMAP2
and the possible fixes needed should be minimal.

OMAP1 is not supported, and so the old DSS needs to be used on OMAP1 bo=
ards.

DSS2 is partly based on the old omapfb driver by Imre Deak, and Imre ha=
s also
contributed to DSS2 quite a bit. Ville Syrj=C3=A4l=C3=A4 has been contr=
ibuting to scaling
and tv-out work. Also some contributions have been made by Hardik Shah,=
 Vaibhav
Hiremath, and perhaps some others that I have forgotten =3D).

---

[PATCH 01/15] OMAP: OMAPFB: split omapfb.h
[PATCH 02/15] OMAP: OMAPFB: add omapdss device
[PATCH 03/15] OMAP: Add VRAM manager
[PATCH 04/15] OMAP: Add support for VRFB rotation engine
[PATCH 05/15] OMAP: DSS2: Documentation for DSS2
[PATCH 06/15] OMAP: DSS2: Display Subsystem Driver core
[PATCH 07/15] OMAP: DSS2: VENC driver
[PATCH 08/15] OMAP: DSS2: RFBI driver
[PATCH 09/15] OMAP: DSS2: SDI driver
[PATCH 10/15] OMAP: DSS2: DSI driver
[PATCH 11/15] OMAP: DSS2: omapfb driver
[PATCH 12/15] OMAP: DSS2: Add panel drivers
[PATCH 13/15] OMAP: SDP: Enable DSS2 for OMAP3 SDP board
[PATCH 14/15] OMAP: Beagle: Enable DSS2 for Beagle board
[PATCH 15/15] OMAP: Overo: Enable DSS2 for Overo

---

 Documentation/arm/OMAP/DSS                         |  317 ++
 arch/arm/configs/omap3_beagle_defconfig            |   26 +-
 arch/arm/configs/omap_3430sdp_defconfig            |   31 +-
 arch/arm/configs/overo_defconfig                   |  265 +--
 arch/arm/mach-omap1/board-nokia770.c               |    2 +-
 arch/arm/mach-omap2/board-3430sdp.c                |  171 +-
 arch/arm/mach-omap2/board-n800.c                   |    2 +-
 arch/arm/mach-omap2/board-omap3beagle.c            |  119 +-
 arch/arm/mach-omap2/board-overo.c                  |  149 +-
 arch/arm/mach-omap2/clock24xx.c                    |    8 +-
 arch/arm/mach-omap2/clock34xx.c                    |   10 +-
 arch/arm/mach-omap2/io.c                           |    4 +-
 arch/arm/plat-omap/Kconfig                         |    6 +
 arch/arm/plat-omap/Makefile                        |    2 +
 arch/arm/plat-omap/fb.c                            |   41 +-
 arch/arm/plat-omap/include/mach/display.h          |  542 +++
 arch/arm/plat-omap/include/mach/omapfb.h           |  398 ---
 arch/arm/plat-omap/include/mach/vram.h             |   63 +
 arch/arm/plat-omap/include/mach/vrfb.h             |   46 +
 arch/arm/plat-omap/sram.c                          |    8 +
 arch/arm/plat-omap/vram.c                          |  655 ++++
 arch/arm/plat-omap/vrfb.c                          |  281 ++
 drivers/video/Kconfig                              |    1 +
 drivers/video/Makefile                             |    1 +
 drivers/video/omap/Kconfig                         |    5 +-
 drivers/video/omap/blizzard.c                      |    2 +-
 drivers/video/omap/dispc.c                         |   21 +-
 drivers/video/omap/hwa742.c                        |    2 +-
 drivers/video/omap/lcd_2430sdp.c                   |    2 +-
 drivers/video/omap/lcd_ams_delta.c                 |    2 +-
 drivers/video/omap/lcd_apollon.c                   |    2 +-
 drivers/video/omap/lcd_h3.c                        |    2 +-
 drivers/video/omap/lcd_h4.c                        |    2 +-
 drivers/video/omap/lcd_inn1510.c                   |    2 +-
 drivers/video/omap/lcd_inn1610.c                   |    2 +-
 drivers/video/omap/lcd_ldp.c                       |    2 +-
 drivers/video/omap/lcd_mipid.c                     |    3 +-
 drivers/video/omap/lcd_omap2evm.c                  |    2 +-
 drivers/video/omap/lcd_omap3beagle.c               |    2 +-
 drivers/video/omap/lcd_omap3evm.c                  |    2 +-
 drivers/video/omap/lcd_osk.c                       |    2 +-
 drivers/video/omap/lcd_overo.c                     |    3 +-
 drivers/video/omap/lcd_palmte.c                    |    2 +-
 drivers/video/omap/lcd_palmtt.c                    |    2 +-
 drivers/video/omap/lcd_palmz71.c                   |    2 +-
 drivers/video/omap/lcdc.c                          |    3 +-
 drivers/video/omap/omapfb.h                        |  227 ++
 drivers/video/omap/omapfb_main.c                   |    2 +-
 drivers/video/omap/rfbi.c                          |    3 +-
 drivers/video/omap/sossi.c                         |    2 +-
 drivers/video/omap2/Kconfig                        |    3 +
 drivers/video/omap2/Makefile                       |    3 +
 drivers/video/omap2/displays/Kconfig               |   22 +
 drivers/video/omap2/displays/Makefile              |    3 +
 drivers/video/omap2/displays/panel-generic.c       |  104 +
 .../omap2/displays/panel-samsung-lte430wq-f0c.c    |  113 +
 .../video/omap2/displays/panel-sharp-ls037v7dw01.c |  153 +
 drivers/video/omap2/dss/Kconfig                    |   89 +
 drivers/video/omap2/dss/Makefile                   |    6 +
 drivers/video/omap2/dss/core.c                     |  917 +++++
 drivers/video/omap2/dss/dispc.c                    | 3177 ++++++++++++=
++++++
 drivers/video/omap2/dss/display.c                  |  658 ++++
 drivers/video/omap2/dss/dpi.c                      |  388 +++
 drivers/video/omap2/dss/dsi.c                      | 3509 ++++++++++++=
++++++++
 drivers/video/omap2/dss/dss.c                      |  347 ++
 drivers/video/omap2/dss/dss.h                      |  356 ++
 drivers/video/omap2/dss/manager.c                  | 1487 +++++++++
 drivers/video/omap2/dss/overlay.c                  |  673 ++++
 drivers/video/omap2/dss/rfbi.c                     | 1310 ++++++++
 drivers/video/omap2/dss/sdi.c                      |  370 ++
 drivers/video/omap2/dss/venc.c                     |  797 +++++
 drivers/video/omap2/omapfb/Kconfig                 |   37 +
 drivers/video/omap2/omapfb/Makefile                |    2 +
 drivers/video/omap2/omapfb/omapfb-ioctl.c          |  727 ++++
 drivers/video/omap2/omapfb/omapfb-main.c           | 2137 ++++++++++++
 drivers/video/omap2/omapfb/omapfb-sysfs.c          |  507 +++
 drivers/video/omap2/omapfb/omapfb.h                |  146 +
 include/linux/omapfb.h                             |  242 ++
 78 files changed, 21024 insertions(+), 710 deletions(-)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
