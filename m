From: Sricharan R <r.sricharan@ti.com>
Subject: [PATCH 5/5] irqchip: crossbar: Change allocation logic by reversing search for free irqs
Date: Mon, 5 May 2014 19:48:47 +0530
Message-ID: <1399299527-10955-6-git-send-email-r.sricharan@ti.com>
References: <1399299527-10955-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43392 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932538AbaEEOUf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 May 2014 10:20:35 -0400
In-Reply-To: <1399299527-10955-1-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: nm@ti.com, rnayak@ti.com, santosh.shilimkar@ti.com, tony@atomide.com

From: Nishanth Menon <nm@ti.com>

Reverse the search algorithm to ensure that address mapping and IRQ
allocation logics are proper. This can open up new bugs which are
easily fixable rather than wait till allocation logic approaches
the limit to find new bugs.

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Sricharan R <r.sricharan@ti.com>
---
 drivers/irqchip/irq-crossbar.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-crossbar.c b/drivers/irqchip/irq-crossbar.c
index 287d3ce..de021638 100644
--- a/drivers/irqchip/irq-crossbar.c
+++ b/drivers/irqchip/irq-crossbar.c
@@ -68,7 +68,7 @@ static inline int get_prev_map_irq(int cb_no)
 {
 	int i;
 
-	for (i = 0; i < cb->int_max; i++)
+	for (i = cb->int_max - 1; i >= 0; i--)
 		if (cb->irq_map[i] == cb_no)
 			return i;
 
@@ -79,7 +79,7 @@ static inline int allocate_free_irq(int cb_no)
 {
 	int i;
 
-	for (i = 0; i < cb->int_max; i++) {
+	for (i = cb->int_max - 1; i >= 0; i--) {
 		if (cb->irq_map[i] == IRQ_FREE) {
 			cb->irq_map[i] = cb_no;
 			return i;
-- 
1.7.9.5

