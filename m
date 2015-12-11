From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/2] ARM: OMAP1/2+: DO not create omap-pcm-audio device
Date: Fri, 11 Dec 2015 14:50:18 +0200
Message-ID: <1449838220-24309-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

The ASoC omap-pcm has been converted to be non platform device a long time ago,
so it is no longer needed to create the device for it since there will be no
driver to be loaded for it.

Regards,
Peter
---
Peter Ujfalusi (2):
  ARM: OMAP1: Remove device creation for omap-pcm-audio
  ARM: OMAP2+: Remove device creation for omap-pcm-audio

 arch/arm/mach-omap1/devices.c | 19 -------------------
 arch/arm/mach-omap2/devices.c | 25 ++++---------------------
 2 files changed, 4 insertions(+), 40 deletions(-)

-- 
2.6.4
