From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH 1/5] arm: devtree: Set system_rev from DT "/revision"
Date: Tue, 05 Jan 2016 12:45:52 +0100
Message-ID: <3663322.UyrB2OmX6o@wuerfel>
References: <1436214373-12969-1-git-send-email-pali.rohar@gmail.com> <50067860.qzAxcgo8L4@wuerfel> <20160105113750.GL22661@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-spec-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160105113750.GL22661@pali>
Sender: devicetree-spec-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laura Abbott <lauraa-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Sebastian Reichel <sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Devicetree Spec List <devicetree-spec-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Andreas =?ISO-8859-1?Q?F=E4rber?= <afaerber-l3A5Bk7waGM@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tuesday 05 January 2016 12:37:50 Pali Roh=E1r wrote:
> On Monday 28 December 2015 23:27:17 Arnd Bergmann wrote:
> > On Monday 28 December 2015 13:01:22 Frank Rowand wrote:
> > >=20
> > > Patch 2/5 copies the value from ATAG_REVISION into the fdt "/revi=
sion"
> > > property.
> > >=20
> > > If the use of /revision is limited to being a location to hold an=
 ATAG
> > > value to pass to the global variable system_rev, then it would ma=
ke
> > > sense to just copy directly from the ATAG value into system_rev i=
n the
> > > same board file where you are copying the ATAGs.
> >=20
> > Agreed. That would be simpler, and avoid a situation where someone =
relies
> > on the /revision property in DT to be set from the atags compat cod=
e
> > (preventing an upgrade to a newer bootloader), or on the system_rev=
 variable
> > to be the same across multiple boot loaders, in the absence of othe=
r
> > kernel code setting it.
>=20
> So, set system_rev only for Nokia N900? At same place where is called
> save_atags()?
>=20
>=20

Yes.

	Arnd
