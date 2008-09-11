From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PREVIEW] New display subsystem for OMAP2/3
Date: Thu, 11 Sep 2008 17:55:55 +0300
Message-ID: <1221144955.12281.6.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:61349 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751380AbYIKO5K (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2008 10:57:10 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m8BEuvu0008261
	for <linux-omap@vger.kernel.org>; Thu, 11 Sep 2008 17:57:08 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Display Subsystem driver for OMAP2 and 3 (DSS2)
-----------------------------------------------

This is an almost total rewrite of the current OmapFB driver (let's call it
DSS1). The main targets for this work are to implement DSI, TV-out and multiple
display support. 

The DSS2 driver (omap-dss module) lives in arch/arm/plat-omap/dss/, and the FB,
panel and controller drivers live in drivers/video/omap2/. DSS1 and DSS2 live
currently side by side, you can choose which one to use.

I know it would be best to modify the DSS1 driver to implement the missing
features, but the task seemed overwhelming. The DSS1 driver was just not
designed for multiple displays or other outputs than parallel and rfbi, and I
thought maintaining a patch set to change those wasn't something I could handle
and stay sane. So I implemented DSS2 parallel to the DSS1.

I'm sending this now as a preview. DSS2 is in no way ready yet, even though it
should be usable. I'm interested to hear comments about it, most importantly if
it is ok to have DSS2 as a separate driver from DSS1 or is it a no-no.

Some code, especially in the dispc and rfbi, was taken and modified from the
DSS1 driver by Imre Deak and others.

The patch set is about 200kB, so I decided not to send it as email, but to put
it to http://www.bat.org/~tomba/omap-dss/

Architecture
------------

DSS driver has to be loaded first, then the panel and the controller drivers
are loaded and they register themselves to the DSS. At this point the DSS is
ready. The DSS abstracts each display behind a struct omap_display, and these
are the main interface to the DSS.

OmapFB driver gets a display from DSS, initializes framebuffer memory,
configures the display and activates it. Currently OmapFB only uses the first
display.  Also, one could implement other ways to handle the displays as the
DSS does not depend on OmapFB in any way.

And a piece of cool ascii art:

                DSS
               /   \
              /     \        +--- Panel
             /       \      /
Panel----Display     Display
             \       /      \
              \     /        +--- Ctrl
               \   /
              OmapFB

Porting panel and controller drivers to DSS2 is trivial. However, only OMAP3
SDP panel driver is currently ported, as I don't have any other public
hardware.

Features
--------

Current implemented and tested features include:
- DSI output in command mode
- SDI output (not tested for a while, might've gotten broken)
- RFBI output (not tested for a while, might've gotten broken)
- Parallel output (OMAP3 SDP, both LCD and DVI)
- All pieces can be compiled as a module or inside kernel
- Display timing change (with, for example, fbset)
- Using DISPC to update any of the outputs
- Using CPU to update RFBI or DSI output
- OMAP DISPC planes
- RGB16, RGB24 packed, RGB24 unpacked
- YUV2, UYVY 

TODO
----

OMAP2 not tested for some time
- DSS2 did work on OMAP2, but I haven't been able to test it for some time.

DSS locking
- Things break if you change dispc settings during DSI screen update.  Probably
  the same for RFBI.

Error checking
- Lots of checks are missing or implemented just as BUG()

Rotate (external FB)
Rotate (VRFB)
Rotate (SMS)
VENC

Pixel clock
- Currently allows only pixel clocks that can be exactly produced.
- Use DSI PLL to produce pixel clock

System DMA update for DSI
- Can be used for RGB16 and RGB24P modes. Probably not for RGB24U (how
  to skip the empty byte?)

Power management
- Clocks on/off in the first place

Multiple display handling
- Perhaps extra framebuffers, and an ioctl to map any of the FBs to any of the
  DISPC planes or L4. So, for example, fb1 could be GFX plane, fb0 could be
  updated with CPU. Then later on fb1 could be changed to use CPU with an
  ioctl, and fb0 to use GFX.
- Because of the dependencies of the DISPC planes, LCD/DIGIT output,
  the application has to know what it is doing.

Resolution change
- The x/y res of the framebuffer are not display resolutions, but just the
  resolution of the framebuffer (and the plane).
- The display resolution affects all planes on the display.
- Display resolution is not really a framebuffer feature. A sysfs
  entry for each display? If yes, is that an omapfb or DSS feature?
  Changing resolution affects the framebuffers.

DSI configuration
- Currently quite hardcoded configuration

OMAP1 support
- Not sure if needed

FBSET
-----

fbset with omap planes support can be found at
http://www.bat.org/~tomba/fbset/

The debian package is from ubuntu, with a patch that adds omap support.

---

 arch/arm/mach-omap2/board-3430sdp.c       |   66 +-
 arch/arm/plat-omap/Kconfig                |    2 +
 arch/arm/plat-omap/Makefile               |    2 +
 arch/arm/plat-omap/dss/Kconfig            |    5 +
 arch/arm/plat-omap/dss/Makefile           |    6 +
 arch/arm/plat-omap/dss/dispc.c            | 1539 +++++++++++++++++++
 arch/arm/plat-omap/dss/display.c          |  304 ++++
 arch/arm/plat-omap/dss/dpi.c              |  196 +++
 arch/arm/plat-omap/dss/dsi.c              | 2371 +++++++++++++++++++++++++++++
 arch/arm/plat-omap/dss/dss.c              |  389 +++++
 arch/arm/plat-omap/dss/dss.h              |  191 +++
 arch/arm/plat-omap/dss/rfbi.c             | 1274 ++++++++++++++++
 arch/arm/plat-omap/dss/sdi.c              |  152 ++
 arch/arm/plat-omap/dss/venc.c             |  501 ++++++
 arch/arm/plat-omap/fb.c                   |    9 +-
 arch/arm/plat-omap/include/mach/display.h |  358 +++++
 arch/arm/plat-omap/include/mach/omapfb.h  |    7 +
 drivers/video/Kconfig                     |    1 +
 drivers/video/Makefile                    |    1 +
 drivers/video/omap/Kconfig                |    2 +-
 drivers/video/omap2/Kconfig               |   20 +
 drivers/video/omap2/Makefile              |    4 +
 drivers/video/omap2/omapfb.c              | 1377 +++++++++++++++++
 drivers/video/omap2/panel-sdp3430-dvi.c   |  157 ++
 drivers/video/omap2/panel-sdp3430.c       |  187 +++
 25 files changed, 9108 insertions(+), 13 deletions(-)

-- 


