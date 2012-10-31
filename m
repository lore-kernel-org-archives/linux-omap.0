From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 00/11] ARM: OMAP: USB: Host: Device tree Adaptation
Date: Wed, 31 Oct 2012 15:36:38 +0200
Message-ID: <20121031133638.GV10998@arwen.pp.htv.fi>
References: <1351685810-20616-1-git-send-email-keshava_mgowda@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="t4k3FX2BKM3OLyzG"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1351685810-20616-1-git-send-email-keshava_mgowda@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Keshava Munegowda <keshava_mgowda@ti.com>
Cc: linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-usb@vger.kernel.org, balbi@ti.com, sameo@linux.intel.com
List-Id: linux-omap@vger.kernel.org

--t4k3FX2BKM3OLyzG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 31, 2012 at 05:46:38PM +0530, Keshava Munegowda wrote:
> The USB2 Host driver of OMAP3/OMAP4 are device tree complaiant with
> this patch series.
> The device tree data of UHH, EHCI, OHCI and TLL are included.
> The drivers are updated to extract and use the register set and
> interrupt numbers delivered by these device tree structures.
>=20
> Keshava Munegowda (11):
>   ARM: OMAP4: USB: Host: Add USB2 Host Device Tree Node
>   ARM: OMAP4: USB: Host: Panda board specific device tree node
>   ARM: OMAP3: USB: Add USB2 Host Device Tree Node
>   ARM: OMAP3: USB: Host: Beagle-XM board specific device tree node
>   ARM: OMAP: USB: Host: usb host Device tree node Adaptation
>   ARM: OMAP: USB: Host: USB TLL Device tree node Adaptation
>   ARM: OMAP: USB: Host: Ehci driver uses the usbhs port data
>   ARM: OMAP: USB: Change the TLL clock names
>   ARM: OMAP: USB: Remove the device name for TLL channel clocks for
>     OMAP3
>   ARM: OMAP4: USB: Add pin mux configuration for panda board
>   ARM: OMAP3: USB: Add pin mux configuration for beagle-xm board

Benoit should be in Cc on this series since he's the one handling DT for
OMAPs.

Care to resend with him in Cc ?

(everyone else, please ignore this series, sorry for the noise)

--=20
balbi

--t4k3FX2BKM3OLyzG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQkSlmAAoJEIaOsuA1yqRE+OgP/16MeHKvCJKK5HlK37ar8CQi
dZIxPwp7cZwI/vdX+JsU1UeP9DBDgRIeR/iq1KljQpWe4zkt3QtVjvafUsNk9tpO
/DWMXQfczkFQYRWg5R9tQpQesKGtnh/0GeqWRx9C4vfx7CI2vTJyl6eld9p28L1I
l/UfvngqIasWYkT3QPdXG7r/J5kEJxlui/i+CY1HC5c0VJDVVrCo8Tbj0Riv9jW4
Gcs03/vVbkvYKo3UmtXiSPUiQHWXe+NUXrwTo+tqT4CVXPxpLARWGsjOlNOKtZA5
0h23kfPQaRK/2YF+jbeCY2msPQYEP5hfBvUEVeEuiYFJTD1tnT3bmpBYPsILUEjR
5BFTALyHBFt9P6D43Foe6P6m2aLgnDbH76dYZ4NZcDidoqs9yJd5xuRVaoFK7lZ0
/3FA8m6hNTI3o9RBGduJyrCQ7hzgLSecLG0U0TH1YSBHrRK2wui83MnBWPN8ck6R
+w/6Wj5droYOa2zbBeKv9DB8BfLwgKRuabUpyQP0boYHiAzkIIByunRLvZGeAjRO
wlMhcDfZn0JSiZ49gm0cUnO1r+yggnhy5cLd23vVbjnAUO8zwICLYnX0ZhvFktjy
U5XxLwWHpI6QPL3XLunHoNolLt5DtSBMtszo3sZVIfMJ7MsRCXwVnx0BnDnCk/jO
/a7i+L6Vzx94tHb/V+QI
=LE6i
-----END PGP SIGNATURE-----

--t4k3FX2BKM3OLyzG--
