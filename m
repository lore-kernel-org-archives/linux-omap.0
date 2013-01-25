From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v1 1/8] usb: otg: palmas-usb: make palmas-usb as a
 comparator driver
Date: Fri, 25 Jan 2013 10:59:34 +0200
Message-ID: <20130125085934.GJ15886@arwen.pp.htv.fi>
References: <1359083551-8524-1-git-send-email-kishon@ti.com>
 <1359083551-8524-2-git-send-email-kishon@ti.com>
 <20130125074339.GD15886@arwen.pp.htv.fi>
 <510245D7.4090008@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3MHXEHrrXKLGx71o"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <510245D7.4090008-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: kishon <kishon-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org, s-guiriec-l0cyMroinI0@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--3MHXEHrrXKLGx71o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 25, 2013 at 02:14:07PM +0530, kishon wrote:
> On Friday 25 January 2013 01:13 PM, Felipe Balbi wrote:
> >Hi,
> >
> >On Fri, Jan 25, 2013 at 08:42:24AM +0530, Kishon Vijay Abraham I wrote:
> >>palmas-usb is made as a comparator driver to omap usb2 phy, so that
> >>omap usb can make use of palmas for srp and also to set vbus.
> >>
> >>Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
> >
> >doesn't apply. palmas-usb isn't in mainline
> >
> Yes. We'll ask Rajendra Nayak to pick this up in his tree?

Eventually the final version needs to go upstream, though.

--=20
balbi

--3MHXEHrrXKLGx71o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRAkl2AAoJEIaOsuA1yqRECbQQAJvHmPUbs4xx896cRy66Vz6J
46Q6v5R4CtIXGt7nCTWd8Cnpla9YsfGiXg9igm8xHIvmFS8KuPvzBNEwR5Xq9enI
ostktytTV81kKt/rtU7qEpct9VwFI8YQnQl8AN7pUqyJNMmVTe5t7bLCRdp1rfP0
zEo2bOzodkgvEXjNYzjN3XheSqeq+fyHWvKe1RN9A72z49hpDatW/6G2Ijs8i/qg
RDTfLaJkL5h6f1i6lTC2Yb3LUsDo6qcCMXaCGL3V7Nrg9ElaVHJMgrvP2n6SsY6T
CklW4dBg9WMvt/m9ABcZPI22hO+6CkmnK/DeGbF3poubNLNjFyH384Ta3J25hvE0
lfVcB46swosjo7SyVDuaWvS2Z9Bre0P50WLv3ej2Fsno1GMKveqsPt5ot1SsZ4FQ
KJvWa3Ga6zYJZrFy4oDliy9q8tRlG4lwg5slQpZ8PcVQYfn3uX8gOaHHb1OWeSDT
53y1KMi/mYOeJS7mFEeury4E2E7QoPN1Sg9Yn6YmA+XYo++pN/KAXGa+OOHUyXnv
4MRvO7EzvUl126dAC91Wey/aFo9UU2gUcCaC1akrSLmO+3UQb6XjNvEKRBOBcw2q
2/pzK94VD6nDEBYbLALd3cJNOQisr9EH7bUje3XS1QzL1Amnp+dgRTU4GTEUVwKU
VtCcghvDiArFoeOBkd36
=NTLP
-----END PGP SIGNATURE-----

--3MHXEHrrXKLGx71o--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
