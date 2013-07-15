From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v6] usb: dwc3: use extcon fwrk to receive
 connect/disconnect
Date: Mon, 15 Jul 2013 18:51:06 +0300
Message-ID: <20130715155106.GE32035@arwen.pp.htv.fi>
References: <1373902742-9495-1-git-send-email-kishon@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kA1LkgxZ0NN7Mz3A"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1373902742-9495-1-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, benoit.cousson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--kA1LkgxZ0NN7Mz3A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2013 at 09:09:02PM +0530, Kishon Vijay Abraham I wrote:
> Modified dwc3-omap to receive connect and disconnect notification using
> extcon framework. Also did the necessary cleanups required after
> adapting to extcon framework.
>=20
> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
> Acked-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> Acked-by: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
> This patch should be applied after all of the extcon patchset will be app=
lied
> because this patch has dependency of extcon patch related to DT.
> http://goo.gl/Tu3qW
>=20
> Changes from v5:
> * rebased to 3.11-rc1
> Changes from v4:
> * checked the return values of extcon_register_interest and print an error
> message. Note that I dint do return since there might be cases where
> one of USB (device mode) or USB-HOST (host mode) might succeed.
> * Added depends on of EXTCON in usb_dwc3. Only some platforms might
> be using EXTCON, but inorder to avoid compilation errors, added
> depends on
> Changes from v3:
> * did #include of of_extcon.h after Chanwoo resent the patch separating
> extcon-class.c from of_extcon.c
> Changes from v2:
> * updated the Documentation with dwc3 dt binding information.
> * used of_extcon_get_extcon_dev to get extcon device from device tree dat=
a.
> Changes from v1:
> * regulator enable/disable is now done here instead of palmas-usb as some=
 users
> of palmas-usb wont need regulator.
>  Documentation/devicetree/bindings/usb/omap-usb.txt |    5 +
>  drivers/usb/dwc3/Kconfig                           |    1 +
>  drivers/usb/dwc3/dwc3-omap.c                       |  125 ++++++++++++++=
+++---
>  3 files changed, 112 insertions(+), 19 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/usb/omap-usb.txt b/Documen=
tation/devicetree/bindings/usb/omap-usb.txt
> index 57e71f6..9088ab0 100644
> --- a/Documentation/devicetree/bindings/usb/omap-usb.txt
> +++ b/Documentation/devicetree/bindings/usb/omap-usb.txt
> @@ -53,6 +53,11 @@ OMAP DWC3 GLUE
>     It should be set to "1" for HW mode and "2" for SW mode.
>   - ranges: the child address space are mapped 1:1 onto the parent addres=
s space
> =20
> +Optional Properties:
> + - extcon : phandle for the extcon device omap dwc3 uses to detect
> +   connect/disconnect events.
> + - vbus-supply : phandle to the regulator device tree node if needed.
> +
>  Sub-nodes:
>  The dwc3 core should be added as subnode to omap dwc3 glue.
>  - dwc3 :
> diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
> index 757aa18..08a9fab 100644
> --- a/drivers/usb/dwc3/Kconfig
> +++ b/drivers/usb/dwc3/Kconfig
> @@ -1,6 +1,7 @@
>  config USB_DWC3
>  	tristate "DesignWare USB3 DRD Core Support"
>  	depends on (USB || USB_GADGET) && GENERIC_HARDIRQS
> +	depends on EXTCON

can you rebase this on top of 'testing' branch. I have a patch there
which give glue layers their own Kconfig symbols. If you do that, I can
queue this patch myself for v3.12, unless we have dependencies on other
patches which aren't in mainline, in which case, I'd ask to simply
remove this Kconfig change for now.

--=20
balbi

--kA1LkgxZ0NN7Mz3A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR5BpqAAoJEIaOsuA1yqREuDYQAJk5fv6gsEqrDbmGu3Z7WK1V
KkzVGoMNOEmu1Wwxtn4F6vUaiKeXSWikgvFfJsQhukRXweiKnZvKS9Aatx4Q+/iQ
sNr9marv4mSNn+mIxIPm1bmc9rlECFdjg47aA78xr8qc/pWz0xY5LCtU7MFe2aG8
i47fuHltHMq4Ed4qTGMMPcyx/6z5MdHW/KaFcwgVssPEW84euVzTbCEhIDHrP/A6
b1IS8Dhn7MhzCXSOqLGiC2/SJJf4mx6sBrT+FKE1KSlasu1btz2lPWL31j0Uu6j1
GCjFMAd6p++kLevv9dGdS2HAxXVylVIfdQ9Z+g/e24DykfkJXRMoJTGi9LxHK6Dg
gnlG+aQpAaFNrLB2NYAuYboYqkVXdDPHyT+rnSX+afcpNYWy8LQApxBPlRFRArsB
yG4KxhJfboOid7054PVfOEpbcs2tnqrTwpRsAkF/q1rqpxSIPiAzqqyaIphEdSL9
FVW+SYmkr/pVuluxJVuioSb0hwC9P4ReoiyB0L/XtFp5H6mUmR/N+TL/xMSKu56Q
Jc7BPMmZ7ILdM18DI//74OknDOVtNbYO907xFXA7K9JEy/Mg/72XT+H3inPcWhfF
xcB7KhauXMjYDE0KmCmBbtLKwrBx9KAHVfXoEOgEnt6m5xN+lLu+fu8UwmHrcpVC
J1ClLrKcLYY92T1RhKTa
=sP/d
-----END PGP SIGNATURE-----

--kA1LkgxZ0NN7Mz3A--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
