From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.29-rc7-omap] OMAP1:  ASoC buildfix for OSK
Date: Wed, 11 Mar 2009 02:37:25 -0800
Message-ID: <200903110337.25789.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n18.bullet.mail.mud.yahoo.com ([68.142.206.145]:24488 "HELO
	n18.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754125AbZCKKha (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Mar 2009 06:37:30 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: OMAP <linux-omap@vger.kernel.org>, lrg@slimlogic.co.uk, Mark Brown <broonie@sirena.org.uk>

From: David Brownell <dbrownell@users.sourceforge.net>

Buildfix:

  CC      sound/soc/omap/osk5912.o
  sound/soc/omap/osk5912.c: In function 'osk_soc_init':
  sound/soc/omap/osk5912.c:189: error: implicit declaration of function 'clk_get_usecount'
  make[3]: *** [sound/soc/omap/osk5912.o] Error 1

There's no such (standard) clock interface.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
There is currently such an interface in mainline; but there shouldn't
be ... which is why I'm sending this to the ASoC folk too (I think
those clock updates will hit in the 2.6.30 window).

Some of that OMAP1 clock code got hosed anyway; on top of many build
warnings, an oops in at least the OMAP tree:

asoc: tlv320aic23 <-> omap-mcbsp-dai-0 mapping ok
Unable to handle kernel NULL pointer dereference at virtual address 00000014
pgd = c0004000
[00000014] *pgd=00000000
Internal error: Oops: 5 [#1] PREEMPT
Modules linked in:
CPU: 0    Not tainted  (2.6.29-rc7-omap1 #10)
PC is at clk_set_rate+0x60/0x90
LR is at omap1_set_ext_clk_rate+0x28/0x68
pc : [<c00313b8>]    lr : [<c002f7d0>]    psr: 60000093
sp : c1c21f08  ip : c1c21ed0  fp : c1c21f24
r10: 00000001  r9 : 00000000  r8 : c033eb20
r7 : c001a718  r6 : 80000013  r5 : 00000000  r4 : c0321abc
r3 : 00000000  r2 : fefe0878  r1 : 00000018  r0 : c0321abc
Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 0005317f  Table: 10004000  DAC: 00000017
Process swapper (pid: 1, stack limit = 0xc1c20268)
Stack: (0xc1c21f08 to 0xc1c22000)
1f00:                   c0776c24 00000000 00000000 c001a718 c1c21f3c c1c21f28 
1f20: c001a7b4 c0031368 c001fb94 00000000 c1c21fb4 c1c21f40 c0025240 c001a728 
1f40: c1c21f8e c032fa50 c1c4af00 c032fa50 00000100 c06edfb8 c1c21f84 c1c21f68 
1f60: c00dd070 c00dce10 c1c21f84 c1c49d00 c00dd174 c1c21f8e c1c21fb4 c1c21f88 
1f80: c0078ae0 c00dd000 c1c21fac 36330e48 c001fb94 00000000 00000000 00000000 
1fa0: 00000000 00000000 c1c21fcc c1c21fb8 c00084b8 c00251f8 c033eb20 00000000 
1fc0: c1c21fdc c1c21fd0 c00084f4 c00084ac c1c21ff4 c1c21fe0 c000889c c00084e4 
1fe0: 00000000 00000000 00000000 c1c21ff8 c004737c c0008868 00000000 00000000 
Backtrace: 
[<c0031358>] (clk_set_rate+0x0/0x90) from [<c001a7b4>] (osk_soc_init+0x9c/0x118)
 r7:c001a718 r6:00000000 r5:00000000 r4:c0776c24
[<c001a718>] (osk_soc_init+0x0/0x118) from [<c0025240>] (__exception_text_end+0x58/0x190)
....

 sound/soc/omap/osk5912.c |   12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

--- a/sound/soc/omap/osk5912.c
+++ b/sound/soc/omap/osk5912.c
@@ -186,13 +186,6 @@ static int __init osk_soc_init(void)
 		return -ENODEV;
 	}
 
-	if (clk_get_usecount(tlv320aic23_mclk) > 0) {
-		/* MCLK is already in use */
-		printk(KERN_WARNING
-		       "MCLK in use at %d Hz. We change it to %d Hz\n",
-		       (uint) clk_get_rate(tlv320aic23_mclk), CODEC_CLOCK);
-	}
-
 	/*
 	 * Configure 12 MHz output on MCLK.
 	 */
@@ -205,9 +198,8 @@ static int __init osk_soc_init(void)
 		}
 	}
 
-	printk(KERN_INFO "MCLK = %d [%d], usecount = %d\n",
-	       (uint) clk_get_rate(tlv320aic23_mclk), CODEC_CLOCK,
-	       clk_get_usecount(tlv320aic23_mclk));
+	printk(KERN_INFO "MCLK = %d [%d]\n",
+	       (uint) clk_get_rate(tlv320aic23_mclk), CODEC_CLOCK);
 
 	return 0;
 err1:

