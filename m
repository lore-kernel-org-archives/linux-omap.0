From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH] omap3: pandora: add DSS2 support and related regulators
Date: Fri, 15 Jan 2010 11:53:42 +0200
Message-ID: <1263549222.2087.232.camel@tubuntu.research.nokia.com>
References: <1260559940-25103-1-git-send-email-notasas@gmail.com>
	 <1263394976.2087.106.camel@tubuntu.research.nokia.com>
	 <6ed0b2681001131301v3e295a51g1d3177c51377356f@mail.gmail.com>
	 <1263477920.2087.186.camel@tubuntu.research.nokia.com>
	 <6ed0b2681001141237m2691037dsc7e84f8a70292a95@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:17770 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755992Ab0AOJvn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Jan 2010 04:51:43 -0500
In-Reply-To: <6ed0b2681001141237m2691037dsc7e84f8a70292a95@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Grazvydas Ignotas <notasas@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, 2010-01-14 at 21:37 +0100, ext Grazvydas Ignotas wrote:
> On Thu, Jan 14, 2010 at 4:05 PM, Tomi Valkeinen
> <tomi.valkeinen@nokia.com> wrote:
> > On Wed, 2010-01-13 at 22:01 +0100, ext Grazvydas Ignotas wrote:
> >> On Wed, Jan 13, 2010 at 5:02 PM, Tomi Valkeinen
> >> <tomi.valkeinen@nokia.com> wrote:
> >> > Hi,
> >> >
> >> > This doesn't apply, can you resend based on Linus' tree or my DS=
S2 tree?
> >>
> >> ok, will resend shortly.
> >>
> >> BTW, what about enabling vdds_dsi/vdds_sdi regulators we talked ab=
out
> >> earlier? This patch already sets up those regulators in the board =
file
> >> for DSS2 to get and enable them. I can come up with a patch for th=
at
> >> if you want (perhaps doing it somewhere in dss_init()).
> >
> > It would be nice to get this clarified from TI's HW side, but I hav=
en't
> > had time to do that.
> >
> > However, it sure looks like your theory is correct, so a patch woul=
d be
> > ok.
> >
> > I don't think dss_init is a proper place for it. The power only nee=
ds to
> > be enabled when the display is on, so perhaps
> > dpi_display_enable/disable() would be better place to turn it on an=
d off
> > (and suspend/resume). Below is a quick patch I made to test this.
> >
> > But is the same code needed by RFBI and SDI also? And is it needed =
only
> > when certain pins are in use? And only on OMAP3. I'm not sure what =
would
> > be the most elegant way for this, but perhaps for now it's good eno=
ugh
> > if we enable the power in dpi.c's enable/disable.
>=20
> I can only test this on pandora (24bit parallel display), and your
> patch works fine there.

Ok, good to know. I'm not very happy with the patch yet, but something
like it is needed.

> Gra=C5=BEvydas
>=20
> PS: I see some author names got mangled in your GIT (got prefixed wit=
h 'ext').

Argh. It's the notorious Nokia mailserver. Thanks for pointing it out.

 Tomi


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
