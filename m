From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 0/3] OMAP: HSMMC: cleanup and runtime pm
Date: Wed, 22 Jun 2011 19:48:31 +0530
Message-ID: <1308752314-32079-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Sender: linux-mmc-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org
Cc: tony@atomide.com, madhu.cr@ti.com, khilman@ti.com, b-cousson@ti.com, Balaji T K <balajitk@ti.com>
List-Id: linux-omap@vger.kernel.org

Removing the custom state machine - lazy disable framework in omap_hsmmc
to make way for runtime pm to handle host controller
power states.
This allows mmc_host_enable/mmc_host_disable to be replaced by
runtime get_sync and put_sync at host controller driver.

Enable runtime PM in omap_hsmmc

Balaji T K (3):
  MMC: OMAP: HSMMC: Remove lazy_disable
  MMC: OMAP: HSMMC: add runtime pm support
  OMAP2+: HSMMC: Remove unused iclk

 drivers/mmc/host/omap_hsmmc.c |  373 +++++++---------------------------------
 1 files changed, 66 insertions(+), 307 deletions(-)

