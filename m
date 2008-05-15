From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] ARCH: OMAP: MUSB: Do not block sleep
Date: Thu, 15 May 2008 10:58:50 +0300
Message-ID: <20080515075849.GB4625@kedavra.cpe.vivax.com.br>
References: <1210805485-2645-1-git-send-email-felipe.balbi@nokia.com> <20080514231248.GI8928@atomide.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:43419 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757522AbYEOH6B (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 May 2008 03:58:01 -0400
Content-Disposition: inline
In-Reply-To: <20080514231248.GI8928@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, Jouni H?gander <jouni.hogander@nokia.com>

On Wed, May 14, 2008 at 04:12:49PM -0700, Tony Lindgren wrote:
> * Felipe Balbi <felipe.balbi@nokia.com> [080514 16:06]:
> > Do not block sleep while musb clock is enabled
> > as it completely blocks dynamic sleep.
>=20
> Hmm, as far as I remember this will break all USB connections at leas=
t
> on tusb if osc_ck is taken out. Can you check that?

This doesn't touch tusb. I didn't move tusb to this generic init code s=
o
far.

But good point. I'll move it and check.

In any case, I could block_sleep only if TUSB is been used ;-)

>=20
> Tony
>=20
> >=20
> > Thanks to Jouni H=F6gander.
> >=20
> > Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> > Signed-off-by: Jouni H=F6gander <jouni.hogander@nokia.com>
> > ---
> >  arch/arm/mach-omap2/usb-musb.c |    2 --
> >  1 files changed, 0 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/u=
sb-musb.c
> > index cbd59f8..bd3556b 100644
> > --- a/arch/arm/mach-omap2/usb-musb.c
> > +++ b/arch/arm/mach-omap2/usb-musb.c
> > @@ -58,7 +58,6 @@ static int musb_set_clock(struct clk *clk, int st=
ate)
> >  		if (clk_on > 0)
> >  			return -ENODEV;
> > =20
> > -		omap2_block_sleep();
> >  		clk_enable(clk);
> >  		clk_on =3D 1;
> >  	} else {
> > @@ -67,7 +66,6 @@ static int musb_set_clock(struct clk *clk, int st=
ate)
> > =20
> >  		clk_disable(clk);
> >  		clk_on =3D 0;
> > -		omap2_allow_sleep();
> >  	}
> > =20
> >  	return 0;
> > --=20
> > 1.5.4.3.447.gc95b3
> >=20
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-oma=
p" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Best Regards,

=46elipe Balbi
me@felipebalbi.com
http://blog.felipebalbi.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
