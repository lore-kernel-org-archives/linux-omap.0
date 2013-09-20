From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC PATCH] ARM: OMAP3630: Add generic machine descriptor
Date: Fri, 20 Sep 2013 11:23:30 -0500
Message-ID: <20130920162329.GC18721@radagast>
References: <1379693332-10585-1-git-send-email-nm@ti.com>
 <CAOesGMj6G7LeYUJsGpZHxKOjiNrk+1U55QFqcQyTb6_Co+n4zQ@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8801150262962677440=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAOesGMj6G7LeYUJsGpZHxKOjiNrk+1U55QFqcQyTb6_Co+n4zQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Olof Johansson <olof@lixom.net>
Cc: Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

--===============8801150262962677440==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GZVR6ND4mMseVXL/"
Content-Disposition: inline

--GZVR6ND4mMseVXL/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Sep 20, 2013 at 09:19:02AM -0700, Olof Johansson wrote:
> On Fri, Sep 20, 2013 at 9:08 AM, Nishanth Menon <nm@ti.com> wrote:
> > An alternative approach may be to (for all SoCs):
> > 1. define every SoC entry - ti,omap3430 ti,omap3630...
> > 2. have a generic omap3_init which uses "if (of_machine_is_compatible("=
ti,omap3630"))"
> > to invoke the appropriate omap3xxx_init_early.
>=20
> Yes, this would be better, but you can do add a DT_MACHINE as in this
> patch but have ti,omap3630 as the dt_compat table. Then there's no
> need to add runtime checks.

I was going to reply that adding of_machine_is_compatible("ti,omap3630")
would help in some situations, but guess it's already tainted ;-)

cheers

--=20
balbi

--GZVR6ND4mMseVXL/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSPHaBAAoJEIaOsuA1yqRESMsQAIumLCjQoU5R0ppxxctnoTY+
Mo5ufBbLe0jpen+N97unfJyjearXgALHW39uSvsHnH/gdpwBprFQWkK6+PgATJpx
nOXFZ/5EXcuGYHYe3mjYIEinin53kgFmDYoiPQK88ljx6lriTsSr1bg+lbuXqzop
TKx5jHqk7A+tikLw40ZV0PKPfxd86onztawWBD+8PE3twyophPFy/glPMTlBuuri
PyvEmazgykXdmbb4ry9p4ixQqlA1f5XfbjufJpJiV4qX/T0FzNdgC4QGS5Lujhzo
+kU/nwy51XAuW6hj0MCps6rwxhpcWEhT7y+IkULEZRzPk+nTs1L5J6mtDgJ9kS8F
U7+76rSp0g7gYSZ4vJuNh0ocTGJTMqOPTJL7nuRNF6LbS/g7yYMfXIQltqG16tb1
hJ93GJWLo94N8bkshEbdUGikvq1fe0XCDxQAYTYcXxz0xqjJsnOSGkPtimztleYE
3h04jPUhS0fjxYl4oXidPM/cKTzjXnbUfheA2FFFqrH9lF/gFl/FBj9wLnLLQ6V4
7xFQl8FauHxkKLnAPxLi/9gefP3IjXmYCvODLdhM4BJqG73Y/xxlJuwC/seTK3Ht
w2huBScLGttVDXPLfYGeyCyHeDE302j1d/9O1ImFW+5IOInBsVFP12BLT9tbOvfx
5gFI5X3NGgGW/atconIY
=FvN5
-----END PGP SIGNATURE-----

--GZVR6ND4mMseVXL/--


--===============8801150262962677440==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8801150262962677440==--
