From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 0/6] OMAPDSS: enable DSS for Panda & SDP with devtree
Date: Mon, 5 Nov 2012 15:14:13 +0200
Message-ID: <1352121259-5836-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40809 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754128Ab2KENO1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Nov 2012 08:14:27 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: archit@ti.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: b-cousson@ti.com, s-guiriec@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Hi,

OMAPDSS device tree support is still some way in the future. Tony has requested
to get DSS working for Panda & SDP boards with DT kernel, so that we'll have
fully working boards with DT.

This series makes a few hacks to get a working display on OMAP4 Panda and SDP
boards. The idea is to setup the omapdss with the non-DT method, creating the
omapdss devices and passing platform data to them. This setup code is called
from board-generic for Panda and SDP boards.

There was one problem with this approach: omapdss cannot get regulators using
the omapdss's names fro the regulators. Thus there's a hack patch to get the
regulators using the OMAP4 "native" regulator names, thus circumventing the
problem.

Tony, if these look good, how do you want to merge these? There are three parts
here, and I think they can be merged independently if so wished:

* .dts changes for the pinmuxing (2 patches)
* dss-common.c and board-generic.c changes (3 patches)
* DSS hack for the regulators (1 patch)

If one of those parts is missing, DSS won't start with DT kernel, but otherwise
there shouldn't be any problems. So to avoid conflicts, I suggest that you take
the first two parts, and I'll merge the DSS hack via omapdss tree.

 Tomi

Ricardo Neri (2):
  ARM/dts: omap4-panda: Add pinmux configuration for HDMI
  ARM/dts: omap4-sdp: Add pinmux configuration for HDMI

Tomi Valkeinen (4):
  OMAPDSS: HACK: look for regulators with omap4 names
  OMAP: panda: move display init from board file to dss-common.c
  OMAP: omap4sdp: move display init from board file to dss-common.c
  OMAP: board-generic: enable DSS for panda & sdp boards

 arch/arm/boot/dts/omap4-panda-a4.dts     |   17 ++
 arch/arm/boot/dts/omap4-panda.dts        |   18 ++
 arch/arm/boot/dts/omap4-pandaES.dts      |    9 +
 arch/arm/boot/dts/omap4-sdp-es23plus.dts |   17 ++
 arch/arm/boot/dts/omap4-sdp.dts          |   18 ++
 arch/arm/mach-omap2/Makefile             |    2 +-
 arch/arm/mach-omap2/board-4430sdp.c      |  157 +----------------
 arch/arm/mach-omap2/board-generic.c      |   10 ++
 arch/arm/mach-omap2/board-omap4panda.c   |   68 +-------
 arch/arm/mach-omap2/dss-common.c         |  276 ++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/dss-common.h         |   14 ++
 drivers/video/omap2/dss/dsi.c            |    8 +
 drivers/video/omap2/dss/hdmi.c           |    4 +
 13 files changed, 394 insertions(+), 224 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap4-panda-a4.dts
 create mode 100644 arch/arm/boot/dts/omap4-sdp-es23plus.dts
 create mode 100644 arch/arm/mach-omap2/dss-common.c
 create mode 100644 arch/arm/mach-omap2/dss-common.h

-- 
1.7.10.4

