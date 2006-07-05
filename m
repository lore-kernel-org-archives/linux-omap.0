From: imre.deak@solidboot.com
Subject: [PATCH] ARM: OMAP: omapfb: screen base should be set for allocated
	regions [was Re: Framebuffer driver broken on OSK]
Date: Wed, 5 Jul 2006 18:37:24 +0300
Message-ID: <20060705153724.GA32164@localdomain>
References: <44AA8391.7010708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <44AA8391.7010708@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Dirk,

On Tue, Jul 04, 2006 at 05:04:49PM +0200, Dirk Behme wrote:
> Hi,
> 
> seems that framebuffer on OSK from recent git has some more 
> trouble (not only the missing parameter from my last mail):
> 
> It crashes completely on OSK. Backlight of LCD is enabled, 
> but then: See log below (low level debugging enabled, 
> without no messages).
> 
> Any ideas?

Yes, I forgot to test the fbconsole on OMAP1, now I bumped into this on
1510 as well. Your's is probably the same bug:

diff --git a/drivers/video/omap/lcdc.c b/drivers/video/omap/lcdc.c
index 87ae40b..d89041a 100644
--- a/drivers/video/omap/lcdc.c
+++ b/drivers/video/omap/lcdc.c
@@ -719,6 +719,7 @@ static int alloc_fbmem(struct omapfb_mem
 	}
 	region->size = frame_size;
 	region->paddr = lcdc.vram_phys;
+	region->vaddr = lcdc.vram_virt;
 	region->alloc = 1;
 
 	memset(lcdc.vram_virt, 0, lcdc.vram_size);

--Imre

> 
> Best regards
> 
> Dirk
> 
> ...
> <6>io scheduler anticipatory registered (default)
> <6>omapfb: configured for panel osk
> <6>omapfb: LCDC initialized
> <4>omapfb omapfb: Pixel clock divider value is obsolete.
> Try to set pixel_clock to 8000 and pcd to 0 in 
> drivers/video/omap/lcd_osk.c.
> <4>MUX: initialized PWL
> <1>Unable to handle kernel paging request at virtual address 
> 00024900
> <1>pgd = c0004000
> <1>[00024900] *pgd=00000000
> Internal error: Oops: 805 [#1]
> Modules linked in:
> CPU: 0
> PC is at cfb_imageblit+0x1e0/0x488
> LR is at 0x6
> pc : [<c010fb0c>]    lr : [<00000006>]    Not tainted
> sp : c02939f8  ip : c02a0000  fp : c0293a74
> r10: 00000002  r9 : c02a0000  r8 : 00024900
> r7 : 00000000  r6 : 00000000  r5 : c1af7800  r4 : 00000000
> r3 : 00000000  r2 : 00000001  r1 : 00000000  r0 : 00000004
> [...]
