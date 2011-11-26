From: NeilBrown <neilb@suse.de>
Subject: [PATCH 3/4] twl4030-irq: set tertiary interrupts to be
 nested/threaded.
Date: Sun, 27 Nov 2011 07:17:41 +1100
Message-ID: <20111126201741.16080.35062.stgit@notabene.brown>
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

As tertiary interrupts are handled by handle_twl4030_sih calling
handle_nested_irq, they do not need their own separate irq thread.
So mark them as 'nested_thread' interrupts to avoid the extra thread
creation.

Tested on GTA04 Pheonux.

Signed-off-by: NeilBrown <neilb@suse.de>
---

 drivers/mfd/twl4030-irq.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/twl4030-irq.c b/drivers/mfd/twl4030-irq.c
index 29f11e0..3ac7216 100644
--- a/drivers/mfd/twl4030-irq.c
+++ b/drivers/mfd/twl4030-irq.c
@@ -667,6 +667,7 @@ int twl4030_sih_setup(int module)
 		irq_set_chip_data(irq, agent);
 		irq_set_chip_and_handler(irq, &twl4030_sih_irq_chip,
 					 handle_edge_irq);
+		irq_set_nested_thread(irq, 1);
 		activate_irq(irq);
 	}
 
