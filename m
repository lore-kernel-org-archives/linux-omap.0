From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: Problem tryhing to bring up new LCD on OMAP Logic board
Date: Wed, 26 Aug 2009 10:44:00 +0530
Message-ID: <19F8576C6E063C45BE387C64729E73940436A49FBA@dbde02.ent.ti.com>
References: <1251227246.16110.71.camel@blitz>
	 <5A47E75E594F054BAF48C5E4FC4B92AB0309C86152@dbde02.ent.ti.com>
	 <1251230795.16110.76.camel@blitz>
	 <19F8576C6E063C45BE387C64729E73940436A49F56@dbde02.ent.ti.com>
 <1251259720.16110.84.camel@blitz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55264 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756360AbZHZFOI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Aug 2009 01:14:08 -0400
In-Reply-To: <1251259720.16110.84.camel@blitz>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Barada <peterb@logicpd.com>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, linux-omap <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Peter Barada [mailto:peterb@logicpd.com]
> Sent: Wednesday, August 26, 2009 9:39 AM
> To: Hiremath, Vaibhav
> Cc: Gadiyar, Anand; linux-omap
> Subject: RE: Problem tryhing to bring up new LCD on OMAP Logic board
> 
> On Wed, 2009-08-26 at 08:33 +0530, Hiremath, Vaibhav wrote:
> > > -----Original Message-----
> > > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > > owner@vger.kernel.org] On Behalf Of Peter Barada
> > > Sent: Wednesday, August 26, 2009 1:37 AM
> > > To: Gadiyar, Anand
> > > Cc: linux-omap
> > > Subject: RE: Problem tryhing to bring up new LCD on OMAP Logic
> board
> > >
> > > On Wed, 2009-08-26 at 00:51 +0530, Gadiyar, Anand wrote:
> > > > > I'm using 2.6.31-rc5 from Kevin's PM branch (commit ID
> > > > > 70a1f2249bbe765f78cf5e220e4e3f539b41eb7f) and I'm trying to
> add
> > > in LCD
> > > > > panel support for our OMAP boards.
<snip>
> > >
> > > Which is pretty slow (omap3evm pixclock is 26MHz...).
> > >
> > > What could be causing the fifo to underflow?
> > [Hiremath, Vaibhav] Can you please provide Dispc and GFX register
> dump?
> 
> Unfortunately the kernel doesn't get to a prompt as its suffering
> the
> video interrupt storm and overwhelms the console.
> 
> The lcd_panel structure passed to omap_register_panel() is:
> 
>   {
> 	.name		= "15",
> 	.config		= OMAP_LCDC_PANEL_TFT | OMAP_LCDC_INV_VSYNC
> |
> OMAP_LCDC_INV_HSYNC,
> 
> 	.bpp		= 16,
> 	.data_lines	= 16,
> 	.x_res		= 480,
> 	.y_res		= 272,
> 	.pixel_clock	= 10000,
> 	.hsw		= 41,
> 	.hfp		= 2,
> 	.hbp		= 2,
> 	.vsw		= 2,
> 	.vfp		= 2,
> 	.vbp		= 3,
> 
> 	.init		= omap3logic_panel_init,
> 	.cleanup	= omap3logic_panel_cleanup,
> 	.enable		= omap3logic_panel_enable,
> 	.disable	= omap3logic_panel_disable,
> 	.get_caps	= omap3logic_panel_get_caps,
> 	.set_bklight_level      = omap3logic_bklight_setlevel,
> 	.get_bklight_level      = omap3logic_bklight_getlevel,
> 	.get_bklight_max        = omap3logic_bklight_getmaxlevel,
>   }
> 
> where the init only sets up and sequences the enable/backlight GPIO,
> using a 300mS delay between the init and backlight to make sure that
> the
> clocks provided to the panel have enough time to initialize the
> panel
> (LQ043T1DG01) before the backlight is turned on.
> 
[Hiremath, Vaibhav] Fortunately I had interfaced same LCD panel from Logic-PD with OMAP-DSS IP, you have to add delay in dpi.c file before panel->enable function call. Below is the code snippet and timing parameters which I used - 

static int dpi_display_enable(struct omap_display *display)
{
.........
	/*This dealy is required as per LCD (lq043t1dg01) spec */
	mdelay(300);

	r = panel->enable(display);
.....

}
static int sharp_ls_panel_enable(struct omap_display *display)
{
	int r = 0;

	/* wait couple of vsyncs until enabling the LCD */
	msleep(50);

	if (display->hw_config.panel_enable)
		r = display->hw_config.panel_enable(display);

	return r;
}

static void sharp_ls_panel_disable(struct omap_display *display)
{
	if (display->hw_config.panel_disable)
		display->hw_config.panel_disable(display);

	/* wait at least 5 vsyncs after disabling the LCD */

	msleep(100);
}

static struct omap_panel sharp_ls_panel = {
	.owner		= THIS_MODULE,
	.name		= "sharp-lq043t1dg01",
	.init		= sharp_ls_panel_init,
	.cleanup	= sharp_ls_panel_cleanup,
	.enable		= sharp_ls_panel_enable,
	.disable	= sharp_ls_panel_disable,
	.suspend	= sharp_ls_panel_suspend,
	.resume		= sharp_ls_panel_resume,

	.timings = {
		.x_res = 480,
		.y_res = 272,

		.pixel_clock	= 9000,

		.hsw		= 42,
		.hfp		= 3,
		.hbp		= 2,

		.vsw		= 11,
		.vfp		= 3,
		.vbp		= 2,
	},

	.acb		= 0,

	.config	= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |	OMAP_DSS_LCD_IHS |
		OMAP_DSS_LCD_IEO,
};


> If I can get it to come up, how can I dump out the DISPC/GFX
> register
> set from Linux (is it in a debugfs file)?
> 
[Hiremath, Vaibhav] For register dump you can make use of /dev/mem device node which will allow you to read physical memory. Just google for devmem.c, you will get one sample application, you just compile it and it should be ready to use.

Syntax for devmem is - 

./devmem.o -r -4 -l <size in bytes> <physical address>


Thanks,
Vaibhav

> > Thanks,
> > Vaibhav
> > >
> > > --
> > > Peter Barada <peterb@logicpd.com>
> > > Logic Product Development, Inc.
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe linux-
> > > omap" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-
> info.html
> >
> --
> Peter Barada <peterb@logicpd.com>
> Logic Product Development, Inc.

