From: David Brownell <david-b@pacbell.net>
Subject: omap2/pm.c build errors
Date: Wed, 16 Apr 2008 11:50:20 -0700
Message-ID: <200804161150.20609.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp111.sbc.mail.mud.yahoo.com ([68.142.198.210]:39488 "HELO
	smtp111.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750932AbYDPSu1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Apr 2008 14:50:27 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

arch/arm/mach-omap2/pm.c: In function 'pm_init_serial_console':
arch/arm/mach-omap2/pm.c:188: error: expected ';' before 'break'
arch/arm/mach-omap2/pm.c:191: error: expected ';' before 'break'
arch/arm/mach-omap2/pm.c:193: error: 'PM_WKEN2' undeclared (first use in this function)
arch/arm/mach-omap2/pm.c:193: error: (Each undeclared identifier is reported only once
arch/arm/mach-omap2/pm.c:193: error: for each function it appears in.)
arch/arm/mach-omap2/pm.c:194: error: expected ';' before 'break'


... wasn't there a patch for this?  That's with current GIT.

The "no semicolons after function calls" fix is obvious (and
is also a "that patch was never build-tested), but WKEN2 is
not quite clear (but see my guess below).



--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -184,13 +184,13 @@ static void pm_init_serial_console(void)
 	}
 	switch (serial_console_uart) {
 	case 1:
-		prm_set_mod_reg_bits(OMAP24XX_ST_UART1, CORE_MOD, PM_WKEN1)
+		prm_set_mod_reg_bits(OMAP24XX_ST_UART1, CORE_MOD, PM_WKEN1);
 		break;
 	case 2:
-		prm_set_mod_reg_bits(OMAP24XX_ST_UART2, CORE_MOD, PM_WKEN1)
+		prm_set_mod_reg_bits(OMAP24XX_ST_UART2, CORE_MOD, PM_WKEN1);
 		break;
 	case 3:
-		prm_set_mod_reg_bits(OMAP24XX_ST_UART3, CORE_MOD, PM_WKEN2)
+		prm_set_mod_reg_bits(OMAP24XX_ST_UART3, CORE_MOD, OMAP24XX_PM_WKEN2);
 		break;
 	}
 }

