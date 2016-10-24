From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ARM: OMAP2+: PRM: initialize en_uart4_mask and grpsel_uart4_mask
Date: Mon, 24 Oct 2016 12:00:21 +0100
Message-ID: <20161024110021.10259-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rajendra Nayak <rnayak@codeaurora.org>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

In the case where has_uart4 is false, en_uart4_mask and grpsel_uart4_mask
are not initialized and so any garbage value is being logically or'd into
the write of PM_WKEN and OMAP3430_PM_MPUGRPSEL.  Fix this by initializing
these masks to zero.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 arch/arm/mach-omap2/prm3xxx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-omap2/prm3xxx.c b/arch/arm/mach-omap2/prm3xxx.c
index 62680aa..718981b 100644
--- a/arch/arm/mach-omap2/prm3xxx.c
+++ b/arch/arm/mach-omap2/prm3xxx.c
@@ -319,6 +319,9 @@ void __init omap3_prm_init_pm(bool has_uart4, bool has_iva)
 	if (has_uart4) {
 		en_uart4_mask = OMAP3630_EN_UART4_MASK;
 		grpsel_uart4_mask = OMAP3630_GRPSEL_UART4_MASK;
+	} else {
+		en_uart4_mask = 0;
+		grpsel_uart4_mask = 0;
 	}
 
 	/* Enable wakeups in PER */
-- 
2.9.3
