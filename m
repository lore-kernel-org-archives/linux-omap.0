From: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/4] arm: omap: display: Create omapdrm inside omap_display_init
Date: Fri, 13 Sep 2013 12:24:24 +0300
Message-ID: <5232D9C8.9020809@ti.com>
References: <1379063679-4869-1-git-send-email-archit@ti.com> <1379063679-4869-2-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="rgxgLE35p9CwE181ADvJgV4kcSMBsabkt"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1379063679-4869-2-git-send-email-archit-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Archit Taneja <archit-l0cyMroinI0@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andy Gross <andygro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--rgxgLE35p9CwE181ADvJgV4kcSMBsabkt
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 13/09/13 12:14, Archit Taneja wrote:
> Move omapdrm device creation inside the omap_display_init so that we ca=
n
> correctly create the device based on the presence of omapdss.
>=20
> Originally worked on by Andy Gross.

If the dmm device is present in the DT data, there is no need to create
the dmm device. It's created automatically.

Also, omapfb device is currently created the same way as omapdrm,
independently of omapdss. Why is it a problem to have them like that?

 Tomi



--rgxgLE35p9CwE181ADvJgV4kcSMBsabkt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSMtnIAAoJEPo9qoy8lh71ju8QAIVFRA4bWDBzFUgQNPBkwL0k
PGJyronWhEWQgWdbMHiC+qvOsbyAwwinayxXVPTaRoq1hW2AS1AraO9U9i9J6DFJ
wxs6QSEafgLiqxsDe588UgI2Df6HXq2Q9vfXsmAq/lklC2ofRh9SARSKXUCTEswX
XtdsuSHAZADeS73xiNvMIM79nFW64UHhspxERWABfm6fkEe7n47ZFuEBPXW8yiZg
4GgzzKluxCU7kpUAOz46yrrcNS+pYNAlEGS2bUQz29BegFLwA79+flB+dvunxWiM
MCS1gm6lFJ9kWPSru1+fuAxoB2vXfhnarLelDu572LqYEhgymFxpwvr/eX6a8507
oA6eHg4LhgXM+79oit50r7FiEGhXSy1GQ21kq6TXRiAfQnT80k29xF2n034yjuiT
MDLICs+QHeVId4CT9UKH5j7IES+8CXd+apv1wejMczRiH3RlucpryW5x4zFiNQ8z
++LVgfa6noYxFc63P55ClB94Sjgy9xgqIKVYrQUddGykJHJu7I2RjbSl726lUsRR
UZByqqTHiXplMkCGR0YqltRG1iL+jh4NhNXAKXwOQW9ubGZtS+xp9LTowIr+gMKg
/gf73lje4jJP3aGqppFhgfCLNRhcoYib9hUrH52Jh070deRFRx20Aa9/V9QxPUsN
uBTBRBSihGmD0u8wjq+M
=QhVS
-----END PGP SIGNATURE-----

--rgxgLE35p9CwE181ADvJgV4kcSMBsabkt--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
