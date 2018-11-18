From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2] MAINTAINERS: update OMAP MMC entry
Date: Sun, 18 Nov 2018 21:23:23 +0100
Message-ID: <CAMuHMdUxTycDXo=i22JLxwv5oMXLQBB5iG2eszH1ewvJ1UVXrQ@mail.gmail.com>
References: <20181106222750.12939-1-aaro.koskinen@iki.fi> <CAMuHMdVCWLmyS+rFEQBHFGTpkw2=xk+Ub9VCnaobA+L9vGLOHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdVCWLmyS+rFEQBHFGTpkw2=xk+Ub9VCnaobA+L9vGLOHw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Andrew Morton <akpm@linux-foundation.org>, ext Tony Lindgren <tony@atomide.com>, "open list:TI ETHERNET SWITCH DRIVER (CPSW)" <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Sun, Nov 18, 2018 at 9:21 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> CC Jarkko (from his last patch)

Dropped. Apparently that address bounces, too.

> On Tue, Nov 6, 2018 at 11:29 PM Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> > Jarkko's e-mail address hasn't worked for a long time. We still want
> > to keep this driver working as it is critical for some of the OMAP boards.
> > I use and test this driver frequently, so change myself as a maintainer
> > with "Odd Fixes" status.
> >
> > Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> > Acked-by: Tony Lindgren <tony@atomide.com>
> > ---
> >  CREDITS     | 4 ++++
> >  MAINTAINERS | 4 ++--
> >  2 files changed, 6 insertions(+), 2 deletions(-)
> >
> >         v2: Add Jarkko to CREDITS.
> >
> >         v1: https://patchwork.kernel.org/patch/10369861/
> >
> > diff --git a/CREDITS b/CREDITS
> > index 5befd2d714d0..84cbec4c6211 100644
> > --- a/CREDITS
> > +++ b/CREDITS
> > @@ -2138,6 +2138,10 @@ E: paul@laufernet.com
> >  D: Soundblaster driver fixes, ISAPnP quirk
> >  S: California, USA
> >
> > +N: Jarkko Lavinen
> > +E: jarkko.lavinen@nokia.com
>
> If this address hasn't worked for a long time, what's the point of adding
> it to CREDITS?

That point is still valid, as the address does bounce ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
