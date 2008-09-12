From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: omap-sdp3430_Rotation patch
Date: Fri, 12 Sep 2008 15:26:13 +0300
Message-ID: <20080912122613.GH759@gandalf.research.nokia.com>
References: <759850.3803.qm@web32003.mail.mud.yahoo.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:50405 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753203AbYILM1H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Sep 2008 08:27:07 -0400
Content-Disposition: inline
In-Reply-To: <759850.3803.qm@web32003.mail.mud.yahoo.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext rajesh k <hirajeshk@yahoo.com>
Cc: linux-omap@vger.kernel.org, krajesh@ti.com

Generally the code is difficult to read. A bit of coding style would
help. A few comments below.

On Fri, Sep 12, 2008 at 05:00:21AM -0700, ext rajesh k wrote:
> >From Rajesh K krajesh<krajesh@ti.com>
> 
> OMAP FBDEV: VRFB framebuffer rotation support for OMAP SDP 3430
> 
> This patch provides rotation support OMAP SDP 3430. You will have to append
> video=omapfb:rotate=0 parameters to your u-boot arguments to get this working.
> This supports 0,90,180 and 270 degree rotations.
> 
> Signed-off-by: Rajesh  K     < krajesh@ti.com >
>                Iqbal shareef < iqbal@ti.com >
> ---
>  arch/arm/plat-omap/include/mach/omapfb.h |    2 +-
>  drivers/video/omap/dispc.c               |  167 +++++++++++++++++++++++++++++-
>  drivers/video/omap/dispc.h               |   31 ++++++
>  drivers/video/omap/omapfb_main.c         |   27 +++---
>  4 files changed, 208 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/mach/omapfb.h b/arch/arm/plat-omap/include/mach/omapfb.h
> index a4a84f3..6abc327 100644
> --- a/arch/arm/plat-omap/include/mach/omapfb.h
> +++ b/arch/arm/plat-omap/include/mach/omapfb.h
> @@ -306,7 +306,7 @@ struct lcd_ctrl {
>  					   int screen_width,
>  					   int pos_x, int pos_y, int width,
>  					   int height, int color_mode);
> -	int		(*set_rotate)	  (int angle);
> +	int		(*set_rotate)	  (int plane, int angle);
>  	int		(*setup_mem)	  (int plane, size_t size,
>  					   int mem_type, unsigned long *paddr);
>  	int		(*mmap)		  (struct fb_info *info,
> diff --git a/drivers/video/omap/dispc.c b/drivers/video/omap/dispc.c
> index ce4c4de..f882db4 100644
> --- a/drivers/video/omap/dispc.c
> +++ b/drivers/video/omap/dispc.c
> @@ -24,11 +24,9 @@
>  #include <linux/vmalloc.h>
>  #include <linux/clk.h>
>  #include <linux/io.h>
> -
>  #include <mach/sram.h>
>  #include <mach/omapfb.h>
>  #include <mach/board.h>
> -
>  #include "dispc.h"
>  
>  #define MODULE_NAME			"dispc"
> @@ -149,6 +147,20 @@
>  #define RESMAP_MASK(_page_nr)						\
>  	(1 << ((_page_nr) & (sizeof(unsigned long) * 8 - 1)))
>  
> +dma_addr_t save_paddr;
> +unsigned long save_vaddr;
> +
> +struct {
> +	dma_addr_t      paddr[4];
> +	unsigned long   vaddr[4];
> +	u32 xoffset;
> +	u32 yoffset;
> +	unsigned long size_val;
> +	unsigned long control_val;
> +} vrfb;
> +
> +static int omap2_disp_set_vrfb(u32 width, u32 height, u32 bytes_per_pixel);
> +
>  struct resmap {
>  	unsigned long	start;
>  	unsigned	page_cnt;
> @@ -459,6 +471,108 @@ static int omap_dispc_setup_plane(int plane, int channel_out,
>  	return r;
>  }
>  
> +/*
> +* function: pages_per_side : Will provide page height & width
> +*      @ img_side : img_side
> +*      @ page_exp : page_exp
> +*      Return Value: Will return an integer.
> +*/

should be:

/**
 * pages_per_side - Will provide page height & width
 *
 * @img_side : image side (or whatever you meant here :-p)
 * @page_exp : page exp (what does that exp stand for ?)
 *
 * Return 0 on success or a negative errno.
 */

> +static inline u32
> +pages_per_side(u32 img_side, u32 page_exp)

These fit in one line:

static inline u32 pages_per_side(u32 img_side, u32 page_exp)

> +{
> +	return (u32) (img_side + (1<<page_exp) - 1) >> page_exp;

add spaces arroun <<

> +/*
> +*      omap2_disp_set_vrfb : Will configure VRFB Support.Its a rotation engine
> +*      which will supports rotations of 0,90,180,270 degrees.
> +*      @width: Width of the  image
> +*      @height : height of the image
> +*      @bytes_per_pixel : color depth of the image
> +*      return value :  will return an integer value
> +*/

Fix this comment according to the above.

> +static int omap2_disp_set_vrfb(u32 width, u32 height, u32 bytes_per_pixel)
> +{
> +	int page_width_exp, page_height_exp, pixel_size_exp;
> +	int context = 0;
> +	vrfb.size_val = 0;
> +	vrfb.control_val = 0;
> +	pixel_size_exp = bytes_per_pixel >> 1;
> +	page_width_exp = PAGE_WIDTH_EXP;
> +	page_height_exp = PAGE_HEIGHT_EXP;

add a blank line here to separete variable declaration and function
body.

> +	width = ((1<<page_width_exp) *

spaces around <<

> +			(pages_per_side(width * bytes_per_pixel,
> +			page_width_exp))) >> pixel_size_exp;
> +	height = (1<<page_height_exp) *
> +			(pages_per_side(height, page_height_exp));
> +	__raw_writel(save_paddr, SMS_ROT0_PHYSICAL_BA(context));
> +	__raw_writel(0, SMS_ROT0_SIZE(context));
> +	vrfb.size_val |= (width << SMS_IMAGEWIDTH_OFFSET)|
> +			(height << SMS_IMAGEHEIGHT_OFFSET);
> +	__raw_writel(vrfb.size_val, SMS_ROT0_SIZE(context));
> +	__raw_writel(0, SMS_ROT_CONTROL(context));
> +	vrfb.control_val |= pixel_size_exp << SMS_PS_OFFSET
> +			| (page_width_exp - pixel_size_exp) << SMS_PW_OFFSET
> +			| page_height_exp << SMS_PH_OFFSET;
> +	__raw_writel(vrfb.control_val, SMS_ROT_CONTROL(context));

add blank line here.

> +	return 0;
> +}
> +
> +/*
> +*      omap_dispc_set_rotate : configuring rotation registers based on angle.
> +*      @ plane: graphics or video pipe line
> +*      @ angle: Rotation angle.
> +*      Return Value: Returns an integer.
> +*/

fix comment.

> +int omap_dispc_set_rotate(int plane, int angle)
> +{
> +	int width, height;
> +	u32 addr_base;
> +	u32 Bpp;
> +	width = dispc.fbdev->fb_info[0]->var.xres;
> +	height = dispc.fbdev->fb_info[0]->var.yres;
> +	Bpp = dispc.fbdev->fb_info[0]->var.bits_per_pixel / 8;

avoid CaMeLCaSe, everything should be lower case. Add a blank line here
as well.

> +	if (plane == OMAPFB_PLANE_GFX) {
> +		enable_lcd_clocks(1);
> +		/* clear GOLCD bit */
> +		MOD_REG_FLD(DISPC_CONTROL, 0x20, 0);
> +		omap2_disp_set_vrfb(width, height, Bpp);
> +		switch (angle) {
> +		case 0:
> +			addr_base = vrfb.paddr[0];
> +			dispc_write_reg(DISPC_GFX_BA0, addr_base);
> +			dispc_write_reg(DISPC_GFX_PIXEL_INC, 1);
> +			dispc_write_reg(DISPC_GFX_ROW_INC,
> +				(ROT_LINE_LENGTH - width) * Bpp + 1);
> +			break;
> +		case 90:
> +			addr_base = vrfb.paddr[1];
> +			dispc_write_reg(DISPC_GFX_BA0, addr_base);
> +			dispc_write_reg(DISPC_GFX_PIXEL_INC, 1);
> +			dispc_write_reg(DISPC_GFX_ROW_INC,
> +				(ROT_LINE_LENGTH - height) * Bpp + 1);
> +			break;
> +		case 180:
> +			addr_base = vrfb.paddr[2];
> +			dispc_write_reg(DISPC_GFX_BA0, addr_base);
> +			dispc_write_reg(DISPC_GFX_PIXEL_INC, 1);
> +			dispc_write_reg(DISPC_GFX_ROW_INC,
> +				(ROT_LINE_LENGTH - width) * Bpp + 1);
> +			break;
> +		case 270:
> +			addr_base = vrfb.paddr[3];
> +			dispc_write_reg(DISPC_GFX_BA0, addr_base);
> +			dispc_write_reg(DISPC_GFX_PIXEL_INC, 1);
> +			dispc_write_reg(DISPC_GFX_ROW_INC,
> +				(ROT_LINE_LENGTH - height) * Bpp + 1);
> +			break;
> +		}
> +		MOD_REG_FLD(DISPC_CONTROL, 0x20, 0x20);
> +		enable_lcd_clocks(0);
> +	}

add a blank line here.

> +static void omap2_alloc_vrfb_mem(struct omapfb_mem_desc *req_vram)
> +{
> +	memset(&vrfb, 0, sizeof(vrfb));
> +	vrfb.paddr[0] = SMS_ROT_VIRT_BASE(0, 0);
> +	vrfb.paddr[1] = SMS_ROT_VIRT_BASE(0, 90);
> +	vrfb.paddr[2] = SMS_ROT_VIRT_BASE(0, 180);
> +	vrfb.paddr[3] = SMS_ROT_VIRT_BASE(0, 270);
> +
> +	if (!request_mem_region(vrfb.paddr[0],
> +		req_vram->region[0].size, "omapfb")) {
> +		printk(KERN_ERR "omapfb: can't reserve VRFB0 area\n");
> +	}
> +
> +	if (!request_mem_region(vrfb.paddr[1],
> +		req_vram->region[0].size, "omapfb")) {
> +		printk(KERN_ERR "omapfb: can't reserve VRFB90 area\n");
> +	}
> +
> +	if (!request_mem_region(vrfb.paddr[2],
> +		req_vram->region[0].size, "omapfb")) {
> +		printk(KERN_ERR "omapfb: can't reserve VRFB180 area\n");
> +	}
> +
> +	if (!request_mem_region(vrfb.paddr[3],
> +		req_vram->region[0].size, "omapfb")) {
> +		printk(KERN_ERR "omapfb: can't reserve VRFB270 area\n");
> +	}
> +
> +	vrfb.vaddr[0] = (unsigned long)ioremap(vrfb.paddr[0],
> +			req_vram->region[0].size);
> +	vrfb.vaddr[1] = (unsigned long)ioremap(vrfb.paddr[1],
> +			req_vram->region[0].size);
> +	vrfb.vaddr[2] = (unsigned long)ioremap(vrfb.paddr[2],
> +			req_vram->region[0].size);
> +	vrfb.vaddr[3] = (unsigned long)ioremap(vrfb.paddr[3],
> +			req_vram->region[0].size);
> +	if ((!vrfb.vaddr[0]) || (!vrfb.vaddr[1]) || (!vrfb.vaddr[2])
> +				|| (!vrfb.vaddr[3])) {
> +		printk(KERN_ERR "omapfb: can't map rotated view(s)\n");
> +	}

no brackets for one line if()

-- 
balbi
