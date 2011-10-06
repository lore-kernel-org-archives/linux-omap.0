From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 6/6] OMAP4460: Clock: Adding support for 4460 specific
 clocks
Date: Thu, 6 Oct 2011 11:24:49 -0700
Message-ID: <20111006182448.GJ6324@atomide.com>
References: <1316705361-12175-1-git-send-email-j-keerthy@ti.com>
 <1316705361-12175-7-git-send-email-j-keerthy@ti.com>
 <alpine.DEB.2.00.1109291911390.26728@utopia.booyaka.com>
 <20111004004331.GR6324@atomide.com>
 <alpine.DEB.2.00.1110032145400.4611@utopia.booyaka.com>
 <CAMQu2gyXUER6CQBvp7ccTMSWdWpTuoGoOkAhTgX96Tdeuj0cLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:25812 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754560Ab1JFSYw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Oct 2011 14:24:52 -0400
Content-Disposition: inline
In-Reply-To: <CAMQu2gyXUER6CQBvp7ccTMSWdWpTuoGoOkAhTgX96Tdeuj0cLw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Keerthy <j-keerthy@ti.com>, linux-omap@vger.kernel.org, rnayak@ti.com, b-cousson@ti.com, Vishwanath BS <vishwanath.bs@ti.com>

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [111003 22:50]:
> On Tue, Oct 4, 2011 at 9:21 AM, Paul Walmsley <paul@pwsan.com> wrote:
> > + Rajendra, Santosh, Beno=C3=AEt
> >
> > Hi
> >
> > On Mon, 3 Oct 2011, Tony Lindgren wrote:
> >
> >> * Paul Walmsley <paul@pwsan.com> [110929 17:40]:
> >> > On Thu, 22 Sep 2011, Keerthy wrote:
> >> >
> >> > > From: Vishwanath BS <vishwanath.bs@ti.com>
> >> > >
> >> > > OMAP4460 specific clocks are not getting added as the
> >> > > cpu_is_omap44xx is choosing only OMAP4430 specific clock nodes=
=2E
> >> > > Changing it to add to OMAP4460 specific clocks also.
> >> > > This is clocks are required of temperature sensor.
> >> > >
> >> > > Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> >> > > Signed-off-by: Keerthy <j-keerthy@ti.com>
> >> > > Cc: paul@pwsan.com
> >> >
> >> > Thanks, this patch has been queued for 3.2.
> >>
> >> Should this be a fix for the -rc cycle instead?
> >
> > I don't think it's needed for the -rc series, since we don't have a=
ny
> > in-tree users of the 4460 temperature sensor. =C2=A0The only impact=
 I can see
> > is if the bootloader enables the 4460 temperature sensor clock, and
> > doesn't disable it. =C2=A0I assume that would probably prevent the =
L4 WKUP
> > clockdomain from entering clock stop, which would consume a little =
more
> > power.
> >
> You are correct Paul. It would have also gated the low power states
> but at this point of time on mainline, we aren't supporting CORE/PER
> low power states for OMAP44XX.
>=20
> IIRC, boot-loader isn't enabling the temperature
> sensor clock so this patch can wait for next merge window.

OK thanks, sounds like v3.2 merge window is safe for this then.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
