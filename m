From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 3.1-rc3] gpio/omap: fix build error with certain OMAP1
 configs
Date: Thu, 13 Oct 2011 11:42:55 -0600
Message-ID: <20111013174255.GH18574@ponder.secretlab.ca>
References: <201108231342.25101.jkrzyszt@tis.icnet.pl>
 <87sjoshx2k.fsf@ti.com>
 <201110071430.14420.jkrzyszt@tis.icnet.pl>
 <alpine.DEB.2.00.1110102356530.7624@dell>
 <87fwiz8okk.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87fwiz8okk.fsf@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, tony@atomide.com, Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 11, 2011 at 09:45:15AM -0700, Kevin Hilman wrote:
> Aaro Koskinen <aaro.koskinen@iki.fi> writes:
>=20
> > Hi,
> >
> > On Fri, 7 Oct 2011, Janusz Krzysztofik wrote:
> >> Dnia wtorek, 23 sierpnia 2011 o 19:11:47 Kevin Hilman napisa=C5=82=
(a):
> >>> Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> writes:
> >>>> With commit f64ad1a0e21a, "gpio/omap: cleanup _set_gpio_wakeup()=
, remove
> >>>> ifdefs", access to build time conditionally omitted 'suspend_wak=
eup'
> >>>> member of the 'gpio_bank' structure has been placed unconditiona=
lly in
> >>>> function _set_gpio_wakeup(), which is always built. This resulte=
d in the
> >>>> driver compilation broken for certain OMAP1, i.e., non-OMAP16xx,
> >>>> configurations.
> >>>>
> >>>> Really required or not in previously excluded cases, define this
> >>>> structure member unconditionally as a fix.
> >>>>
> >>>> Tested with a custom OMAP1510 only configuration.
> >>>>
> >>>> Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> >>>
> >>> Verified that this fixes a build problem when building for OMAP1
> >>> (730/850 only)
> >>>
> >>> Acked-by: Kevin Hilman <khilman@ti.com>
> >
> > Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> >
> >>> Grant, can you queue this as a fix for 3.1-rc?
> >>
> >> Sorry for being so late with checking this, but it looks like this=
 patch
> >> never got into 3.1-rc, as it should, leaving the issue not fixed.
> >> Any chance for it still being pushed into 3.1?
> >
> > This patch is one-liner, and still needed to get 3.1-rc9 compiled a=
nd
> > running on e.g. Amstrad E3, so I think it should get into 3.1.
>=20
> Grant?

I'll pick this up now and send it on to Linus

g.

>=20
