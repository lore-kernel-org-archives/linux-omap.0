From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] ARM: OMAP-USB: Fix possible memory leak
Date: Fri, 3 May 2013 11:30:09 +0300
Message-ID: <20130503083009.GA19377@arwen.pp.htv.fi>
References: <1367510596-27780-1-git-send-email-shc_work@mail.ru>
 <20130502162433.GA10016@kahuna> <1367512124.978518915@f372.mail.ru>
 <20130502164058.GC8577@arwen.pp.htv.fi>
 <20130502231353.GF21614@n2100.arm.linux.org.uk>
 <20130503061931.GB27451@arwen.pp.htv.fi>
 <20130503081510.GG21614@n2100.arm.linux.org.uk>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1656518804020958384=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130503081510.GG21614@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Nishanth Menon <nm@ti.com>, Alexander Shiyan <shc_work@mail.ru>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, linux-usb@vger.kernel.org, Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============1656518804020958384==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline

--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 03, 2013 at 09:15:10AM +0100, Russell King - ARM Linux wrote:
> > > This is exactly why we have platform_device_alloc(),
> > > platform_device_register_full() and friends - so that people don't ha=
ve to
> > > fsck around with kzalloc themselves and get it wrong like the above d=
oes.
> > >=20
> > > Would you like me to pass your details to gregkh for another one of h=
is
> > > public humilation exercises over basic kernel programming stuff? :)
> >=20
> > How about we pass yours for not reading the patch before flaming ? Note
> > that $SUBJECT is *not* touching at all that line which kzallocs a
> > platform_device. Wrong as it is, it's not part of $SUBJECT.
>=20
> It's really simple.  You do not use k*alloc with platform devices.  And

agree, no discussions here

> you reject any patch which contains that, and point it out to the patch
> author.
>=20
> It really doesn't matter if there's a kfree or not.  The fact is you do
> not allow it in any situation, because such bad practises get copied
> and then you end up with kfree's.
>=20
> How about you gain an understanding of this stuff and why this stuff is
> soo "hot".

how about you look at the git log to figure out I had nothing to do with
that original patch which added k*alloc to the pdev ?

--=20
balbi

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRg3WRAAoJEIaOsuA1yqREYKYP/RgIPwmgnjheCQZrKiQ1oubl
0s8OpSVja7Sb8MNzvWp4jmlBobxgo0rL68QD/eJzghki/M3/hX4nRkEAWBxk12HM
aWhtyyu6XIyB7ix/RtXaJA9tBPwTG6Ko0ky/A3IHg3/wFqWu3sc/RJg759bdbaEL
YiNPamING+7xdTqyFY7QJgb6DOTWS//JUlKSzxGrDhczg9V5SPhzWHd5QElCjecM
Xl/CbPLt7Y9Vsem7BPP+8Vr5NJYHnLxsHozjWnTfa7KxPAe4D37e1060W+A4rnRj
fiVJS9x0s2hDbeBzode6gFtIdu9dawsRgBF8onNmBxM/8tseeWBTAYneudfkPUpo
aPJdkfePS+AwTKvIIUO8bdIqmEddYHV/6oSy0L0BCjv7+I2MLsoedtRgUbXgiTh6
pGXORxUvyjiniTe2rdJKgSwZppSZ7RUJjTTv41Zw1xrLREmmgupiOACDuqGtYmot
AqVAITWqM1H+c4AYsPsZJKkcT5iRvDwOj9nFYQ3N1JVqs/TManiFC4SeWjPsUwe5
w7lG302nCLpvIKJY/JQ4DlR3h68HMP40trl2lS+W8g17hXYyoVVtSB7FzRxChdHm
C5ps6xJJHFHeue+KZZyQGL2itRENhGK8wcjVWV7Gg6VRwJSYFpbMjbaEsQDch1Y0
s5MuGzM7/0TNtTZBSKjJ
=MGEq
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--


--===============1656518804020958384==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1656518804020958384==--
