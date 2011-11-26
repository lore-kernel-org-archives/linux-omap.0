From: NeilBrown <neilb@suse.de>
Subject: [PATCH 4/4] twl4030-irq: fix typo
Date: Sun, 27 Nov 2011 07:17:41 +1100
Message-ID: <20111126201741.16080.59032.stgit@notabene.brown>
References: <20111126201334.16080.85045.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111126201334.16080.85045.stgit@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, NeilBrown <neilb@suse.de>
List-Id: linux-omap@vger.kernel.org

overwriten -> overwritten

Signed-off-by: NeilBrown <neilb@suse.de>
---

 drivers/mfd/twl4030-irq.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mfd/twl4030-irq.c b/drivers/mfd/twl4030-irq.c
index 3ac7216..b69bb51 100644
--- a/drivers/mfd/twl4030-irq.c
+++ b/drivers/mfd/twl4030-irq.c
@@ -492,7 +492,7 @@ static void twl4030_sih_bus_sync_unlock(struct irq_data *data)
 			u8	bytes[4];
 		} imr;
 
-		/* byte[0] gets overwriten as we write ... */
+		/* byte[0] gets overwritten as we write ... */
 		imr.word = cpu_to_le32(agent->imr << 8);
 		agent->imr_change_pending = false;
 
