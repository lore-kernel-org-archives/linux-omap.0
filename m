From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omapfb: Wrong test on unsigned?
Date: Thu, 22 Oct 2009 11:22:37 -0700
Message-ID: <20091022182236.GQ16230@atomide.com>
References: <4AD8BA2F.9090307@gmail.com> <A24693684029E5489D1D202277BE89444CEFEAF5@dlee02.ent.ti.com> <4ADF2C30.3030401@gmail.com> <A24693684029E5489D1D202277BE89444D06EB0E@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:63019 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755906AbZJVSWn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Oct 2009 14:22:43 -0400
Content-Disposition: inline
In-Reply-To: <A24693684029E5489D1D202277BE89444D06EB0E@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Cc: Roel Kluin <roel.kluin@gmail.com>, Imre Deak <imre.deak@nokia.com>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

* Aguirre Rodriguez, Sergio Alberto <saaguirre@ti.com> [091021 08:41]:
>  
> 
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org 
> > [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Roel Kluin
> > Sent: Wednesday, October 21, 2009 10:44 AM
> > To: Aguirre Rodriguez, Sergio Alberto
> > Cc: Imre Deak; linux-fbdev-devel@lists.sourceforge.net; 
> > linux-omap@vger.kernel.org; Andrew Morton
> > Subject: Re: [PATCH] omapfb: Wrong test on unsigned?
> > 
> > regno is unsigned so the test didn't work. If regno
> > can't be used return an error.
> > 
> > Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> > ---
> > >> Is this correct? please review.
> > >>
> > >> diff --git a/drivers/video/omap/omapfb_main.c 
> > >> b/drivers/video/omap/omapfb_main.c
> > >> index 0d0c8c8..cc7dd93 100644
> > >> --- a/drivers/video/omap/omapfb_main.c
> > >> +++ b/drivers/video/omap/omapfb_main.c
> > >> @@ -286,7 +286,7 @@ static int _setcolreg(struct fb_info 
> > >> *info, u_int regno, u_int red, u_int green,
> > >>  		if (r != 0)
> > >>  			break;
> > >>  
> > >> -		if (regno < 0) {
> > >> +		if ((int)regno < 0) {
> > > 
> > > Hmm...
> > > 
> > > Isn't regno unsigned integer from the start?
> > 
> > yes
> > 
> > > 2 things here:
> > > 
> > > - regno will never be negative.
> > > - Casting won't make a difference in the meaning., it'll 
> > make a negative only when:
> > > 
> > > 	regno > ((2^32) / 2)
> > > 
> > > Which doesn't make any sense IMHO.
> > 
> > I think it is strange that _setcolreg() accepts a regno that 
> > is invalid,
> > ignores it and just returns as if all was OK. If you agree 
> > then you may
> > like the patch below.
> 
> Yep. Looks nicer to me ;)
> 
> Acked-by: Sergio Aguirre <saaguirre@ti.com>

Looks good to me too.

Acked-by: Tony Lindgren <tony@atomide.com>

> 
> Regards,
> Sergio
> > 
> > > Regards,
> > > Sergio
> > 
> > Thanks,
> > 
> > Roel
> > 
> > diff --git a/drivers/video/omap/omapfb_main.c 
> > b/drivers/video/omap/omapfb_main.c
> > index 0d0c8c8..4da94d0 100644
> > --- a/drivers/video/omap/omapfb_main.c
> > +++ b/drivers/video/omap/omapfb_main.c
> > @@ -285,12 +285,6 @@ static int _setcolreg(struct fb_info 
> > *info, u_int regno, u_int red, u_int green,
> >  	case OMAPFB_COLOR_RGB444:
> >  		if (r != 0)
> >  			break;
> > -
> > -		if (regno < 0) {
> > -			r = -EINVAL;
> > -			break;
> > -		}
> > -
> >  		if (regno < 16) {
> >  			u16 pal;
> >  			pal = ((red >> (16 - var->red.length)) <<
> > @@ -299,6 +293,8 @@ static int _setcolreg(struct fb_info 
> > *info, u_int regno, u_int red, u_int green,
> >  					var->green.offset) |
> >  			      (blue >> (16 - var->blue.length));
> >  			((u32 *)(info->pseudo_palette))[regno] = pal;
> > +		} else {
> > +			r = -EINVAL;
> >  		}
> >  		break;
> >  	default:
> > --
> > To unsubscribe from this list: send the line "unsubscribe 
> > linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> > --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
