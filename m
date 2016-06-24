From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 02/23] ARM: dts: n950: add display support
Date: Fri, 24 Jun 2016 02:30:01 +0200
Message-ID: <20160624003000.GA5519@earth>
References: <21766689.NesyW3QHk4@avalon>
 <20160317174901.GB3864@earth>
 <87lh59pdt6.fsf@intel.com>
 <20160323140105.GA31703@earth>
 <87h9fwdwh6.fsf@intel.com>
 <20160324142652.GA25083@earth>
 <87io0b52ss.fsf@intel.com>
 <20160325001509.GA12097@earth>
 <20160412205148.GY5995@atomide.com>
 <20160621110102.GL22406@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160621110102.GL22406@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Tony,

On Tue, Jun 21, 2016 at 04:01:03AM -0700, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [160412 13:53]:
> > * Sebastian Reichel <sre@kernel.org> [160324 17:16]:
> > > On Thu, Mar 24, 2016 at 05:11:15PM +0200, Jani Nikula wrote:
> > > > > I _think_, that your HW team decided to cover the first and the
> > > > > last few pixels of the 864 display with plastic. So technically
> > > > > it's a 864 display, but effectively it's 854.
> >=20
> > Sebastian, should I apply this dts patch as is or are changes
> > still needed?
>=20
> Well please repost when ready, I'll untag this old thread here..

Sounds fine to me. DTS changes should be merged once the driver
changes are accepted and they need at least one more cycle.

-- Sebastian

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXbH8CAAoJENju1/PIO/qa2yoQAIr1vVdjwBoEeKEE43+bLkSj
lcOmAhI1+EfX6RgbHDft9l4zEj+D50ISjgrXLEr1IalAk5uAHproBcG3IrvmAOuS
dpgBay5PJZ6vGhWQQyyxRn4PljxY/pnhG/zC/OnHwtGgNl6NrpZ4jF2po7Z3bMAh
1w84HCZ9EmXNtTcino6Tr4gvAuVdOWjH4RJYspHqQ5XFIo9bquGeHZr/DJZGr/qg
GIzV2tTCQJMZNXKZIU09XF1jttSI94bEneL1jF8sJx9M9ZcbyFC3kRrg0Q3Nljf/
1yafE5whqgWiWRKw2uTxjQrsLzMA1hVv57RD5+OcQC2uvast25vOeR8h6KCkJJQV
aur1rHsJzTywv/fE50dEprCZJs1rvTSflU7Zd0ZBu4oG0F0am93N9+Amoh9pqO4W
vDQoK2VXiWD4YHzwsE6Mrzp8UyuHoiFbg9XDpA/dH45JxWUNxg6H/fWhWSjO3Oyh
kqELJPG+XE2VaSmmO5lrEEW2trKlIXzzruXxvqyc9lj/NZR9n6Y2fl9on9PE8fyb
0Vld+7RtftOMyllw5nfQKHyYtKtn97/l5AotX0LcpgS2gdCAAcYJMElAs8s8r69T
1f5hOK/Lh/6BAi2OgLU3DMSkL0NmG2jjSeCqipAZyRs+sQc27pDz1q9jIh2OoVTO
P2belL2+j1jUKr7lv4NK
=p0Fy
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
