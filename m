From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: linux-next: manual merge of the omap tree with Linus' tree
Date: Fri, 30 Oct 2009 11:46:42 +1100
Message-ID: <20091030114642.61bbeb2c.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
Sender: linux-next-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Alexander Shishkin <virtuoso@slind.org>, Ladislav Michl <ladis@linux-mips.org>
List-Id: linux-omap@vger.kernel.org

Hi all,

Today's linux-next merge of the omap tree got a conflict in
arch/arm/mach-omap1/serial.c between commit
c33da3a80074094303d643a90ef589330b491270 ("omap1: Fix redundant UARTs pin
muxing that can break other hardware support") from Linus' tree and
commits 84f90c9cc81d8db172d4f768fc4010f508897366 ("omap: Change low-level
serial init to use ioremap") and acb1aed4a5f23c545073b0d65302e5949f239fa0
("omap: Eliminate OMAP_MAX_NR_PORTS") from the omap tree.

I fixed it up (see below) and can carry the fix for a while.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --cc arch/arm/mach-omap1/serial.c
index d23979b,f82f66e..0000000
--- a/arch/arm/mach-omap1/serial.c
+++ b/arch/arm/mach-omap1/serial.c
@@@ -130,7 -120,17 +120,15 @@@ void __init omap_serial_init(void
  		serial_platform_data[2].uartclk = OMAP1510_BASE_BAUD * 16;
  	}
  
- 	for (i = 0; i < OMAP_MAX_NR_PORTS; i++) {
+ 	for (i = 0; i < ARRAY_SIZE(serial_platform_data) - 1; i++) {
 -		unsigned char reg;
 -
+ 		/* Static mapping, never released */
+ 		serial_platform_data[i].membase =
+ 			ioremap(serial_platform_data[i].mapbase, SZ_2K);
+ 		if (!serial_platform_data[i].membase) {
+ 			printk(KERN_ERR "Could not ioremap uart%i\n", i);
+ 			continue;
+ 		}
+ 
  		switch (i) {
  		case 0:
  			uart1_ck = clk_get(NULL, "uart1_ck");
