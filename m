From: Andy Green <andy@warmcat.com>
Subject: [PATCH 0/3] Add ability to set defaultless network device MAC
 addresses to deterministic computed locally administered values
Date: Fri, 29 Jun 2012 13:55:04 +0800
Message-ID: <20120629054404.11091.31289.stgit@build.warmcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from warmcat.com ([87.106.134.80]:41539 "EHLO warmcat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750890Ab2F2FzJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Jun 2012 01:55:09 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: nicolas.pitre@linaro.org, s-jan@ti.com, arnd@arndb.de, patches@linaro.org, tony@atomide.com, rostedt@goodmis.org

The following series adds some code to generate legal, locally administered
MAC addresses from OMAP4 CPU Die ID fuse data, and then adds an api to
devices.c allowing board files to register device paths for network devices
that wish to use them.

On PandaBoard / ES, two devices have no board-level MAC either assigned by
the manufacturer or stored on the board, the last patch in the series adds
these device paths and gets them set when the network device is registered.

The patches are against today's linux-omap.

---

Andy Green (3):
      OMAP2+: add cpu id register to MAC address helper
      OMAP2+ devices add mac address allocation register api
      OMAP4 PANDA register ethernet and wlan for automatic mac allocation


 arch/arm/mach-omap2/board-omap4panda.c |   13 +++++
 arch/arm/mach-omap2/common.h           |    2 +
 arch/arm/mach-omap2/devices.c          |   89 ++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/id.c               |   39 ++++++++++++++
 arch/arm/mach-omap2/include/mach/id.h  |    1 
 5 files changed, 144 insertions(+)

-- 
Signature
