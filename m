From: Pierre Ossman <drzeus@drzeus.cx>
Subject: Re: [RFC 2/2] MMC/SD Controller driver for OMAP2430
Date: Wed, 1 Aug 2007 14:55:14 +0200
Message-ID: <20070801145514.408a7eeb@poseidon.drzeus.cx>
References: <9C23CDD79DA20A479D4615857B2E2C47016A3482@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2130714851=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C47016A3482@dlee13.ent.ti.com>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Mime-version: 1.0
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: linux-omap-open-source@linux.omap.com, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: linux-omap@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--===============2130714851==
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg=PGP-SHA1;
	boundary="=_hera.drzeus.cx-8545-1185972916-0001-2"

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hera.drzeus.cx-8545-1185972916-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 25 Jul 2007 19:18:50 -0500
"Syed Mohammed, Khasim" <x0khasim@ti.com> wrote:

> +		ret =3D
> twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
> +						vdd_sel,
> VMMC1_DEDICATED);
> +		if (ret !=3D 0)
> +			goto err;
> +
> +		mdelay(100);

100 ms is a rather long time. Can't you use msleep() so that other
things can use the CPU?

> +		ret =3D
> twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
> +						VSEL_S2_CLR,
> VMMC1_DEDICATED);
> +		if (ret !=3D 0)
> +			goto err;
> +
> +		/* 100ms delay required for PBIAS configuration */
> +		mdelay(100);

Same thing here.

Rgds
Pierre

--=_hera.drzeus.cx-8545-1185972916-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFGsIKy7b8eESbyJLgRAn/RAJoChSf49ISlhRnb6dK/yvOT7i8/YACeJ+ZH
6MtigOM4r+rHlbQukLCVm5I=
=cmsD
-----END PGP SIGNATURE-----

--=_hera.drzeus.cx-8545-1185972916-0001-2--


--===============2130714851==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
--===============2130714851==--
