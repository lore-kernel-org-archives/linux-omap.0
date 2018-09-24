From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/4] bus: ti-sysc: Update revision masks to support am437x
Date: Mon, 24 Sep 2018 15:44:43 -0700
Message-ID: <20180924224445.97239-3-tony@atomide.com>
References: <20180924224445.97239-1-tony@atomide.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180924224445.97239-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

We need to detect few new devices to tag for noirq_suspend and
pm_runtime_irq_safe to avoid causing regressions compared to
legacy platform data booting.

Let's update i2c, gpio, uart and wdt revision masks to detect
them on am437x. Note that we can remove the second wdt entry
with the updated mask. Note that we also have some uarts with
a different revision register.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -869,7 +869,7 @@ struct sysc_revision_quirk {
 
 static const struct sysc_revision_quirk sysc_revision_quirks[] = {
 	/* These drivers need to be fixed to not use pm_runtime_irq_safe() */
-	SYSC_QUIRK("gpio", 0, 0, 0x10, 0x114, 0x50600801, 0xffffffff,
+	SYSC_QUIRK("gpio", 0, 0, 0x10, 0x114, 0x50600801, 0xffff0fff,
 		   SYSC_QUIRK_LEGACY_IDLE | SYSC_QUIRK_OPT_CLKS_IN_RESET),
 	SYSC_QUIRK("mmu", 0, 0, 0x10, 0x14, 0x00000020, 0xffffffff,
 		   SYSC_QUIRK_LEGACY_IDLE),
@@ -889,7 +889,9 @@ static const struct sysc_revision_quirk sysc_revision_quirks[] = {
 	SYSC_QUIRK("uart", 0, 0x50, 0x54, 0x58, 0x00000052, 0xffffffff,
 		   SYSC_QUIRK_LEGACY_IDLE),
 	/* Uarts on omap4 and later */
-	SYSC_QUIRK("uart", 0, 0x50, 0x54, 0x58, 0x50411e03, 0xffffffff,
+	SYSC_QUIRK("uart", 0, 0x50, 0x54, 0x58, 0x50411e03, 0xffff00ff,
+		   SYSC_QUIRK_LEGACY_IDLE),
+	SYSC_QUIRK("uart", 0, 0x50, 0x54, 0x58, 0x47422e03, 0xffffffff,
 		   SYSC_QUIRK_LEGACY_IDLE),
 
 #ifdef DEBUG
-- 
2.19.0
