From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] ARM: OMAP3: USB: Fix the EHCI ULPI PHY reset issue
Date: Fri, 24 Feb 2012 12:16:33 +0200
Message-ID: <20120224101632.GL17178@legolas.emea.dhcp.ti.com>
References: <1330077975-31694-1-git-send-email-keshava_mgowda@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b1ERR0FXR0PvNIRE"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:56197 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753884Ab2BXKQh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Feb 2012 05:16:37 -0500
Received: by mail-lpp01m010-f43.google.com with SMTP id r15so706068lag.2
        for <linux-omap@vger.kernel.org>; Fri, 24 Feb 2012 02:16:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1330077975-31694-1-git-send-email-keshava_mgowda@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Keshava Munegowda <keshava_mgowda@ti.com>
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, balbi@ti.com, parthab@india.ti.com, govindraj.raja@ti.com


--b1ERR0FXR0PvNIRE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 24, 2012 at 03:36:15PM +0530, Keshava Munegowda wrote:
> From: Keshava Munegowda <Keshava_mgowda@ti.com>
>=20
> It is observed that the echi ports of 3430 sdp board
> are not working due to the random timing of programming
> the associated GPIOs of the ULPI PHYs of the EHCI for reset.
> If the PHYs are reset at during usbhs core driver, host ports will
> not work because EHCI driver is loaded after the resetting PHYs.
> The PHYs should be in reset state while initializing the EHCI
> controller.
> The code which does the GPIO pins associated with the PHYs
> are programmed to reset is moved from the USB host core driver
> to EHCI driver.
>=20
> Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
> Reviewed-by: Partha Basak <parthab@india.ti.com>

won't this cause issues with EHCI/OHCI interactions ? I mean, what if
you connect a FS/LS device and port is handed over to OHCI, does OHCI
have any needs to reset the PHY or something similar ?

--=20
balbi

--b1ERR0FXR0PvNIRE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPR2OAAAoJEIaOsuA1yqREYTgP/jl0Y2asX7ND04AdGgoDDpgS
EEDo9unT6PdBxi41Pxfxgb31hprr7ufhB7pMQdpCnhzG2OJ3gZJxgqPeFhrN+KZ9
JcxUX/WX6XgmpCHzJ/JW5uORhO3dQG9QoSy0Ey4Q/U9Dl+jEF3a/I2EoHPE1jU16
aL28lXpeABPNZd0lMTj+VP8t/8HA/1119f1OUYa9m6DVuuEuBW/GRGjn6922NdCF
YHWti1jWaKDlUfQKTN5iNzv8SmaxfT8gKOpSl6B7X+co3TVYdmjgiwIy80V4qGPO
ESmPph3XFtYFfnrprRxwvZBOaclneEMyL80ldMbc4TY4MHLF77FTUJ8t3MWD+1Yp
EMRgRLXkftfG4gKJ9+HQoZ6fs4m1rXG6FAMT5bOLIsW3l0nEF0evmGJnFCKLDXPP
LbtPqKawMFbs5n2I6h37WrH+daNe39PJE2w9nI7Yzio7CvSRyr12TQOqyTvAkihZ
TNFx2xDjqta+1sYvXVXgpxJG2ATd6hv2lM/o0/Xgrqi6vUygSLibfHiPyotIWVDX
OqgXI392wIJg/RLOthNzTR/ASwR1OFbZAPyszPfArCf7bXdQJ+HHPdQW9ANIcMxW
KLOgM/H9XF8vI3wcjZbAm5SNnK88+lMyPnMmCd8s0hbzYEXu7Z3BIDEpXNTCXZgE
7fRo6R/tBL9ysdosrJlD
=l+u4
-----END PGP SIGNATURE-----

--b1ERR0FXR0PvNIRE--
