From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 02/35] arm: omap: irq: define INTC_ILR0 register
Date: Mon, 28 Jul 2014 16:15:50 -0500
Message-ID: <1406582183-696-3-git-send-email-balbi@ti.com>
References: <1406582183-696-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1406582183-696-1-git-send-email-balbi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, linux@arm.linux.org.uk, jason@lakedaemon.net, khilman@deeprootsystems.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, bcousson@baylibre.com, tglx@linutronix.de, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

this is currently used as a hardcoded 0x100
offset.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/irq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 7b2cf9a..96073a2 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -41,6 +41,7 @@
 #define INTC_MIR_CLEAR0		0x0088
 #define INTC_MIR_SET0		0x008c
 #define INTC_PENDING_IRQ0	0x0098
+#define INTC_ILR0		0x0100
 /* Number of IRQ state bits in each MIR register */
 #define IRQ_BITS_PER_REG	32
 
-- 
2.0.1.563.g66f467c
