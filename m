From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v3 1/4] ARM: OMAP4+: PM: Consolidate MPU subsystem PM
 code for re-use
Date: Fri, 5 Apr 2013 17:04:20 +0300
Message-ID: <20130405140420.GB12229@arwen.pp.htv.fi>
References: <1365166743-5940-1-git-send-email-santosh.shilimkar@ti.com>
 <1365166743-5940-2-git-send-email-santosh.shilimkar@ti.com>
 <20130405131935.GM11464@arwen.pp.htv.fi>
 <20130405133511.GA4143@kahuna>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6481825244275904906=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130405133511.GA4143@kahuna>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nishanth Menon <nm@ti.com>
Cc: khilman@deeprootsystems.com, Felipe Balbi <balbi@ti.com>, tony@atomide.com, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============6481825244275904906==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yNb1oOkm5a9FJOVX"
Content-Disposition: inline

--yNb1oOkm5a9FJOVX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 05, 2013 at 08:35:11AM -0500, Nishanth Menon wrote:
> On 16:19-20130405, Felipe Balbi wrote:
> > On Fri, Apr 05, 2013 at 06:29:00PM +0530, Santosh Shilimkar wrote:
> > > OMAP5 and future OMAP based SOCs has backward compatible MPUSS
> > > IP block with OMAP4. It's programming model is mostly similar.
> >=20
> > s/It's/Its/
> > s/mostly //
> >=20
> > (similar already expands to 'almost the same' :-)
> >=20
> > > @@ -355,6 +389,12 @@ int __init omap4_mpuss_init(void)
> > > =20
> > >  	save_l2x0_context();
> > > =20
> > > +	if (cpu_is_omap44xx()) {
> > > +		omap_pm_ops.finish_suspend =3D omap4_finish_suspend;
> > > +		omap_pm_ops.resume =3D omap4_cpu_resume;
> > > +		omap_pm_ops.scu_prepare =3D scu_pwrst_prepare;
> > > +	}
> >=20
> > why don't you just rename omap4_* into omap_* and add cpu-based checks
> > there in order to handle differences between omap4 and omap5?
> >=20
> > If implementation will be almost the same for both, you might be able to
> > save on some more duplication, no ?
> Jeez NO! finish_suspend is assembly, further, it is the hottest path in
> cpuidle framework - for every WFI we invoke it. we definitely dont want
> to add more overhead beyond what is necessary.

alright, settle down ;-) whoever suggested that isn't here anymore

--=20
balbi

--yNb1oOkm5a9FJOVX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRXtnkAAoJEIaOsuA1yqREdUgQAKzFiMYL1VOQkcaMHhVTOghP
c9fniNwJF4m47zdpT7MmQiEj6vdMFzpNIpAVfLqUCS9HZ0XlhZvC2bhVDIX4dkdj
QvfolMKursDyNggFhSf8cJO+ZewJqmdXIzSAGTya72Gn3ukrX6oFiKyAi31SSqUD
Jwv37PwdVvwlLbBx/3gO9DBo8beZEAtYB14X+UNqKoFrWdflwzi0odAyZDljzjmq
PCI5yPSNR0yvCXD+sVXQFzVr9Nmd8qLoxplEUAAKOwN6aMqKfBbs8d3GXUavPUu+
uP0BgtdNQmFPzdTn+E4To5Z/zlvx5f9bLW8YKMG9dupAM+fV8WwJD8C6ihJctcDJ
6d2+FgsZB6FY29Z7BtWvLEkiLUN7/KiK69Ky45+LNKlCszGoKjuqt04rZRphE0jL
fZBlVUaSu45hb822F+9XHUdsbOFLkgXBUceXhdl9iB3ig11Fc8EQS1LVX+6eBKBV
16amtg6KqRaTWTlTLmCFVP3MJd8Ds6Z9TfkYqbpPQtUuaPkpMvLDnTaYSYP0Eb+p
zLVOfKYgWHNw33G1gy3BxnLhVVbI9C1PV7tSFRbQiLjAzG0PNAY+8bT+EpjSOww5
BevzX/03Ha97DUeYnh4OtpDAuYp96YWlmNmGPNnsz1GDKpDgS/4QYp66+SKW5twy
lONwlTe8fLenQ/axfZCQ
=pjVE
-----END PGP SIGNATURE-----

--yNb1oOkm5a9FJOVX--


--===============6481825244275904906==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6481825244275904906==--
