From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH RESEND] ARM: OMAP3: USB: Fix the EHCI ULPI PHY reset issue
Date: Tue, 20 Mar 2012 17:55:42 +0200
Message-ID: <20120320155541.GF32693@arwen.pp.htv.fi>
References: <1332139367-1302-1-git-send-email-keshava_mgowda@ti.com>
 <20120320155353.GE17818@sortiz-mobl>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QNDPHrPUIc00TOLW"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:52696 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753051Ab2CTP4B (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Mar 2012 11:56:01 -0400
Received: by mail-lpp01m010-f50.google.com with SMTP id m13so178655lah.37
        for <linux-omap@vger.kernel.org>; Tue, 20 Mar 2012 08:56:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120320155353.GE17818@sortiz-mobl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: Keshava Munegowda <keshava_mgowda@ti.com>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, balbi@ti.com, parthab@india.ti.com, govindraj.raja@ti.com


--QNDPHrPUIc00TOLW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 20, 2012 at 04:53:53PM +0100, Samuel Ortiz wrote:
> Hi Keshava,
>=20
> On Mon, Mar 19, 2012 at 12:12:47PM +0530, Keshava Munegowda wrote:
> > From: Keshava Munegowda <Keshava_mgowda@ti.com>
> >=20
> > It is observed that the echi ports of 3430 sdp board
> > are not working due to the random timing of programming
> > the associated GPIOs of the ULPI PHYs of the EHCI for reset.
> > If the PHYs are reset at during usbhs core driver, host ports will
> > not work because EHCI driver is loaded after the resetting PHYs.
> > The PHYs should be in reset state while initializing the EHCI
> > controller.
> > The code which does the GPIO pins associated with the PHYs
> > are programmed to reset is moved from the USB host core driver
> > to EHCI driver.
> >=20
> > Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
> > Reviewed-by: Partha Basak <parthab@india.ti.com>
> Felipe, are you ok with that patch ?
> I'll most likely queue it after this merge window is closed though.

my bad, here's my Ack:

Acked-by: Felipe Balbi <balbi@ti.com>

--=20
balbi

--QNDPHrPUIc00TOLW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPaKh9AAoJEIaOsuA1yqRESQAQAKkEQCleJ3sU/JNM2rYC337y
+seiAps1VqcVCypiZ9iMxsllVNEwltTpFnB5MC366WgxQHaQPNfC7EpwkuF9dE2J
LbR/hb98khAaiFhwbE+OQdrfflY014nvJm1m1/dXPxML9WIuOSa6GrVD/ANM1ou8
RtqKYqGdF4u++BWb17U9fp5uZmQ1CFGbKVWnac3HpymXh9gSRQ/KvYm0eK7c2Swk
wHexnJMgQbQpOirkRr20zQKFDFiHPH/dNADcnnqkAUWxwA7j8ZZh0JM6GqgR9bmG
dammQ7CyNM1w4kxCysvnPqiZ4qoVyzrMhVrxrg/YnecAE61KaMMeRJ8HquKdbuI7
A/hVP2FBTx8kmXgbEyr8jR3FEe0q4k8mFxagDtIDjdKD+gQjtL8+967fQQWmkOKG
07aBsWMDorw1AM1igNi4Q/b1Zxh6QXwAx0c90SK8sE1/uMg/mByEu45qKFSrzM58
FIuQYz3O3g6NxE/HfbTrAdrHkHAs37kEkq+VKzPDuGhKPFzgwFn7SODB8Zcq0AFF
cDpWs2v5lGOOV6IxSPa/523Hduk6WVVCvaziqU5v7yEn9jm8Z/SVqVbHMIIgto9H
f1+rylPVz1R5dZt9erVxgBbxsLEcZtqWlrpDhVwshreremhkluM1ifF3q5Y/Dm8K
kz8f47xhjVziDl26DG53
=fzCP
-----END PGP SIGNATURE-----

--QNDPHrPUIc00TOLW--
