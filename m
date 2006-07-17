From: Kevin Hilman <khilman@deeprooted.net>
Subject: RE: 2420 boot BUG(): failure to map SRAM
Date: Mon, 17 Jul 2006 12:59:34 -0500
Message-ID: <1153159174.5729.10.camel@imap.mvista.com>
References: <EA12F909C0431D458B9D18A176BEE4A5069458BC@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-QEZJvc7dHkiWVr/hfiyi"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <EA12F909C0431D458B9D18A176BEE4A5069458BC@dlee02.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


--=-QEZJvc7dHkiWVr/hfiyi
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2006-07-12 at 18:59 -0500, Woodruff, Richard wrote:
> Kevin likely has an EMU device and yours is GP.
> 
> It seems like when I fist did this aspect it was correct.  Somehow it
> got messed up along the way.
> 
> -a- The physical base address of the static remap operation should be
> 40200000 in either case.  The size needs to be 1M divisible to generate
> a section entry.  The virtual address needs to be 2M divisible to work
> with the 2.6 allocation scheme.
> 
> -b- The useable physical OMAP2-SRAM then either starts at 40200000 or
> 4020f800 depending on device type.  Therefore in this code you need to
> set the virtually mapped region the same in both cases, but sets its API
> useable range to that of the actual device.  The push/pop APIs have
> global variables for this.

Here's a patch which sets the static mapping to the same for both device
types, but doesn't modify 'omap_sram_base' used elsewhere for the usable
address.

Richard, is this sufficient?

Kevin


--=-QEZJvc7dHkiWVr/hfiyi
Content-Disposition: attachment; filename=sram-mapping.patch
Content-Type: text/x-patch; name=sram-mapping.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

ARM: OMAP: Fix SRAM static mapping for EMU devices.

Signed-off-by: Kevin Hilman <khilman@deeprooted.net>

---
commit 9945b4f622be0bf89821991122752aeaad19528d
tree bc667f727a4c8ab9b11a584fe87f815675eedee9
parent 64929d882591a213cb51407992f28c42121b2f7d
author Kevin Hilman <khilman@deeprooted.net> Mon, 17 Jul 2006 11:05:50 -0700
committer Kevin Hilman <khilman@deeprooted.net> Mon, 17 Jul 2006 11:05:50 -0700

 arch/arm/plat-omap/sram.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 7b0b924..045b27b 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -190,10 +190,7 @@ void __init omap_map_sram(void)
 	if (cpu_is_omap24xx()) {
 		omap_sram_io_desc[0].virtual = OMAP2_SRAM_VA;
 
-		if (is_sram_locked())
-			base = OMAP2_SRAM_PUB_PA;
-		else
-			base = OMAP2_SRAM_PA;
+		base = OMAP2_SRAM_PA;
 		base = ROUND_DOWN(base, PAGE_SIZE);
 		omap_sram_io_desc[0].pfn = __phys_to_pfn(base);
 	}

--=-QEZJvc7dHkiWVr/hfiyi
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--=-QEZJvc7dHkiWVr/hfiyi--
