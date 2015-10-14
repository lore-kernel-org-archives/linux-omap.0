From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 0/2] omap: hsi: Fix warnings on boards that don't use ssi ports
Date: Wed, 14 Oct 2015 13:44:14 +0300
Message-ID: <1444819456-26728-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: wsa@the-dreams.de, sre@kernel.org, pavel@ucw.cz, pali.rohar@gmail.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

This series fixes warnings and console noise for boards that don't use
ssi ports. Tested on beagleboard-c4.

cheers,
-roger

Roger Quadros (2):
  hsi: omap_ssi_port: Prevent warning if cawake_gpio is not defined.
  ARM: dts: omap3: keep ssi ports by default

 arch/arm/boot/dts/omap3-n900.dts        | 1 +
 arch/arm/boot/dts/omap3.dtsi            | 2 ++
 drivers/hsi/controllers/omap_ssi_port.c | 2 +-
 3 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.1.4
