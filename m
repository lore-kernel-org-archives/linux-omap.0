From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH 0/2] omap: hsmmc: Cleanup omap hsmmc dma routines
Date: Fri, 2 Sep 2011 00:35:55 +0530
Message-ID: <1314903957-24408-1-git-send-email-svenkatr@ti.com>
References: <y>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
In-Reply-To: <y>
Sender: linux-mmc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: per.forlin@linaro.org, cjb@laptop.org, Venkatraman S <svenkatr@ti.com>
List-Id: linux-omap@vger.kernel.org

The first patch substitutes the dma_cleanup function in place of 
the body of the code which does the same thing. The dma unmap
operation is now restricted just to the post_req function.

The second patch minimizes holding spin lock during dma
configuration, where it is not necessary.

Venkatraman S (2):
  omap: hsmmc: normalize dma cleanup operations
  omap: hsmmc: don't hold spinlock during dma configuration

 drivers/mmc/host/omap_hsmmc.c |   22 ++++++----------------
 1 files changed, 6 insertions(+), 16 deletions(-)

