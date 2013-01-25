From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v4 4/4] drivers: usb: start using the control module
 driver
Date: Fri, 25 Jan 2013 12:27:00 +0200
Message-ID: <20130125102700.GO15886@arwen.pp.htv.fi>
References: <1359109440-2195-1-git-send-email-kishon@ti.com>
 <1359109440-2195-5-git-send-email-kishon@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xXygN3QAmJYWdGtb"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1359109440-2195-5-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--xXygN3QAmJYWdGtb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jan 25, 2013 at 03:54:00PM +0530, Kishon Vijay Abraham I wrote:
> Start using the control module driver for powering on the PHY and for
> writing to the mailbox instead of writing to the control module
> registers on their own.
>=20
> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/usb/omap-usb.txt |    4 ++
>  Documentation/devicetree/bindings/usb/usb-phy.txt  |    7 +-
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |   13 ----

I'm taking this patch but I'm leaving out the omap_hwmod_44xx_data.c
change just to kill dependency. Can you send that single change as a
separate patch which Tony can queue ?

--=20
balbi

--xXygN3QAmJYWdGtb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRAl30AAoJEIaOsuA1yqREU1gP/2I1Wkkkg/GoIVP3VrxRFT/6
eYgCznQW9qaMZ12A0YoqyLGUlOveIQXcchFzyZQQ+5EZzFVZDfXHhfRBdCpUOUzR
4bGHapU0fsJMAbmmU5qBELrU/ekUHUJCNLlBJB7q9qZcM1osPgrA5cpB8kD9wgjh
tG4yrS6qEuo703SY+0O1n1aEOMM+n4gETxD74BJlwS0R9HLXD6JZ1Nd9zzWU1JQW
cS+2Wrb7Q62pPvDfWliDBfqQAXuHagt/tj+4LwLO/Le2rWwaCoBh/ozv3DkHGxKS
qpNHGApMKJTRuNnQ8wd+ZkjXzmEZ+Y5QQtWOqeFCJB2m8QFaWovgUJZeI/UlTQvq
wACUY3b/XCrr1oC4M3JOzFYfFEjoXXW4U8QlvWRIWHe1Rb/BusLRor8gnZhrQ8hV
ocrSKELWQzsV/s5gbc3q47sGGVMaq3LOgA1M0Usv53mA60W/EnBaxcq+tcl9Dj/t
ACsS6GoIqsj4DH1zLUI5ftTKO3GkBdexL+YRpmtaJoeSrQum+h/qdqmCMWCx/RNw
9674Gn9HDT+UNebpX0MjQOQCqfMJt4gMibzPyNF4VYh/EDffjxkYHMqAPBwlcZd1
Qh9Z6+m5JZEIvOo35wSkm2UNuet6lLUO+uJH5IlYBXItdYmwb3sc4otmV4La1gaO
Ndx5p2DFCZ1hf0xy0FHk
=cDOB
-----END PGP SIGNATURE-----

--xXygN3QAmJYWdGtb--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
