From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 03/23] omap3evm: Fixes after moving to matrix_keypad
Date: Wed, 17 Feb 2010 17:31:57 -0800
Message-ID: <20100218013157.32075.87516.stgit@baageli.muru.com>
References: <20100218013012.32075.43788.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:58568 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385Ab0BRBbG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Feb 2010 20:31:06 -0500
In-Reply-To: <20100218013012.32075.43788.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Sanjeev Premi <premi@ti.com>

From: Sanjeev Premi <premi@ti.com>

The keypad was not working properly after migrating
to matrix_keypad.

Swapped the row, col fields of the KEY() macro in
the keymap definition to get it working again.

Signed-off-by: Sanjeev Premi <premi@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-omap3evm.c |   27 +++++++++++++++------------
 1 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 3b473cf..34655a6 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -448,20 +448,23 @@ static struct twl4030_usb_data omap3evm_usb_data = {
 
 static int board_keymap[] = {
 	KEY(0, 0, KEY_LEFT),
-	KEY(0, 1, KEY_RIGHT),
-	KEY(0, 2, KEY_A),
-	KEY(0, 3, KEY_B),
-	KEY(1, 0, KEY_DOWN),
+	KEY(0, 1, KEY_DOWN),
+	KEY(0, 2, KEY_ENTER),
+	KEY(0, 3, KEY_M),
+
+	KEY(1, 0, KEY_RIGHT),
 	KEY(1, 1, KEY_UP),
-	KEY(1, 2, KEY_E),
-	KEY(1, 3, KEY_F),
-	KEY(2, 0, KEY_ENTER),
-	KEY(2, 1, KEY_I),
+	KEY(1, 2, KEY_I),
+	KEY(1, 3, KEY_N),
+
+	KEY(2, 0, KEY_A),
+	KEY(2, 1, KEY_E),
 	KEY(2, 2, KEY_J),
-	KEY(2, 3, KEY_K),
-	KEY(3, 0, KEY_M),
-	KEY(3, 1, KEY_N),
-	KEY(3, 2, KEY_O),
+	KEY(2, 3, KEY_O),
+
+	KEY(3, 0, KEY_B),
+	KEY(3, 1, KEY_F),
+	KEY(3, 2, KEY_K),
 	KEY(3, 3, KEY_P)
 };
 

