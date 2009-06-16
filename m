From: Imre Deak <imre.deak@nokia.com>
Subject: Re: [PATCH 11/20] omapfb: Add support for the ZOOM MDK LCD
Date: Tue, 16 Jun 2009 14:10:44 +0300
Message-ID: <20090616111044.GF32105@localhost>
References: <e9040774f324311979aebd3fa5fa71d20890d433.1244131952.git.imre.deak@nokia.com> <833ed44e61e3d4093eb27b55b97252967e042d41.1244131952.git.imre.deak@nokia.com> <5ba715a9dbc88b8c3a8225bc1cfdabd3faffe00f.1244131952.git.imre.deak@nokia.com> <646692ce09a12e1a8a2d4072097b4d440b7de5d5.1244131952.git.imre.deak@nokia.com> <b0e578438bb53d9fbf333e5bd10d4d33f869b373.1244131952.git.imre.deak@nokia.com> <9139035cc12b22600135677cd5d3096c1dcd286d.1244131952.git.imre.deak@nokia.com> <08ba068bda363adf4cb8a1f5afe11245c828d017.1244131952.git.imre.deak@nokia.com> <057471246e776de4c452b4ba2ebf2a4579f3171c.1244131952.git.imre.deak@nokia.com> <310d4aa52bfd6dd15664286643ca8a9703787dce.1244131952.git.imre.deak@nokia.com> <20090614234716.fa6f8f4b.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:23474 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752005AbZFPLMO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Jun 2009 07:12:14 -0400
Content-Disposition: inline
In-Reply-To: <20090614234716.fa6f8f4b.krzysztof.h1@poczta.fm>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Antonino Daplas <adaplas@gmail.com>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "Valkeinen Tomi (Nokia-D/Helsinki)" <Tomi.Valkeinen@nokia.com>, "Stanley.Miao" <stanley.miao@windriver.com>

On Sun, Jun 14, 2009 at 11:47:16PM +0200, ext Krzysztof Helt wrote:
> On Thu,  4 Jun 2009 20:52:36 +0300
> Imre Deak <imre.deak@nokia.com> wrote:
> [...]
> > diff --git a/drivers/video/omap/lcd_ldp.c b/drivers/video/omap/lcd_ldp.c
> > new file mode 100644
> > index 0000000..8925230
> > --- /dev/null
> > +++ b/drivers/video/omap/lcd_ldp.c
> > [...]
> > +static void ldp_panel_disable(struct lcd_panel *panel)
> > +{
> > +     gpio_direction_output(LCD_PANEL_ENABLE_GPIO, 0);
> > +     gpio_direction_output(LCD_PANEL_BACKLIGHT_GPIO, 0);
> > +
> > +     t2_out(PM_RECEIVER, 0x0, TWL4030_VPLL2_DEDICATED);
> > +     t2_out(PM_RECEIVER, 0x0, TWL4030_VPLL2_DEV_GRP);
> > +     mdelay(4);
> 
> Use the msleep() instead of the mdelay().

Ok, will fix it and the similar places in the other panel drivers.

--Imre

