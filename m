From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 1/8] wl1251: split wl251 platform data to a separate
 structure
Date: Wed, 3 Jul 2013 17:11:10 +0300
Message-ID: <20130703141110.GN15056@arwen.pp.htv.fi>
References: <1372860209-3504-1-git-send-email-coelho@ti.com>
 <1372860209-3504-2-git-send-email-coelho@ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5107229085315516820=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1372860209-3504-2-git-send-email-coelho-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Luciano Coelho <coelho-l0cyMroinI0@public.gmane.org>
Cc: nm-l0cyMroinI0@public.gmane.org, mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--===============5107229085315516820==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WoqaC9TUMqqIOlla"
Content-Disposition: inline

--WoqaC9TUMqqIOlla
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 03, 2013 at 05:03:22PM +0300, Luciano Coelho wrote:
> Move the wl1251 part of the wl12xx platform data structure into a new
> structure specifically for wl1251.  Change the platform data built-in
> block and board files accordingly.
>=20
> Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Luciano Coelho <coelho-l0cyMroinI0@public.gmane.org>
> Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

Reviewed-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

--=20
balbi

--WoqaC9TUMqqIOlla
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR1DD+AAoJEIaOsuA1yqREIJMP/RA0CfQRUhy5hOI3QpiRmPI2
nWFFZNqVf0VCQvU87FrTXinUS0/XBUYRLSwDMMo6fFB+jfLsLHfi+hfIbElvhBNM
D01clGzn93P6jxSTqyFKJ8IUsKsP7hTZA5zENbcxVzyB/I4SF062REgAFm2+tnrm
vDZm7BbmmnsUO6WoH5wy2ZQYz5HWyk9wzTKNQ2VQOlGc25PReR9NFzK7IH+dhjyB
sZX4B0PJybY3zlIOJSN2AlcXhsXMz4FtocyE5Dk8kfIV2mFut8JQalNHeq8e2NYx
xdJY2BkSd8qREQwm7Wwcjj1Z0+MDTu21+VjYltWPJxaf7SKedjgr6GXGv8dZ0wVW
2ddwxxJfsI4KnFA6BCeFXjAEkFUrV6IOp0NvyZPEZvNfvrMdxqxlvMoumzdUThyL
9I41PSbnNxk8GU8972Sn7SuKpk6Y0WNc8KjCpVOa3TxQYi/zBaGqTueTv8unp1LY
EC6AJup95nhRBieqq7iEC4olwsUw3bBUfhvIDiX62mh5YLvTc6PYApriOpKo+lW8
7lTkmNgE5p0uF6afXowiRgy5gyz7UptQm+irO9afVgCD27UEwL06oZwkOLt9TFOP
BkfdQnVn0/LdWYbM2EOe60ttKBXNuzPasTHvoCYHEuXEVMRuufoVxgxGz72h9cyV
8zcbVlMiUaPMeQxdOtzP
=nSuo
-----END PGP SIGNATURE-----

--WoqaC9TUMqqIOlla--

--===============5107229085315516820==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============5107229085315516820==--
