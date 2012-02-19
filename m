From: NeilBrown <neilb@suse.de>
Subject: [PATCH 1/2] ARM: OMAP2+: UART: remove unused fields in
 omap_uart_state.
Date: Sun, 19 Feb 2012 13:29:31 +1100
Message-ID: <20120219022931.8254.38314.stgit@notabene.brown>
References: <20120219022841.8254.86264.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20120219022841.8254.86264.stgit@notabene.brown>
Sender: linux-serial-owner@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>, "Govindraj . R" <govindraj.raja@ti.com>, NeilBrown <neilb@suse.de>
List-Id: linux-omap@vger.kernel.org

commit 2fd149645eb46d261 removed the last usage of 'can_sleep' but
did not remove the field.
commit  8612bd22f3036974 removed the last non-trivial use of 'pdev'.

So remove these fields and the one trivial use.

Acked-by: Govindraj.R <govindraj.raja@ti.com>
Signed-off-by: NeilBrown <neilb@suse.de>
---

 arch/arm/mach-omap2/serial.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index f590afc..0cdd359 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -54,11 +54,9 @@
 
 struct omap_uart_state {
 	int num;
-	int can_sleep;
 
 	struct list_head node;
 	struct omap_hwmod *oh;
-	struct platform_device *pdev;
 };
 
 static LIST_HEAD(uart_list);
@@ -381,8 +379,6 @@ void __init omap_serial_init_port(struct omap_board_data *bdata,
 
 	oh->mux = omap_hwmod_mux_init(bdata->pads, bdata->pads_cnt);
 
-	uart->pdev = pdev;
-
 	oh->dev_attr = uart;
 
 	if (((cpu_is_omap34xx() || cpu_is_omap44xx()) && bdata->pads)


