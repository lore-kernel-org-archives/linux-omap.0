From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 0/5] staging: omap-thermal fixes
Date: Tue, 13 Nov 2012 11:43:17 -0400
Message-ID: <1352821402-13458-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: b-cousson@ti.com, devel@driverdev.osuosl.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>
List-Id: linux-omap@vger.kernel.org

Hello Greg,

Several compilation fixes and a couple of debugging prints
added to the omap-thermal driver under staging area.

Patches are also available here:

git@gitorious.org:thermal-framework/thermal-framework.git thermal_work/omap/omap-thermal-fixes

Cheers,

Eduardo Valentin (4):
  staging: omap-thermal: fix compilation
  staging: omap-thermal: remove platform data nomenclature
  staging: omap-thermal: remove freq_clip table
  staging: omap-thermal: add IRQ debugging messaging

Radhesh Fadnis (1):
  staging: omap-thermal: fix context restore function

 drivers/staging/omap-thermal/omap-bandgap.c        |   63 ++++++++----------
 drivers/staging/omap-thermal/omap-bandgap.h        |    9 ---
 drivers/staging/omap-thermal/omap-thermal-common.c |   69 ++------------------
 3 files changed, 34 insertions(+), 107 deletions(-)

-- 
1.7.7.1.488.ge8e1c
