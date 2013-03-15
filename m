From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/4] usb: Fix linker errors during build
Date: Fri, 15 Mar 2013 16:25:56 +0200
Message-ID: <20130315142556.GA23930@arwen.pp.htv.fi>
References: <1363354132-27523-1-git-send-email-kishon@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1363354132-27523-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: balbi@ti.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, tony@atomide.com, notasas@gmail.com
List-Id: linux-omap@vger.kernel.org

--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2013 at 06:58:49PM +0530, Kishon Vijay Abraham I wrote:
> commit 63378a (usb: phy: remove CONFIG_USB_OTG_UTILS) removed
> CONFIG_USB_OTG_UTILS from Kconfig but failed to removed from Makefile.
> Fixed it here.
>=20
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

I can fold it in original commit since that's not in mainline yet,
thanks

--=20
balbi

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRQy90AAoJEIaOsuA1yqRECUUP/R2QIGNXwBHRiyiPexS64HSX
/EGgksFdDwLBuTDEi+Bypya28gnBZuBTdug7+YG2Nj3uOUtZx9ZreZf0xZi5Ddo7
Dnlgf/owf8+5VjT7myYezouKiyOE70YwMgY9SZPri9dR1ZifpaERZ/k3favbuZbj
CDFWVrRwmkrPQa+S16oGtbz//5+8Hcb+QlVpqN84vLNU7LR/Umw5gkvlAH1cqDyW
BMjSAMVJB4RPCSn5vZ8h1xuZM8aA5ueqwJ+A7YKOY2Z/skiM4zlo6QHGCI83RWCt
R70ZmOKESzha6Jepf/jRxyuXUE1wh2jhWaZEb0S/2tHHuZ75FiDkcoj6oTfqva+5
o+PQ5ZVniQo9PHpfcOK5n25+T56dzllhilDfDjWckf9PlVd29uEU3WHsMI0U44MT
Pmfa1r95PlRQcAtTTvzZc/zEjTQcvZYeWLADl3CQpwMmyyvZB0BijHM9SfhdiRDN
bbIx+AoHi01Qq4VTEnRagNOk45M+SBvpiUqL01QbtXd4jTWCmduHm8skgogHSsfo
e2cWMBAYJf+ty9b1/7pSdEWaNZdaU7K05M3MZvdXfksCzwkflOKoBzCl8LJd21we
s+7/jcIpGXhPK9zZP3p+lHBmqIov2QXcLtU8U4irU5rIjV3ipD4LEvGpEB5ps2RN
ZdD/8PtDEo2/wueVYdCd
=fWBD
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
