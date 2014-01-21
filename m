From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 0/5] mmc: omap_hsmmc: add support for set block count
Date: Tue, 21 Jan 2014 19:54:37 +0530
Message-ID: <1390314282-20520-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Sender: linux-mmc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, chris@printf.net
Cc: linux-omap@vger.kernel.org, Balaji T K <balajitk@ti.com>
List-Id: linux-omap@vger.kernel.org

Balaji T K (5):
  mmc: omap_hsmmc: save clock rate to use in interrupt context
  mmc: omap_hsmmc: fix request done for sbc error case
  mmc: omap_hsmmc: split dma setup
  mmc: omap_hsmmc: add cmd23 support
  mmc: omap_hsmmc: add autocmd23 support

 drivers/mmc/host/omap_hsmmc.c |   88 ++++++++++++++++++++++++++++++++++-------
 1 files changed, 73 insertions(+), 15 deletions(-)

-- 
1.7.5.4

