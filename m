From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: linux-next: manual merge of the omap_dss2 tree with the omap tree
Date: Thu, 17 Feb 2011 13:10:26 +1100
Message-ID: <20110217131026.aacb119f.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Charulatha V <charu@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Senthilvadivu Guruswamy <svadivu@ti.com>, Sumit Semwal <sumit.semwal@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Tomi,

Today's linux-next merge of the omap_dss2 tree got a conflict in
arch/arm/mach-omap2/omap_hwmod_2420_data.c between commit
eb969b4f07175960fa0b325e6c9bd2093ab49645 ("OMAP2420: hwmod data: Add
McSPI") from the omap tree and commit
e9ca66e751e89d2d5323d809ecb2b54f4e255d8d ("OMAP2420: hwmod data: add DSS
DISPC RFBI VENC") from the omap_dss2 tree.

I fixed it up (see below) and can carry the fix as necessary.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --cc arch/arm/mach-omap2/omap_hwmod_2420_data.c
index 7fffd34,21014de..0000000
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@@ -18,8 -18,8 +18,9 @@@
  #include <plat/serial.h>
  #include <plat/i2c.h>
  #include <plat/gpio.h>
 +#include <plat/mcspi.h>
- 
+ #include <plat/l3_2xxx.h>
+ #include <plat/l4_2xxx.h>
  #include "omap_hwmod_common_data.h"
  
  #include "cm-regbits-24xx.h"
