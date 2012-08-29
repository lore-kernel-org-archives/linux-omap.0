From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 01/23] OMAPDSS: outputs: Create a new entity called
 outputs
Date: Wed, 29 Aug 2012 13:32:50 +0300
Message-ID: <1346236370.2623.45.camel@deskari>
References: <1345528711-27801-1-git-send-email-archit@ti.com>
	  <1345528711-27801-2-git-send-email-archit@ti.com>
	 <1345812069.9287.65.camel@lappyti> <503778E8.2060909@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-5U/wa9774vYRVthGkfzK"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog128.obsmtp.com ([74.125.149.141]:34270 "EHLO
	na3sys009aog128.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751021Ab2H2Kc4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Aug 2012 06:32:56 -0400
Received: by bkwj10 with SMTP id j10so179504bkw.19
        for <linux-omap@vger.kernel.org>; Wed, 29 Aug 2012 03:32:53 -0700 (PDT)
In-Reply-To: <503778E8.2060909@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, rob@ti.com, sumit.semwal@ti.com


--=-5U/wa9774vYRVthGkfzK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-08-24 at 18:21 +0530, Archit Taneja wrote:

> >> +enum omap_dss_output_id {
> >> +	OMAP_DSS_OUTPUT_DPI	=3D 1 << 0,
> >> +	OMAP_DSS_OUTPUT_DBI	=3D 1 << 1,
> >> +	OMAP_DSS_OUTPUT_SDI	=3D 1 << 2,
> >> +	OMAP_DSS_OUTPUT_DSI1	=3D 1 << 3,
> >> +	OMAP_DSS_OUTPUT_VENC	=3D 1 << 4,
> >> +	OMAP_DSS_OUTPUT_DSI2	=3D 1 << 5,
> >> +	OMAP_DSS_OUTPUT_HDMI	=3D 1 << 6,
> >> +};
> >
> > I'm not sure about this. We already have enum omap_display_type. If you
> > need the instance number, you could have that as a separate int field.
> >
> > Where do you need the output_id?
>=20
> output_id is used to take care of situations where there our multiple=20
> outputs of the same type, like DSI1 and DSI2. An enum helps when we=20
> check if an overlay manager supports that output instance or not. For=20
> ex, on OMAP4, LCD1 connects to DSI1 and not DSI2.
>=20
> I add a func called dss_feat_get_supported_outputs(channel) later to=20
> check for this. When setting a new output for a manager, we just do an=
=20
> '&' to see if the output in question is in the mask of the manager's set=
=20
> of supported outputs.

After thinking about this, I think we should remove the
omap_display_type and the supported_displays stuff. It doesn't really
work anymore, as we have more complex connections with omap4+. With a
quick glance to the code, I think it should be quite easy to remove it.

And we need something like your omap_dss_output_id. I'm just not sure
about the enum. But perhaps it's the easiest option for now, as some
kind of array of similar would be more complex to implement, and I'm not
sure if it really gives anything. You could move the VENC away from
between DSI1 and DSI2, though. I'm not sure why you put VENC in between
=3D).

 Tomi


--=-5U/wa9774vYRVthGkfzK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQPe/SAAoJEPo9qoy8lh71GlwP/0xBJGib8jsES15/KaSkcfOA
CysFibLu7CXbwzUvTKC9sKHyJ4658FIc4F/fqButJZwWd9sDxfGZc63v5wMKAdwd
qtUtkz1n8kHTlONGtOLTmakSrI07S9zUByeCqGMPDuK+J4E0hAErXWGFXE6d0h1K
zLPYiy1E44Q+/2ABY8E716at79Y5f5YX7DU52r+2TTqCsE4ksnn9RmdHfwXvVNhB
2VYVw9IJafqCOR047y8dAuSbIJAVzc/SV2OA6inZd9R7gwcSW1yDXAlkMBBpPKwi
EpSdh/hQQJTCIptct123K0uJg3/QKh/p+H46NZGdECzVgghplmbYndx/2ltpE74j
fJ1k29AFAoYfsg7HgdI2zS3O24SngBPqTCZPERkPubZFe/67ajMR3WgkyC7BLU63
wOROO9anIc87ugUYOE5fYYMfEBjgZXcmUpWnWkiivmsynMOwSCI8eYLydSlKHqo6
Kt+U6bXztxL8Fu8/mW/+zWzK5wGoQ5iIcI+bjBzerHVu82ycfPd0/w2CtMVMJALN
AvE0RkhQJ/l6f/ViOxtLNe0gtYJ36GJnSmHBQGzSoNWyqNBDAaAouMq4BfUKxIsl
fh/OAUGXblTFm4XHHuNtWAZi4A0NI2ZHnuVDV1DmOoKKzPRSFtZcpS1XbX/8INsa
7kUNiUwyUPhjcwAZM9V1
=3W60
-----END PGP SIGNATURE-----

--=-5U/wa9774vYRVthGkfzK--

