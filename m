From: Pantelis Antoniou <panto@antoniou-consulting.com>
Subject: [PATCH 0/3] capebus moving omap_devices to mach-omap2
Date: Thu,  1 Nov 2012 17:17:59 +0200
Message-ID: <1351783082-11411-1-git-send-email-panto@antoniou-consulting.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Pantelis Antoniou <panto@antoniou-consulting.com>, linux-kernel@vger.kernel.org, Koen Kooi <koen@dominion.thruhere.net>, Matt Porter <mporter@ti.com>, Russ Dill <Russ.Dill@ti.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

It is painless to move the adapter DT devices to arch/arm/mach-omap2

However I got bit by the __init at omap_build_device family functions.
If you don't remove it, crashes every time you instantiate a device
at runtime, or you load the cape driver as a module.

Pantelis Antoniou (3):
  omap-device: Remove __init from omap_device_build family functions
  da8xx-dt: Create da8xx DT adapter device
  ti-tscadc-dt: Create ti-tscadc-dt DT adapter device

 arch/arm/mach-omap2/Makefile       |   4 +
 arch/arm/mach-omap2/da8xx-dt.c     | 197 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/ti-tscadc-dt.c | 155 +++++++++++++++++++++++++++++
 arch/arm/plat-omap/omap_device.c   |   4 +-
 4 files changed, 358 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-omap2/da8xx-dt.c
 create mode 100644 arch/arm/mach-omap2/ti-tscadc-dt.c

-- 
1.7.12
