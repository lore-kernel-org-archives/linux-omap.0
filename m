From: Imre Deak <imre.deak@nokia.com>
Subject: Re: [Linux-fbdev-devel] [PATCH 08/20] omapfb: Add support for the
	OMAP3 EVM LCD
Date: Tue, 16 Jun 2009 13:54:54 +0300
Message-ID: <20090616105454.GE32105@localhost>
References: <1244137965-8937-1-git-send-email-imre.deak@nokia.com> <fab39c1a822c428466db6a19531be646d483664e.1244131952.git.imre.deak@nokia.com> <e7f92ea9f0a823f7be401e34243754141b7f72c1.1244131952.git.imre.deak@nokia.com> <e9040774f324311979aebd3fa5fa71d20890d433.1244131952.git.imre.deak@nokia.com> <833ed44e61e3d4093eb27b55b97252967e042d41.1244131952.git.imre.deak@nokia.com> <5ba715a9dbc88b8c3a8225bc1cfdabd3faffe00f.1244131952.git.imre.deak@nokia.com> <646692ce09a12e1a8a2d4072097b4d440b7de5d5.1244131952.git.imre.deak@nokia.com> <b0e578438bb53d9fbf333e5bd10d4d33f869b373.1244131952.git.imre.deak@nokia.com> <9139035cc12b22600135677cd5d3096c1dcd286d.1244131952.git.imre.deak@nokia.com> <20090614233318.e397a907.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:21437 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751261AbZFPK42 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Jun 2009 06:56:28 -0400
Content-Disposition: inline
In-Reply-To: <20090614233318.e397a907.krzysztof.h1@poczta.fm>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Antonino Daplas <adaplas@gmail.com>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, Tony Lindgren <tony@atomide.com>, "Valkeinen Tomi (Nokia-D/Helsinki)" <Tomi.Valkeinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Steve Sakoman <steve@sakoman.com>

On Sun, Jun 14, 2009 at 11:33:18PM +0200, ext Krzysztof Helt wrote:
> On Thu,  4 Jun 2009 20:52:33 +0300
> Imre Deak <imre.deak@nokia.com> wrote:
> 
> > From: Steve Sakoman <steve@sakoman.com>
> > 
> > Add LCD support for OMAP3 EVM
> > 
> > Backlight support by Arun C <arunedarath@mistralsolutions.com>
> > 
> > Signed-off-by: Steve Sakoman <steve@sakoman.com>
> > Acked-by: Syed Mohammed Khasim <khasim@ti.com>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > Fixed-by: Jarkko Nikula <jarkko.nikula@gmail.com>
> > Fixed-by: David Brownell <dbrownell@users.sourceforge.net>
> > Signed-off-by: Imre Deak <imre.deak@nokia.com>
> > ---
> >  drivers/video/omap/Makefile       |    1 +
> >  drivers/video/omap/lcd_omap3evm.c |  191 +++++++++++++++++++++++++++++++++++++
> >  2 files changed, 192 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/video/omap/lcd_omap3evm.c
> > 
> > diff --git a/drivers/video/omap/Makefile b/drivers/video/omap/Makefile
> > index 96d2d43..4345157 100644
> > --- a/drivers/video/omap/Makefile
> > +++ b/drivers/video/omap/Makefile
> > @@ -30,6 +30,7 @@ objs-y$(CONFIG_MACH_OMAP_APOLLON) += lcd_apollon.o
> >  objs-y$(CONFIG_MACH_OMAP_2430SDP) += lcd_2430sdp.o
> >  objs-y$(CONFIG_MACH_OMAP_3430SDP) += lcd_2430sdp.o
> >  objs-y$(CONFIG_MACH_OMAP2EVM) += lcd_omap2evm.o
> > +objs-y$(CONFIG_MACH_OMAP3EVM) += lcd_omap3evm.o
> >  objs-y$(CONFIG_FB_OMAP_LCD_MIPID) += lcd_mipid.o
> >  
> >  omapfb-objs := $(objs-yy)
> > diff --git a/drivers/video/omap/lcd_omap3evm.c b/drivers/video/omap/lcd_omap3evm.c
> > new file mode 100644
> > index 0000000..1c3d814
> > --- /dev/null
> > +++ b/drivers/video/omap/lcd_omap3evm.c
> > @@ -0,0 +1,191 @@
> > +/*
> > + * LCD panel support for the TI OMAP3 EVM board
> > + *
> > + * Author: Steve Sakoman <steve@sakoman.com>
> > + *
> > + * Derived from drivers/video/omap/lcd-apollon.c
> > + *
> > + * This program is free software; you can redistribute it and/or modify it
> > + * under the terms of the GNU General Public License as published by the
> > + * Free Software Foundation; either version 2 of the License, or (at your
> > + * option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful, but
> > + * WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > + * General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License along
> > + * with this program; if not, write to the Free Software Foundation, Inc.,
> > + * 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/gpio.h>
> > +#include <linux/i2c/twl4030.h>
> > +
> > +#include <mach/mux.h>
> > +#include <mach/omapfb.h>
> > +#include <asm/mach-types.h>
> > +
> > +#define LCD_PANEL_ENABLE_GPIO       153
> > +#define LCD_PANEL_LR                2
> > +#define LCD_PANEL_UD                3
> > +#define LCD_PANEL_INI               152
> > +#define LCD_PANEL_QVGA              154
> > +#define LCD_PANEL_RESB              155
> > +
> > +#define LCD_XRES	 	480
> > +#define LCD_YRES 		640
> > +#define LCD_PIXCLOCK		26000 /* in kHz  */
> > +
> 
> You can drop defines used only once. There are no such defines for
> other panels.

Ok, will fix this and similar places in the other panel drivers.

--Imre

