From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap3: mux: add shorthands for OUTPUT_PULL{UP,DOWN}
Date: Mon, 30 Nov 2009 15:10:56 -0800
Message-ID: <20091130231056.GB4348@atomide.com>
References: <cover.1259481545.git.mike@compulab.co.il>
 <1b6ff0b31e4c22532659749282e0dcf4dccdf5e4.1259481545.git.mike@compulab.co.il>
 <20091130211255.GZ4348@atomide.com>
 <f870da180911301358t239b1820ia7cdecf932d579d1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61864 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753027AbZK3XKx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Nov 2009 18:10:53 -0500
Content-Disposition: inline
In-Reply-To: <f870da180911301358t239b1820ia7cdecf932d579d1@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Rapoport <mike.rapoport@gmail.com>
Cc: Mike Rapoport <mike@compulab.co.il>, linux-omap@vger.kernel.org

* Mike Rapoport <mike.rapoport@gmail.com> [091130 13:57]:
> On Mon, Nov 30, 2009 at 11:12 PM, Tony Lindgren <tony@atomide.com> wr=
ote:
> > * Mike Rapoport <mike@compulab.co.il> [091129 00:10]:
> >> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
> >> ---
> >> =A0arch/arm/mach-omap2/mux.h | =A0 =A02 ++
> >> =A01 files changed, 2 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/arch/arm/mach-omap2/mux.h b/arch/arm/mach-omap2/mux.h
> >> index e09c5d2..02a1b53 100644
> >> --- a/arch/arm/mach-omap2/mux.h
> >> +++ b/arch/arm/mach-omap2/mux.h
> >> @@ -37,6 +37,8 @@
> >>
> >> =A0/* Active pin states */
> >> =A0#define OMAP_PIN_OUTPUT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A00
> >> +#define OMAP_PIN_OUTPUT_PULLUP =A0 =A0 =A0 =A0 =A0 =A0 =A0 (OMAP_=
PULL_ENA | OMAP_PULL_UP)
> >> +#define OMAP_PIN_OUTPUT_PULLDOWN =A0 =A0 OMAP_PULL_ENA
> >> =A0#define OMAP_PIN_INPUT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 OMAP_INPUT_EN
> >> =A0#define OMAP_PIN_INPUT_PULLUP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(O=
MAP_PULL_ENA | OMAP_INPUT_EN \
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 | OMAP_PULL_UP)
> >
> > Hmm, isn't this same as configuring as GPIO with up or
> > down value?
> >
> > Or is there's some need doing it with mux only? Like
> > power savings?
>=20
> This is intended for dedicated pins rather than GPIO. Actually, I've
> met only one till now, the HSUSB0_STP.

Hmm, are you sure you need the OMAP_PIN_OUTPUT_PULLUP for HSUSB0_STP?

AFAIK, it's not needed for other boards. I believe the STP should be
down until the MUSB signals STP and pulls it up briefly. Might be
worth checking.

> If you define most of the mux configuration in the kernel you
> eventually run into very long lines in the omap_board_mux array. So,
> shortening at least some of them seems good idea to me.

Yeah nothing wrong with that, I'm just thinking back to when we added
these mux defines originally. It seemed like the the combination of
out and pull should be needed, and pull would only be needed for inputs=
=2E

> Take a look at my second patch ([1]) for example of what I mean :)
>=20
> [1] http://en.wikipedia.org/wiki/Wikipedia:Tools/Editing_tools

I guess this is a wrong link here to the editing tool. Our mux
code is bloated, but should not be _that_ bloated! :)

Eh, let's hope we don't need to implement kernel based wiki and
editing tools for the muxing :)

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
