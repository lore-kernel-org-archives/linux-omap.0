From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] ALSA: SoC: Add support for TI SDP3430
Date: Thu, 20 Nov 2008 23:23:01 -0800
Message-ID: <200811202323.01493.david-b@pacbell.net>
References: <1227241853-25944-1-git-send-email-mesak82@gmail.com> <200811202129.19255.david-b@pacbell.net> <2C7D3DF36ADFFC479B44490D912B616705A445CBB1@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp117.sbc.mail.sp1.yahoo.com ([69.147.64.90]:47574 "HELO
	smtp117.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752203AbYKUHXF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 21 Nov 2008 02:23:05 -0500
In-Reply-To: <2C7D3DF36ADFFC479B44490D912B616705A445CBB1@dlee07.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Lopez Cruz, Misael" <x0052729@ti.com>
Cc: "mesak82@gmail.com" <mesak82@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Pandita, Vikram" <vikram.pandita@ti.com>

On Thursday 20 November 2008, Lopez Cruz, Misael wrote:
> > On Thursday 20 November 2008, mesak82@gmail.com wrote:
> > > +=A0=A0=A0=A0=A0=A0=A0tristate "SoC Audio support for Texas Instr=
uments SDP3430"
> > > +=A0=A0=A0=A0=A0=A0=A0depends on SND_OMAP_SOC && MACH_OMAP_3430SD=
P
> > > +=A0=A0=A0=A0=A0=A0=A0select SND_OMAP_SOC_MCBSP
> > > +=A0=A0=A0=A0=A0=A0=A0select SND_SOC_TWL4030
> >=20
> > depends also on TWL4030_CORE, yes?
> The machine driver itself doesn't depend on TWL4030_CORE, but
> TWL4030 SoC codec driver does (sound/soc/codecs/Kconfig)=20
>=20
> config SND_SOC_TWL4030
>         tristate
>         depends on TWL4030_CORE
>=20
> Although that dependency is overridden by _select_ statement.

No it isn't.  Reverse dependencies don't work like you might
expect ... even when there's no ambiguity in walking up a
chain of them, *no* additional dependencies are flagged.

So as you've written it, SND_SOC_TWL4030 will be active,
but not TWL4030_CORE on which it depends.


If you fix that in Kconfig, you'd make a lot of folk
fairly happy ... but there'd be fun ambiguities to cope
with.  Example:

	config X
		select D
	config D
		depends on (A && B) || C

It's not clear whether to enable both A and B; just C;
or all of them...

Probably asking the user to resolve such issues would be
necessary.  Coming up with all the solutions would be a bit
more complex than a Prolog interpreter, since Kconfig uses
tristate logic not boolean.


> What should be the best way to handle this dependency? Directly
> in kconfig entry for each TWL4030-related machine driver?=20

The least error-prone answer involves no "select" statements
at all, ever.  That is, least error-prone in terms of the
output of Kconfig being a valid configuration ... in terms
of minimizing user error, I suggest just adding the single
dependency I mentioned.

- Dave

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
