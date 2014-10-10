From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 00/12] rtc: omap: fixes and power-off feature
Date: Fri, 10 Oct 2014 12:54:22 -0500
Message-ID: <20141010175409.GL31348@saruman>
References: <1412881594-25678-1-git-send-email-johan@kernel.org>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8849467055944287587=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1412881594-25678-1-git-send-email-johan@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Johan Hovold <johan@kernel.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com, Colin Foe-Parker <colin.foeparker@logicpd.com>, devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, j-keerthy@ti.com, nsekhar@ti.com, linux-kernel@vger.kernel.org, Felipe Balbi <balbi@ti.com>, t-kristo@ti.com, Lokesh Vutla <lokeshvutla@ti.com>, linux-arm-kernel@lists.infradead.org, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Andrew Morton <akpm@linux-foundation.org>, linux-omap@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-omap@vger.kernel.org

--===============8849467055944287587==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BHMq0+oGliEfCAkH"
Content-Disposition: inline

--BHMq0+oGliEfCAkH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

HI,

On Thu, Oct 09, 2014 at 09:06:22PM +0200, Johan Hovold wrote:
> This series fixes a few issues with the omap rtc-driver, cleans up a bit
> and finally adds support for the PMIC control feature found in some
> revisions of this RTC IP block.
>=20
> Ultimately, this allows for powering off the Beaglebone and waking it up
> again on RTC alarms.
>=20
> I noticed yesterday that Lokesh Vutla recently posted some patches to
> add regulator support to this driver. [1] While that series has some
> issues that needs to be addressed, I still think it could be a good idea
> to rebase my pmic_power_en patch on top of it as it adds some long
> overdue device abstraction. That would be needed anyway in order to
> support the new power-off infrastructure that's in the pipe in a clean
> way. [2]

is this power-off feature "RTC-only mode" ?

--=20
balbi

--BHMq0+oGliEfCAkH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUOB1OAAoJEIaOsuA1yqRE7VwP/1YlT2FDdK3JP+LNCWskBRKP
mQHz/THWb3LeZnqTP0eWCxRGjMi692UzMB8WYq5TfgeYz/FyYEN4lGrTXmQJmdfR
9LTLyzGuYQE+beRn6x/qRwXSQSvBgv7uWMIpMYKFkjLrjNnUEg4KWc9H/oMnhhon
Y56rioUD/7IfBqN0mHzkqcS1lP1BJT7eWUhbxSeDPGNmeZLqtqIEGkXB/uIPydt7
6QpWNf7xWkUmCkrpQTNlaQh1pxvLBhhfujA6/mSv4Ad2LBLGg838emdc41JhhkK5
gY8QvYlnwDyQcnuOvoObek1FU2u93tKd11ymuweBoyNjHIYpDh30XIgbnHr3P1EW
O1tSHUnhMrd37PHcF1PZj1yEmeKUgCzsI34q1v5kv9rH8TBssexoR948RjeztmhB
wUbO9qRYeIvUBuRMitx7Qdlrl/T9oa9t1oQmIFHHF40V6uohR1vCr/TktMUeaqMq
OuJSeIhI8S8j+LecadpWSD6XQ4sSJ+v2MgyGd/+syBEzgrykcupJO1tgTih1kq0Q
ujsbjxgVFBhfE/MOoOunWD+9Ol2OOyjVTpITozJZcnzcJwRUo95JPU9meQ4cxu8B
96pL6vDqegAoC01JcBxepJQ4guS+NoWmBFyyPKNJ/4XWtEY2AYvJlxNUmDkWsCGy
A6NM/iD6UlPygXRPrmfv
=wxN9
-----END PGP SIGNATURE-----

--BHMq0+oGliEfCAkH--


--===============8849467055944287587==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8849467055944287587==--
