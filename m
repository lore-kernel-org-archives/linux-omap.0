From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/4] FB: sync with N800 tree (support for dynamic SRAM
	allocations)
Date: Wed, 28 Mar 2007 16:38:14 -0700
Message-ID: <200703281638.14657.david-b@pacbell.net>
References: <20070305120706.GA4435@bitbox.mine.nu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20070305120706.GA4435@bitbox.mine.nu>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Monday 05 March 2007 4:07 am, Imre Deak wrote:
> - in addition to fixed FB regions - as passed by the bootloader -
>   allow dynamic allocations
> - do some more checking against overlapping / reserved regions
> - move the FB specific parts out from sram.c to fb.c
> 
> Signed-off-by: Imre Deak <imre.deak@solidboot.com>
> ---
>  arch/arm/mach-omap1/io.c           |    4 +-
>  arch/arm/mach-omap2/io.c           |    3 +-
>  arch/arm/plat-omap/fb.c            |  271 ++++++++++++++++++++++++++++++++----
>  arch/arm/plat-omap/sram.c          |   60 ++-------
>  include/asm-arm/arch-omap/omapfb.h |    5 +
>  include/asm-arm/arch-omap/sram.h   |    3 -
>  6 files changed, 261 insertions(+), 85 deletions(-)

OK, I verified:  reverting this lets my H4 board boot.
Alternatively, the fix is to get rid of a GCC warning,
so that stack garbage doesn't get used ...

=========	CUT HERE
Fix GCC-reported compile time bug which prevents booting
when the framebuffer code is disabled.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

--- a/arch/arm/plat-omap/fb.c
+++ b/arch/arm/plat-omap/fb.c
@@ -327,7 +327,10 @@ unsigned long omapfb_reserve_sram(unsign
 				  unsigned long sram_vstart,
 				  unsigned long sram_size,
 				  unsigned long start_avail,
-				  unsigned long size_avail) {}
+				  unsigned long size_avail)
+{
+	return 0;
+}
 
 
 #endif
