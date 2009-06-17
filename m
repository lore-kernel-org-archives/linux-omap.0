From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Remove duplicate definitions
Date: Wed, 17 Jun 2009 02:34:42 -0700
Message-ID: <20090617093441.GH6605@atomide.com>
References: <1245150892-5837-1-git-send-email-premi@ti.com> <20090617085214.GG6605@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52412 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808AbZFQJel (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Jun 2009 05:34:41 -0400
Content-Disposition: inline
In-Reply-To: <20090617085214.GG6605@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [090617 01:52]:
> * Sanjeev Premi <premi@ti.com> [090616 04:15]:
> > Fixes the duplicate definitions of KEY and PERSISTENT_KEY
> > leading to these compile-time warnings:
> > 
> > In file included from arch/arm/mach-omap2/board-omap3evm.c:39:
> > arch/arm/plat-omap/include/mach/keypad.h:38:1: warning: "KEY" redefined
> > In file included from arch/arm/mach-omap2/board-omap3evm.c:27:
> > include/linux/i2c/twl4030.h:341:1: warning: this is the location of the previous definition
> > In file included from arch/arm/mach-omap2/board-omap3evm.c:39:
> > arch/arm/plat-omap/include/mach/keypad.h:39:1: warning: "PERSISTENT_KEY" redefined
> > In file included from arch/arm/mach-omap2/board-omap3evm.c:27:
> > include/linux/i2c/twl4030.h:342:1: warning: this is the location of the previous definition
> 
> Hmm, I think we should rather remove these from keypad.h. Will queue
> a patch into omap-fixes for that.

Sorry, you're right, looks like we have still non-standard headers
for I2C. Will reset those in linux-omap tree.
 
> Tony
>  
> > Signed-off-by: Sanjeev Premi <premi@ti.com>
> > ---
> >  include/linux/i2c/twl4030.h |    8 --------
> >  1 files changed, 0 insertions(+), 8 deletions(-)
> > 
> > diff --git a/include/linux/i2c/twl4030.h b/include/linux/i2c/twl4030.h
> > index 87accda..21e65bf 100644
> > --- a/include/linux/i2c/twl4030.h
> > +++ b/include/linux/i2c/twl4030.h
> > @@ -333,14 +333,6 @@ struct twl4030_madc_platform_data {
> >  	int		irq_line;
> >  };
> >  
> > -/* Boards have uniqe mappings of {col, row} --> keycode.
> > - * Column and row are 4 bits, but range only from 0..7;
> > - * a PERSISTENT_KEY is "always on" and never reported.
> > - */
> > -#define KEY_PERSISTENT		0x00800000
> > -#define KEY(col, row, keycode)	(((col) << 28) | ((row) << 24) | (keycode))
> > -#define PERSISTENT_KEY(c, r)	KEY(c, r, KEY_PERSISTENT)
> > -
> >  struct twl4030_keypad_data {
> >  	unsigned rows;
> >  	unsigned cols;
> > -- 
> > 1.6.2.2
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
