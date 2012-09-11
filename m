From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v9 00/13] usb: musb: adding multi instance support
Date: Tue, 11 Sep 2012 12:17:34 +0300
Message-ID: <20120911091731.GA18907@arwen.pp.htv.fi>
References: <1346411399-23964-1-git-send-email-ravibabu@ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1346411399-23964-1-git-send-email-ravibabu-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ravi Babu <ravibabu-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 31, 2012 at 04:39:46PM +0530, Ravi Babu wrote:
> This series of patches adds,
> a) Multi instances support in musb driver
> b) DT support for musb_dsps glue layer
> c) DT support for NOP transceiver
>=20
> AM33xx and TI81xx has dual musb controller and has two usb PHY of same ty=
pe.
> This patch series uses 'phandle' based API devm_usb_get_phy_by_phandle() =
to
> get the PHY of same type. This API support is being added by Kishon's pat=
ch
> discussed at [1]
>=20
> The series applies to felipe/master [1] branch
> 	+ Vaibhav baseport patches on his tree at [4]
> 	+ Kishon's multi phy patches on Felipe's branch 'xceiv'
> 	+ Kishon's patch on phandle at [2]
> 	+ Damodar's recent patch at [3]=20
> 	+ Ajay's & Damodar's patches at [5] and [6] included in this series
>=20
> 1. http://git.kernel.org/?p=3Dlinux/kernel/git/balbi/usb.git;a=3Dsummary
> 2. http://marc.info/?l=3Dlinux-usb&m=3D134070369306112&w=3D2
> 3. http://marc.info/?l=3Dlinux-usb&m=3D134200284230689&w=3D2
> 4. https://github.com/hvaibhav/am335x-linux/commits/am335x-upstream-stagi=
ng
> 5. http://marc.info/?l=3Dlinux-usb&m=3D134200285530701&w=3D2
> 6. http://marc.info/?l=3Dlinux-usb&m=3D134208820028625&w=3D2
>=20
> Changes from v8:
> 	- included Sergei's comment, removing underscore in device tree file
> 	- removed duplicated signoff from patches
> Changes from v7:
> 	- patches rebased on felipe/master branch & verified
> 	- included additional two patches 0001 & 0002 as part of this series
> 	  which are already submitted [5] & [6]=20
> Changes from v6:
> 	- Removed parent_pdev to get glue and used dev_get_getdrv() as per
> 	  Felipe's comment
> 	- use pr_debug() instead of pr_info() as per Felipe's comment
> Changes from v5:
> 	- Removed musb->id as per Felipe's comment
> 	- used nop_ida as per Felipe's comment
> Changes from v4:
> 	- Fixed Felipe's comment for adding EXPORT_SYMBOL_GPL()
> 	- Fixed Felipe's comment on using dev_set_mask()
> Changes from v3:
> 	- Fixed Kishon's comment on removing "id" from phy struct and
> 	  removing unneeded "#else" part.
> Changes from v2:
> 	- Fixed Sergei's comment on not using address prefix in musb_dsps
> 	  glue and nop transceiver dt dats.
> 	- Also removed the "ti" string in compatible property for nop data.
> Changes from v1:
> 	- Defined musb_ida to manage core ids based on Felipe's comment
> 	  in [PATCH 01/11]

I tried appliying this, but this doesn't apply. Please rebase on my musb
branch. Unfortunately there's no time anymore to wait otherwise the
entire musb branch will miss this merge window.

I'm sorry

--=20
balbi

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQTwGrAAoJEIaOsuA1yqREhw0P/3sgf5SH4zAtNNcXdiSrVvqH
Yk2Qu4VgJ4LfKaII3j1jeP9l0rkBpKgeMn6zcLowI3P+IHYykz+NZMeZQdu3hnRt
ld0MF8Zn4HSwBY3r8PElVZWhi78jfmG/HLozoQjjJXot5o0OgAkrhKxttiDxpjdw
6v3oyS+7cp0YAq9OA2WdIgJOFKGjzg8BAn/wsQF6KR1lb5ACU5k2UpTvx4tm4bjb
ExeSEnKxjjOrC7qPPXduiVXLVLqs8j28hZCG3e4fIENtJUGPIEZQvSfal10Iyhzl
mVGjrJShiL0ScA2vtf6Z2gbiflczDkF1x3NSA6tNnAWmgyhjULcV7o2cBKVbklfF
TzORRIEQCryJqQ68pNHAsYGYqK4LcHZ39+KT/X4IwqfP2izCoi3+0uEK0/iN36UA
iLkQn+QAjpeA47P5q2dCT4NqV7OII/E6BpBNz3W/4ZyfNuvkpcoUJbFM8NwYD+hc
HvScF9j+hXGXOZ5lsyz5jse7e+TfOeSbJ9dzxBlsO0veS/r67jM0mS373g89jdlW
mTIer6fG41RLLAclcCclIqS/rJzuFZ7m9zaJAUwQJeTv2uviYMFeByvVisIMvwDY
43dTvJc0N1OXZrHv/M7Zgl1PPqLE11atK5JMI6m1noHOuap4mccBjckYwAFv9zWB
kgGeaCZ8aDk21rPxAsKI
=xNch
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
