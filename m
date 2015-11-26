From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 5/5] arm: boot: store ATAGs structure into DT
 "/chosen/linux,atags" entry
Date: Thu, 26 Nov 2015 12:39:30 -0800
Message-ID: <20151126203930.GW2517@atomide.com>
References: <20150713131902.GH26485@atomide.com>
 <20151123144545.GD24147@pali>
 <20151125181644.GI2517@atomide.com>
 <17134653.86P3dFyQKK@wuerfel>
 <20151125210310.GT2517@atomide.com>
 <56568849.5080103@gmail.com>
 <20151126090739.GD14190@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151126090739.GD14190@pali>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Laura Abbott <lauraa-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber-l3A5Bk7waGM@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Pali Roh=C3=A1r <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [151126 01:08]:
> On Wednesday 25 November 2015 20:19:21 Frank Rowand wrote:
> > > Or populate /proc/atags only for the ones that need it from machi=
ne
> > > specific init_early?
> >=20
> > This is circling back to the first comment from Russell King where
> > he suggested a legacy file for the N900 which calls save_atags():
> >=20
> >     Are the ATAGs at a fixed address on the N900?  Can that be hand=
led in
> >     some kind of legacy file for the N900 which calls save_atags() =
on it, so
> >     we don't end up introducing yet more stuff that we have to main=
tain into
> >     the distant future?  If not, what about copying a known working=
 atag
> >     structure into a legacy file for the N900?
> >=20
> > It seems to me that patches 1, 2, 4, and 5 could be replaced by thi=
s
> > approach.
>=20
> Hi Frank, in this case I will ask my question again: It is possible t=
o
> read atags from that legacy file. And if yes how? I was not thinking
> about this approach because somebody in past wrote that this is not
> possible...

Just to explore options.. How about make a minimal device driver that
just loads the atags blob from /lib/firmware and then shows it in
/proc/atags? Of course some checking on the atags should be done by
the driver..

That would work as long as the kernel no longer needs it.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
