From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/4] usb: musb: Call atomic_notifier_call_chain when
 status is changed
Date: Tue, 17 Sep 2013 10:49:17 -0500
Message-ID: <20130917154917.GL15645@radagast>
References: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com>
 <1378630239-10006-2-git-send-email-pali.rohar@gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3088770212309985567=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1378630239-10006-2-git-send-email-pali.rohar@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: linux-usb@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, aaro.koskinen@iki.fi, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Anton Vorontsov <anton@enomsg.org>, linux-kernel@vger.kernel.org, Felipe Balbi <balbi@ti.com>, freemangordon@abv.bg, pavel@ucw.cz, linux-omap@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============3088770212309985567==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7VkxxUl3xUvPtoxk"
Content-Disposition: inline

--7VkxxUl3xUvPtoxk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 08, 2013 at 10:50:36AM +0200, Pali Roh=E1r wrote:
> diff --git a/drivers/usb/phy/phy-twl4030-usb.c b/drivers/usb/phy/phy-twl4=
030-usb.c
> index 8f78d2d..efe6155 100644
> --- a/drivers/usb/phy/phy-twl4030-usb.c
> +++ b/drivers/usb/phy/phy-twl4030-usb.c
> @@ -705,6 +705,8 @@ static int twl4030_usb_probe(struct platform_device *=
pdev)
>  	if (device_create_file(&pdev->dev, &dev_attr_vbus))
>  		dev_warn(&pdev->dev, "could not create sysfs file\n");
> =20
> +	ATOMIC_INIT_NOTIFIER_HEAD(&twl->phy.notifier);

BTW, this is a bugfix, send separately.

--=20
balbi

--7VkxxUl3xUvPtoxk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSOHn9AAoJEIaOsuA1yqREbc0P+QGn7Kr1TlI88D2PM0zG9BuZ
mQHBSecSTx+EoxzKF8skBQvZTXJ+ilnPLGt2RUmEJvU5NLGEkETfxA4fvf7Lg6ka
Sct26xjBS5lNlGjSgnOdisKk80ktRULAlY9ATLhcLzmdP+llsqDApOROBihdY0d6
QKa6Dx/HKQY2u4sJEOwNPwk0ThsysJijTIawkjJWAsuUFCP7kVEezVylG43OntI0
1cI6iW9D0o4BZin29f3yXyN9sgkYyqn8+UR3+wVukaPMLhhrPZ+tbDtqKweHtVgA
oSqVRzHFZb4TXEZy7TC7vQvNDeaqQcPCiutUKe/W2ceo8hfjhAcaBfbH7LfBJIjb
qfoXF4SZfhNrq3/SyDGt6bSKr7EnIBIpFgmCsFiP0Dmlchqc2TqXYdEABNYs3jas
/jkxiYGEyLsIyPy7VLIfQgwpecRyNuu9hB1lK68R5UZFfrgJc5YneLR2DVLDsWi2
U2VKJo2Y8CvpdW2sArepty+3yhxwwLeXZcNj6P08wSMwOC+HkGDaJlWjyWx5mHZ/
TUAHUjBU2T4CNGvC21l5m4kz40oP5C3/ZY9mpVk8Fz2oWzUpDp9Gm3WKd2qryrYL
JYVb/ix5rUc6A0k8SqHiEd6HNxEqRICWSFJFoPbwkAJNDsq1Yp3VNpJCsHKf2YLY
sf44YT8lXBxUHEWiBVPj
=6a2V
-----END PGP SIGNATURE-----

--7VkxxUl3xUvPtoxk--


--===============3088770212309985567==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3088770212309985567==--
