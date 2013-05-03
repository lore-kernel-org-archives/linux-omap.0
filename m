From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] ARM: OMAP-USB: Fix possible memory leak
Date: Fri, 3 May 2013 09:25:06 +0300
Message-ID: <20130503062506.GC27451@arwen.pp.htv.fi>
References: <1367510596-27780-1-git-send-email-shc_work@mail.ru>
 <20130502162433.GA10016@kahuna> <1367512124.978518915@f372.mail.ru>
 <20130502164058.GC8577@arwen.pp.htv.fi>
 <20130502231353.GF21614@n2100.arm.linux.org.uk>
 <20130503061931.GB27451@arwen.pp.htv.fi>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7492777372171541080=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130503061931.GB27451@arwen.pp.htv.fi>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Felipe Balbi <balbi@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Alexander Shiyan <shc_work@mail.ru>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============7492777372171541080==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PHCdUe6m4AxPMzOu"
Content-Disposition: inline

--PHCdUe6m4AxPMzOu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 03, 2013 at 09:21:51AM +0300, Felipe Balbi wrote:
> > This is exactly why we have platform_device_alloc(),
> > platform_device_register_full() and friends - so that people don't have=
 to
> > fsck around with kzalloc themselves and get it wrong like the above doe=
s.
> >=20
> > Would you like me to pass your details to gregkh for another one of his
> > public humilation exercises over basic kernel programming stuff? :)
>=20
> How about we pass yours for not reading the patch before flaming ? Note
> that $SUBJECT is *not* touching at all that line which kzallocs a
> platform_device. Wrong as it is, it's not part of $SUBJECT.

that line was added by Roger on commit
5ecd52e563f1e14f9cfe06130fbf9fdb73f227e8 (ARM: OMAP2+: omap-usb-host: Add
usbhs_init_phys()).

--=20
balbi

--PHCdUe6m4AxPMzOu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRg1hCAAoJEIaOsuA1yqREnv4QAJqLb7Phwza5aY7/FlbnAr2w
aS+f68JBb2eVULWfpTNB36jQ7GkXXuOdSXW1u0bGWKbKpMtMc3Rq9SdKBTqzPzwR
aO5AqWN+xy8PIjrnqGhpEwBCbd+rxL9baJbnlXkXFrO+wrAPpaGPHsSOiN85rJIN
1QLXTGCkWNOr0+eEZBRc8YchVkGV7tw+Ut+SivxyT0Gdtiqrxj+xduqzG5MLV3Jv
9SxrthCjg3qZGIm+fukPrDunU1U46MHNrn2aJiB2SVYA/1hueMzEw4RmC9WjLnIf
v00LCIOUQX9HrHlbOYqIp2up6jBB+btC94t2ZiGrOwDwYZhZOvQZXKZ1rqWPD8ga
mRR+nKUBo/e4uFUm0Rah9zkuy5HoXGkRWVj9IP46KUUbHb52Qgfiq3K32xbYmhU8
G9A+VUB6DaVewwbKGH8FKB9t5i/WAOVyaCakHjfRf71bQKuoy5fCwbX+kS0Z5l7r
tiZVXPN1plicmxCAwBRTySPyLErBtwUj9zqoelvTGzWoIZLbLIDwvZgADfQiiwVX
b5js+2gH4Pc5hnXqKO9OuCZPWaHep37grDK+1sgTad80AJ6ULyeyfQ/JwIcrP6ij
/8XQYoS5wO9nimxrXlBtMbzm4ifSumWuYM0N71S+1wylxaPfzy37Wp73zw5O5kla
E89spLZync+VwhjRUIVq
=Redm
-----END PGP SIGNATURE-----

--PHCdUe6m4AxPMzOu--


--===============7492777372171541080==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7492777372171541080==--
