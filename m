From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: linux-next: manual merge of the omap_dss2 tree with the omap tree
Date: Fri, 18 Feb 2011 13:25:15 +1100
Message-ID: <20110218132515.e071230f.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
Sender: linux-next-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King <rmk+kernel@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Senthilvadivu Guruswamy <svadivu@ti.com>, Sumit Semwal <sumit.semwal@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Tomi,

Today's linux-next merge of the omap_dss2 tree got a conflict in
arch/arm/mach-omap2/board-am3517evm.c between commit
3dc3bad6f1b316d79d9d1d596a590b5097cb3dc4 ("ARM: OMAP2: use early init
hook") from the omap tree and commit
603aa0662c26ad05c3ecf1b912f8bebf76dab73d ("OMAP2, 3: DSS2: board files:
replace platform_device_register with omap_display_init()") from the
omap_dss2 tree.

Just context changes.  I fixed it up (see below) and can carry the fix as
necessary.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --cc arch/arm/mach-omap2/board-am3517evm.c
index d0d0f55,548f524..0000000
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@@ -392,11 -384,7 +384,7 @@@ static struct omap_dss_board_info am351
  static struct omap_board_config_kernel am3517_evm_config[] __initdata = {
  };
  
- static struct platform_device *am3517_evm_devices[] __initdata = {
- 	&am3517_evm_dss_device,
- };
- 
 -static void __init am3517_evm_init_irq(void)
 +static void __init am3517_evm_init_early(void)
  {
  	omap_board_config = am3517_evm_config;
  	omap_board_config_size = ARRAY_SIZE(am3517_evm_config);
