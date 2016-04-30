From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 0/6] omap-ssi cleanups + dvfs support
Date: Sat, 30 Apr 2016 04:09:07 +0200
Message-ID: <1461982153-19139-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
List-Id: linux-omap@vger.kernel.org

Hi,

The following patches add a few cleanups to the omap-ssi driver,
fix module unloading (and reloading) and merge omap-ssi and
omap-ssi-port into the same module to avoid a circular dependency
introduced by the last patch.

P.S.: The last patch has already been sent in this patchset
(https://lkml.org/lkml/2016/1/30/283), but could not be applied
due to the circular dependency.

-- Sebastian

Sebastian Reichel (6):
  HSI: omap_ssi_port: switch to gpiod API
  HSI: omap_ssi: fix module unloading
  HSI: omap_ssi: make sure probe stays available
  HSI: omap_ssi: fix removal of port platform device
  HSI: omap_ssi: built omap_ssi and omap_ssi_port into one module
  HSI: omap-ssi: add clk change support

 drivers/hsi/controllers/Kconfig                    |   5 -
 drivers/hsi/controllers/Makefile                   |   4 +-
 drivers/hsi/controllers/omap_ssi.h                 |  12 ++-
 .../controllers/{omap_ssi.c => omap_ssi_core.c}    | 106 ++++++++++++++++++---
 drivers/hsi/controllers/omap_ssi_port.c            |  84 ++++++++--------
 5 files changed, 146 insertions(+), 65 deletions(-)
 rename drivers/hsi/controllers/{omap_ssi.c => omap_ssi_core.c} (86%)

-- 
2.8.1
