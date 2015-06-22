From: Nishanth Menon <nm@ti.com>
Subject: [PATCH] pinctrl: dra: dt-bindings: Add virtual mode configuration option
Date: Mon, 22 Jun 2015 10:22:26 -0500
Message-ID: <1434986546-2211-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

In addition to the regular mux configuration such as mux mode 1,
2 etc, certain pins of DRA7 require to have "virtual mode" also
programmed. This allows for predefined delay characteristics to
be used by the SoC to meet timing characterstics needed for the
interface.

Provide easy to use macro to do the same.

It is important to note that the official TI guidelines recommend
to do as minimal pin reconfiguration beyond the bootloader given
the design of the hardware involved which can result in substantial
glitches which may impair functionality of certain peripherals.

Signed-off-by: Nishanth Menon <nm@ti.com>
---

Baseline: v4.1

 include/dt-bindings/pinctrl/dra.h |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/dt-bindings/pinctrl/dra.h b/include/dt-bindings/pinctrl/dra.h
index 7448edff4723..4379e29f0460 100644
--- a/include/dt-bindings/pinctrl/dra.h
+++ b/include/dt-bindings/pinctrl/dra.h
@@ -30,6 +30,26 @@
 #define MUX_MODE14	0xe
 #define MUX_MODE15	0xf
 
+/* Certain pins need virtual mode, but note: they may glitch */
+#define MUX_VIRTUAL_MODE0	(MODE_SELECT | (0x0 << 4))
+#define MUX_VIRTUAL_MODE1	(MODE_SELECT | (0x1 << 4))
+#define MUX_VIRTUAL_MODE2	(MODE_SELECT | (0x2 << 4))
+#define MUX_VIRTUAL_MODE3	(MODE_SELECT | (0x3 << 4))
+#define MUX_VIRTUAL_MODE4	(MODE_SELECT | (0x4 << 4))
+#define MUX_VIRTUAL_MODE5	(MODE_SELECT | (0x5 << 4))
+#define MUX_VIRTUAL_MODE6	(MODE_SELECT | (0x6 << 4))
+#define MUX_VIRTUAL_MODE7	(MODE_SELECT | (0x7 << 4))
+#define MUX_VIRTUAL_MODE8	(MODE_SELECT | (0x8 << 4))
+#define MUX_VIRTUAL_MODE9	(MODE_SELECT | (0x9 << 4))
+#define MUX_VIRTUAL_MODE10	(MODE_SELECT | (0xa << 4))
+#define MUX_VIRTUAL_MODE11	(MODE_SELECT | (0xb << 4))
+#define MUX_VIRTUAL_MODE12	(MODE_SELECT | (0xc << 4))
+#define MUX_VIRTUAL_MODE13	(MODE_SELECT | (0xd << 4))
+#define MUX_VIRTUAL_MODE14	(MODE_SELECT | (0xe << 4))
+#define MUX_VIRTUAL_MODE15	(MODE_SELECT | (0xf << 4))
+
+#define MODE_SELECT		(1 << 8)
+
 #define PULL_ENA		(0 << 16)
 #define PULL_DIS		(1 << 16)
 #define PULL_UP			(1 << 17)
-- 
1.7.9.5
