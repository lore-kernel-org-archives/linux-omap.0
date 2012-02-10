From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] ARM: OMAP2xxx: PM: fix OMAP2xxx-specific UART idle bug in
 v3.3
Date: Thu, 9 Feb 2012 18:24:03 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1202091822170.5059@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
Sender: linux-serial-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Greg KH <gregkh@linuxfoundation.org>, Kevin Hilman <khilman@ti.com>, Grazvydas Ignotas <notasas@gmail.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-serial@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


[ This patch is targeted for v3.3-rc ]

On OMAP2420-based systems, the PM code ignores the state of the UART
functional clocks when determining what idle state to enter.  This
breaks the serial port now that the UART driver's clock behavior can
be controlled via the PM autosuspend timeout.

To fix, remove the special-case idle handling for the UARTs in the
OMAP2420/2430 PM idle code added by commit
4af4016c53f52b26461b8030211f8427a58fa5ed ("OMAP3: PM: UART: disable
clocks when idle and off-mode support").

Tested on Nokia N800.  This patch is a collaboration between Tony
Lindgren <tony@atomide.com> and Paul Walmsley <paul@pwsan.com>.

Cc: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/pm24xx.c |    8 +-------
 1 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index b8822f8..23de98d 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -82,13 +82,7 @@ static int omap2_fclks_active(void)
 	f1 = omap2_cm_read_mod_reg(CORE_MOD, CM_FCLKEN1);
 	f2 = omap2_cm_read_mod_reg(CORE_MOD, OMAP24XX_CM_FCLKEN2);
 
-	/* Ignore UART clocks.  These are handled by UART core (serial.c) */
-	f1 &= ~(OMAP24XX_EN_UART1_MASK | OMAP24XX_EN_UART2_MASK);
-	f2 &= ~OMAP24XX_EN_UART3_MASK;
-
-	if (f1 | f2)
-		return 1;
-	return 0;
+	return (f1 | f2) ? 1 : 0;
 }
 
 static void omap2_enter_full_retention(void)
-- 
1.7.9

