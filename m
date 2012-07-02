From: Andy Green <andy@warmcat.com>
Subject: [PATCH 2 0/4] Add ability to set defaultless network device MAC
 addresses to deterministic computed locally administered values
Date: Mon, 02 Jul 2012 14:40:41 +0800
Message-ID: <20120702063545.26782.98908.stgit@build.warmcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from warmcat.com ([87.106.134.80]:54192 "EHLO warmcat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753244Ab2GBGkq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 2 Jul 2012 02:40:46 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: s-jan@ti.com, arnd@arndb.de, patches@linaro.org, tony@atomide.com, rostedt@goodmis.org, linux-arm-kernel@lists.infradead.org

The following series adds some code to generate legal, locally administered
MAC addresses from OMAP4 CPU Die ID fuse data, and then adds a helper at
net/ethernet taking care of accepting device path / MAC mapping registrations
and running a notifier to enforce the requested MAC when the matching network
device turns up.

On PandaBoard / ES, two devices have no board-level MAC either assigned by
the manufacturer or stored on the board, the last patch in the series adds
these device paths and gets them set when the network device is registered.

Lastly for convenient testing, there's a little patch on omap2plus_defconfig
that will get Ethernet and WLAN up on Pandaboard.

The patches are against today's linux-omap.

Thanks to Tony Lindgren and Arnd Bergmann for comments leading to the
helper in net/ethernet.

---

Andy Green (4):
      OMAP2+: add cpu id register to MAC address helper
      net ethernet introduce mac_la_ap helper
      OMAP4 PANDA register ethernet and wlan for automatic mac allocation
      config test config extending omap2plus with wl12xx etc


 arch/arm/configs/omap2plus_defconfig   |   35 +++----
 arch/arm/mach-omap2/Kconfig            |    1 
 arch/arm/mach-omap2/board-omap4panda.c |   30 ++++++
 arch/arm/mach-omap2/id.c               |   39 ++++++++
 arch/arm/mach-omap2/include/mach/id.h  |    1 
 include/net/mac-la-ap.h                |   28 +++++
 net/Kconfig                            |   14 +++
 net/ethernet/Makefile                  |    2 
 net/ethernet/mac-la-ap.c               |  165 ++++++++++++++++++++++++++++++++
 9 files changed, 294 insertions(+), 21 deletions(-)
 create mode 100644 include/net/mac-la-ap.h
 create mode 100644 net/ethernet/mac-la-ap.c

