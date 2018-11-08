From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: multi_v7_defconfig: Enable 8250-omap serial driver and
 use it by default
Date: Thu,  8 Nov 2018 08:52:21 -0800
Message-ID: <20181108165221.22775-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

We've already moved omap2plus_defconfig over to use 8250-omap instead of
omap-serial driver. Let's update multi_v7_defconfig too.

By default we also enable SERIAL_8250_OMAP_TTYO_FIXUP that updates the
kernel serial console to point to 8250 driver and warns about it during
the boot.

Users with ttyO[0123] in their /etc/inittab should update inittab to
to use ttyS[0123] instead.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -305,6 +305,7 @@ CONFIG_SERIAL_8250_SHARE_IRQ=y
 CONFIG_SERIAL_8250_BCM2835AUX=y
 CONFIG_SERIAL_8250_DW=y
 CONFIG_SERIAL_8250_EM=y
+CONFIG_SERIAL_8250_OMAP=y
 CONFIG_SERIAL_8250_MT6577=y
 CONFIG_SERIAL_8250_UNIPHIER=y
 CONFIG_SERIAL_OF_PLATFORM=y
-- 
2.19.1
