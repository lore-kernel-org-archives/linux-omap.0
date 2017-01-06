From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 0/2] thermal: omap: dra752: Remove TSHUT configuration
Date: Fri, 6 Jan 2017 11:31:41 +0530
Message-ID: <1483682503-27803-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: edubezval@gmail.com
Cc: rui.zhang@intel.com, linux-kernel@vger.kernel.org, j-keerthy@ti.com, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, rk@ti.com, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

Technical Reference Manual [1] mandates that software should
not be configuring the thermal shutdown thresholds. Hence
removing TSHUT_CONFIG.

[1] http://www.ti.com/lit/ug/sprui30b/sprui30b.pdf

Keerthy (2):
  thermal: omap: dra752: Remove TSHUT configuration
  thermal: omap: dra752: Remove all TSHUT related definitions

 drivers/thermal/ti-soc-thermal/dra752-bandgap.h    | 19 ---------------
 .../thermal/ti-soc-thermal/dra752-thermal-data.c   | 28 +---------------------
 2 files changed, 1 insertion(+), 46 deletions(-)

-- 
1.9.1

