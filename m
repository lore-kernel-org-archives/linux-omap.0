From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 0/3] mmc: omap_hsmmc: fixes for 3.10
Date: Fri, 10 May 2013 17:42:32 +0530
Message-ID: <1368187955-13069-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Sender: linux-mmc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org
Cc: linux-omap@vger.kernel.org, Balaji T K <balajitk@ti.com>
List-Id: linux-omap@vger.kernel.org

Fix to make wlan/sdio work with dt and to use dma binding from dt

Matt Porter (1):
  mmc: omap_hsmmc: convert to dma_request_slave_channel_compat

Santosh Shilimkar (1):
  mmc: omap_hsmmc: Skip platform_get_resource_byname() for dt case

Tony Lindgren (1):
  mmc: omap_hsmmc: Fix the DT pbias workaround for MMC controllers 2 to
    5

 drivers/mmc/host/omap_hsmmc.c |   51 +++++++++++++++++++++++++---------------
 1 files changed, 32 insertions(+), 19 deletions(-)

-- 
1.7.5.4

