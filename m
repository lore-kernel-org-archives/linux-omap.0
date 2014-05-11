From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/4] OMAPDSS: Fix DSS clock multiplier issue on 3703 and
 probably 3630
Date: Sun, 11 May 2014 07:42:10 -0700
Message-ID: <20140511144209.GA28266@atomide.com>
References: <1398815562-24113-1-git-send-email-tony@atomide.com>
 <1398815562-24113-2-git-send-email-tony@atomide.com>
 <536C860E.1000501@ti.com>
 <CALbNGRR3U1veFgXmOWpfG3yNVESdxi2t79WDrJwOZ1oShuG1yA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:43849 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751087AbaEKOmQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 11 May 2014 10:42:16 -0400
Content-Disposition: inline
In-Reply-To: <CALbNGRR3U1veFgXmOWpfG3yNVESdxi2t79WDrJwOZ1oShuG1yA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andreas =?utf-8?Q?M=C3=BCller?= <schnitzeltony@googlemail.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org

* Andreas M=C3=BCller <schnitzeltony@googlemail.com> [140509 14:07]:
> On Fri, May 9, 2014 at 9:38 AM, Tomi Valkeinen <tomi.valkeinen@ti.com=
> wrote:
> > On 30/04/14 02:52, Tony Lindgren wrote:
> >> Otherwise we can get often errors like the following and the
> >> display won't come on:
> >>
> >> omapdss APPLY error: FIFO UNDERFLOW on gfx, disabling the overlay
> >> omapdss APPLY error: SYNC_LOST on channel lcd, restarting
> >> the output with video overlays disabled
> >>
> >> There are some earlier references to this issue:
> >>
> >> http://www.spinics.net/lists/linux-omap/msg59511.html
> >> http://www.spinics.net/lists/linux-omap/msg59724.html
> >
> resend - my client had HTML enabled...
>=20
> FWIW: I have had issues long time ago [1]. With mainline 3.14.3 I had
> still the reboot problem on old 600MHz OMAP 3530. Applying this patch
> solved the issues. For other versions I had no chance to reproduce th=
e
> original wakup issue mentioned in old thread

Sorry I'm a bit confused now. Is the reboot issue a separate issue
related to the twl4030 generic scripts for 3530?

And then this patch fixes dm3730 wake-up (from suspend?) issues?

Or do we have some other bug where we wrongly hit omap3630_dss_feats
on 3530 somehow?

Regards,

Tony
=20
> [1] http://marc.info/?l=3Dlinux-omap&m=3D136250904607413&w=3D2
>=20
> Andreas
> > Those don't sound like the same issue, but it's hard to say. What k=
ind
> > of clock rates do you get? Cat you paste debugfs/omapdss/clk, with =
and
> > without this patch?
> >
> > What resolution do you have? If it's a very high resolution (say, D=
VI
> > output to a monitor), it could just be an issue of
> > not-enough-memory-bandwidth.
> >
> >> It seems that it's safe to set the lower values even for 3630.
> >> If we can confirm that 3630 works with the higher values
> >> reliably we can add further detection.
> >>
> >> Signed-off-by: Tony Lindgren <tony@atomide.com>
> >> ---
> >>  drivers/video/fbdev/omap2/dss/dss.c | 5 +++--
> >>  1 file changed, 3 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/video/fbdev/omap2/dss/dss.c b/drivers/video/f=
bdev/omap2/dss/dss.c
> >> index d55266c..ad6561f 100644
> >> --- a/drivers/video/fbdev/omap2/dss/dss.c
> >> +++ b/drivers/video/fbdev/omap2/dss/dss.c
> >> @@ -707,9 +707,10 @@ static const struct dss_features omap34xx_dss=
_feats __initconst =3D {
> >>       .dpi_select_source      =3D       &dss_dpi_select_source_oma=
p2_omap3,
> >>  };
> >>
> >> +/* Supposedly 3630 can use div 32 mult 2, but that needs to be re=
checked */
> >>  static const struct dss_features omap3630_dss_feats __initconst =3D=
 {
> >> -     .fck_div_max            =3D       32,
> >> -     .dss_fck_multiplier     =3D       1,
> >> +     .fck_div_max            =3D       16,
> >> +     .dss_fck_multiplier     =3D       2,
> >
> > These values tell about the clock hardware, they are not settings t=
hat
> > can be changed to change the clock. OMAP3630 has a fixed x2 multipl=
ier
> > and a divider with maximum value of 16.
> >
> >  Tomi
> >
> >
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
