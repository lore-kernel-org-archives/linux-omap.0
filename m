From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v5 0/6] Make dwc3 use Generic PHY Framework
Date: Mon, 3 Mar 2014 10:40:51 -0600
Message-ID: <20140303164051.GB10987@saruman.home>
References: <1393846695-14644-1-git-send-email-kishon@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ftEhullJWpWg/VHq"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1393846695-14644-1-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, george.cherian-l0cyMroinI0@public.gmane.org, heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--ftEhullJWpWg/VHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 03, 2014 at 05:08:09PM +0530, Kishon Vijay Abraham I wrote:
> Added support for optional PHY in dwc3 as not all SoCs having PHYs for DW=
C3
> should be programmed. While this can be considered as a temporary fix,
> a long term solution would be to add 'nop' PHY for platforms that does
> not have programmable PHY.
> Adapted DWC3 and USB3 PHY to use Generic PHY framework. Also changed the
> name of USB3 PHY driver to PIPE3 PHY driver since the same driver has to
> be used for SATA and PCIE too.
>=20
> Changes from v4: (sending the entire patch series again)
> * check the return values of phy_init and phy_power_on
> * print errors if power_on or power_off of PHY fails.
>=20
> Changes from v3: (Sent only adapt dwc3 core to use Generic PHY Framework)=
=20
> * avoided using quirks and rely on the return values of PHY APIs to find =
the
> presence of PHY.
>=20
> Changes from v2:
> * added a couple of fixes. One is invoking phy_resume after phy_init and =
the
> other is power off phy in error patch
> * used quirks to identify if a particular platform does not have PHYs
> * removed using separate header for pipe3 driver and also removed all ref=
erencs
> to SATA and PCIe in pipe3 driver since it's not yet adapted for those dri=
vers.
>=20
> Changes from v1:
> * The logic in which the driver detects the presence of PHYs has changed.
> * patch ordering has changed
> * udelay is replaced with usleep_range
> * A patch to remove set_suspend callback which was deferred from Generic
> PHY Framework series has been included.
>=20
> Kishon Vijay Abraham I (6):
>   usb: dwc3: core: support optional PHYs
>   usb: dwc3: adapt dwc3 core to use Generic PHY Framework
>   drivers: phy: usb3/pipe3: Adapt pipe3 driver to Generic PHY Framework
>   usb: phy: omap-usb2: remove *set_suspend* callback from omap-usb2
>   phy: omap-usb2: move omap_usb.h from linux/usb/ to linux/phy/
>   arm/dts: added dt properties to adapt to the new phy framwork

patches 1 and 2 are in my testing/next, I guess 3,4,5 and 6 have no
direct dependency on those, right ?

--=20
balbi

--ftEhullJWpWg/VHq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTFLCTAAoJEIaOsuA1yqREt1kP+wX6Shd/dZdsubpGv+I+fEVl
sMInbt/HfO8bKjFlZ/NMYs27WGU0FRmzlVA9jFHtRg+cZCVVKKyXyEegnveS/kTV
MkG1UpwV2Ml3/emMDvIjV+opdtnVvy5FPqfc39GT8P+4VukWHfJW41k7eifZV5R6
/GF03OB8qcCR3kv2fsKr4MFTvIqMkoCMBo2szjAk/qZixQKAwmXZR5+6VpPrQtt2
k7YF0M4kzs/hQ0RllqsHB6wK8YacorpL1I+xlQ67zhcIqyL6Qq+p2TmZpguMFlU3
iFGdx7QUeclawz7Xuq4WicYUW4Ouw7J6b4LGjAoGmUVO69jEex0gVRxas5yvf8xH
x67qdZtTPgyMDbbSjbO1cMU9o9Fb8HpYZUo/CyDSE675m+V1eMNo+01y4bBCkywb
7TNGWvm/mWlTNqaPQQ/DIrStDijSShLhLllc+xJggTk7UdES2s8YqT4jfyicA86W
PAuusq+bXZP6eOGEke5hNOJHG7Bxbv7wAbDMd+CCi+r5ZbeCW0TDVEK7o8Y3Ohmq
i0owImJeT2UMBaNc9/55G5S9C2wdoA0csLX1/Hye5LFkarB9xXdfmxPi/+rBtUdl
/HH/juGyi+VLs58VumIKlplfDkttgZpBLvCUQTBgPB9PNwEesua1MhRw1EmTI9u0
ccgCmoUXNXMAQcA6Hz1Q
=fYr0
-----END PGP SIGNATURE-----

--ftEhullJWpWg/VHq--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
