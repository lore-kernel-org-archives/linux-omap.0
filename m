From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/3] ARM: OMAP: menelaus chip info for H4 board.
Date: Sat, 26 May 2007 19:44:23 -0700
Message-ID: <200705261944.26659.david-b@pacbell.net>
References: <5d5443650705260128vc6f79a0rdaa220dc0527e79d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <5d5443650705260128vc6f79a0rdaa220dc0527e79d@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

See the appended patch ... the #ifdefs shouldn't exist, and
if you're going to define the IRQ there (as you should) then
the pinmux must move out of the driver (maybe the board uses
a GPIO for some reason).

I threw in another I2C device too.

- Dave

==============	CUT HERE
Tweak Trilok's h4 i2c boardinfo patch:

  - Don't #ifdef
  - Declare the rv5c387a RTC too
  - Move irq pinmux out of the driver into board-specific init

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

---
NOTE:  board-n800 may need a similar pinmux change... and yes,
I prefer the "one board-X.c" style.

 arch/arm/mach-omap2/board-h4.c |   10 ++++++++--
 drivers/i2c/chips/menelaus.c   |    4 ----
 2 files changed, 8 insertions(+), 6 deletions(-)

--- h4.orig/arch/arm/mach-omap2/board-h4.c	2007-05-26 19:35:17.000000000 -0700
+++ h4/arch/arm/mach-omap2/board-h4.c	2007-05-26 19:35:24.000000000 -0700
@@ -493,12 +493,15 @@ static void __init tusb_evm_setup(void)
 #endif
 
 static struct i2c_board_info __initdata h4_i2c_board_info[] = {
-#ifdef CONFIG_MENELAUS
+	{
+		I2C_BOARD_INFO("rtc-rs5c372", 0x32),
+		.type = "rv5c387a",
+		/* no IRQ wired to OMAP; nINTB goes to AGPS */
+	},
 	{
 		I2C_BOARD_INFO("menelaus", 0x72),
 		.irq = INT_24XX_SYS_NIRQ,
 	},
-#endif
 };
 
 static void __init omap_h4_init(void)
@@ -529,6 +532,9 @@ static void __init omap_h4_init(void)
 	omap_cfg_reg(V19_24XX_USB1_RCV);
 #endif
 
+	/* Menelaus interrupt */
+	omap_cfg_reg(W19_24XX_SYS_NIRQ);
+
 	i2c_register_board_info(1, h4_i2c_board_info,
 			ARRAY_SIZE(h4_i2c_board_info));
 
--- h4.orig/drivers/i2c/chips/menelaus.c	2007-05-26 19:35:15.000000000 -0700
+++ h4/drivers/i2c/chips/menelaus.c	2007-05-26 19:35:24.000000000 -0700
@@ -43,7 +43,6 @@
 #include <asm/mach-types.h>
 #include <asm/mach/irq.h>
 
-#include <asm/arch/mux.h>
 #include <asm/arch/gpio.h>
 #include <asm/arch/menelaus.h>
 
@@ -834,9 +833,6 @@ static int menelaus_probe(struct i2c_cli
 		goto fail1;
 	}
 
-	/* Most likely Menelaus interrupt is at SYS_NIRQ */
-	omap_cfg_reg(W19_24XX_SYS_NIRQ);
-
 	/* Ack and disable all Menelaus interrupts */
 	menelaus_write_reg(MENELAUS_INT_ACK1, 0xff);
 	menelaus_write_reg(MENELAUS_INT_ACK2, 0xff);
