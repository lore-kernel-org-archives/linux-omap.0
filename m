From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 19/20] OMAPDSS: DSI: fix DSI channel source initialization
Date: Mon, 11 Mar 2013 09:02:48 +0200
Message-ID: <513D8198.7070702@ti.com>
References: <1362743515-10152-1-git-send-email-tomi.valkeinen@ti.com> <1362743515-10152-20-git-send-email-tomi.valkeinen@ti.com> <513D754A.4000607@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigEDCDE25C04DEEBF8DF720727"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42160 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750944Ab3CKHCu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Mar 2013 03:02:50 -0400
In-Reply-To: <513D754A.4000607@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

--------------enigEDCDE25C04DEEBF8DF720727
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-03-11 08:10, Archit Taneja wrote:
> Hi,
>=20
> On Friday 08 March 2013 05:21 PM, Tomi Valkeinen wrote:
>> During the initialization of the DSI protocol registers, we always set=

>> the sources of all DSI channels to L4. However, we don't update the
>> value in the dsi_data, so we may end up with a different value in the
>> register and in the dsi_data, leading to DSI problems.
>>
>> This patch fixes the issue by initializing also the channel source in
>> the dsi_data.
>=20
> We set in omap_dsihw_probe:
>=20
> static int __init omap_dsihw_probe(struct platform_device *dsidev)
> {
>     ...
>     ...
>         /* DSI VCs initialization */
>         for (i =3D 0; i < ARRAY_SIZE(dsi->vc); i++) {
>                 dsi->vc[i].source =3D DSI_VC_SOURCE_L4;
>                 dsi->vc[i].dssdev =3D NULL;
>                 dsi->vc[i].vc_id =3D 0;
>         }
>     ...
>     ...
> }

Hmm... I did have a bug related to this when prototyping CDF. Ah.
Consider this:

Panel powers up and uses DSI normally. A DSI VC is set to video mode.
Then the panel power down. Then it powers up again, and enables DSI. At
this time, dsi_vc_initial_config() is called again, setting the source
in the registers to L4. But the source in dsi_data is still VP.

So perhaps the whole piece of code from omap_dsihw_probe should be moved
to somewhere else (dsi_vc_initial_config() sounds like a good place), so
that they are initialized each time the registers are initialized.

 Tomi



--------------enigEDCDE25C04DEEBF8DF720727
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRPYGYAAoJEPo9qoy8lh71KwsP/j06cdMm6zmhh6gz8rAcJE+V
9Em6Hlr3Vi6gpQ07q26ZTEqpsOhZAZijmtrqmDjPj7PDaVZZOCneYZojegpIYeNt
qqw7VxR+RFbWIiaEqSaaPPiJzMgg2kicjj5mElsr0Fo2Xpdd7ZpHidTUwOA8x0Da
4ftVBiL1w2eZlG1sliImvX08IiWJlGSGDPLRzru5DMfl/RenSs596CkNa0BCxBdw
PpdwL0YaRTSOAPjl4zQmpEdFIqHuQr1OUZv+quQinV7LVJxIgM99BxjTz2CNZ6pI
ihVX6V5EzyFNO2xoA8DgD7DXpa42DoUYR0tpeax6tnyq0anRjxnXw13RNkoCkQ4O
LHpCut1RyXxu4wdsYYl2vDdeQzU32gmAhLu6C8WKWMTvxnn9K44JsqfXaMUnTpLW
CHSFNvSVZ35mV11B35uqhbC9OvEOxaEJqGQWsfJx9qpkyKhte8NdDxoyd7ZjmqnP
o/boB5pFlVWC44diqY4jAfW3Tv/PXxzMvQoPvGK7bH+Sgu0kWLvBbMO6ETgoAHxQ
2D/7j68KVUsSax9th/VFrxw7eLWH9lEtJ7y1VACOu/nEnJL+W8wcUI61vGSCcGup
JKTXxHWh+QXFJX3rIwh0tOAZMM8RmL8zqgLrdyXxFpWjgiBvZypnprw5vCCdunLM
9/dP+28joVG9mQTY927N
=fN3t
-----END PGP SIGNATURE-----

--------------enigEDCDE25C04DEEBF8DF720727--
