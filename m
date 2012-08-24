From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 01/23] OMAPDSS: outputs: Create a new entity called
 outputs
Date: Fri, 24 Aug 2012 15:41:09 +0300
Message-ID: <1345812069.9287.65.camel@lappyti>
References: <1345528711-27801-1-git-send-email-archit@ti.com>
	 <1345528711-27801-2-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-+d9Q1DlkXL4vSkRCaNhO"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:33446 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759298Ab2HXMlR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Aug 2012 08:41:17 -0400
Received: by lboi15 with SMTP id i15so983760lbo.7
        for <linux-omap@vger.kernel.org>; Fri, 24 Aug 2012 05:41:14 -0700 (PDT)
In-Reply-To: <1345528711-27801-2-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, rob@ti.com, sumit.semwal@ti.com


--=-+d9Q1DlkXL4vSkRCaNhO
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-08-21 at 11:28 +0530, Archit Taneja wrote:

> diff --git a/drivers/video/omap2/dss/output.c b/drivers/video/omap2/dss/o=
utput.c
> new file mode 100644
> index 0000000..034ebbe
> --- /dev/null
> +++ b/drivers/video/omap2/dss/output.c
> @@ -0,0 +1,58 @@
> +/*
> + * Copyright (C) 2012 Texas Instruments Ltd
> + * Author: Archit Taneja <archit@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms of the GNU General Public License version 2 as publis=
hed by
> + * the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but W=
ITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#include <video/omapdss.h>
> +
> +#include "dss.h"
> +
> +static struct list_head output_list;

You can do:

static LIST_HEAD(output_list);

Then you don't need to initialize it separately.

> +
> +struct omap_dss_output *dss_create_output(struct platform_device *pdev)
> +{
> +	struct omap_dss_output *out;
> +
> +	out =3D kzalloc(sizeof(struct omap_dss_output *), GFP_KERNEL);
> +	if (!out)
> +		return NULL;

A patch that adds kzalloc but no free is always a bit suspicious =3D).

> +
> +	out->pdev =3D pdev;
> +
> +	list_add_tail(&out->list, &output_list);
> +
> +	return out;
> +}

Instead of allocating omap_dss_output here, you could let the caller do
it, and only initialize it here with default values (if that's even
needed). Then the caller can use kzalloc, or can just embed the stuct
into its own data-struct, which may be often a better choice.

> +struct omap_dss_output *omap_dss_get_output(enum omap_dss_output_id id)
> +{
> +	struct omap_dss_output *out;
> +
> +	list_for_each_entry(out, &output_list, list) {
> +		if (out->id =3D=3D id)
> +			return out;
> +	}
> +
> +	return NULL;
> +}
> +
> +void dss_init_outputs(void)
> +{
> +	INIT_LIST_HEAD(&output_list);
> +}
> diff --git a/include/video/omapdss.h b/include/video/omapdss.h
> index b868123..0ba613f 100644
> --- a/include/video/omapdss.h
> +++ b/include/video/omapdss.h
> @@ -207,6 +207,16 @@ enum omap_hdmi_flags {
>  	OMAP_HDMI_SDA_SCL_EXTERNAL_PULLUP =3D 1 << 0,
>  };
> =20
> +enum omap_dss_output_id {
> +	OMAP_DSS_OUTPUT_DPI	=3D 1 << 0,
> +	OMAP_DSS_OUTPUT_DBI	=3D 1 << 1,
> +	OMAP_DSS_OUTPUT_SDI	=3D 1 << 2,
> +	OMAP_DSS_OUTPUT_DSI1	=3D 1 << 3,
> +	OMAP_DSS_OUTPUT_VENC	=3D 1 << 4,
> +	OMAP_DSS_OUTPUT_DSI2	=3D 1 << 5,
> +	OMAP_DSS_OUTPUT_HDMI	=3D 1 << 6,
> +};

I'm not sure about this. We already have enum omap_display_type. If you
need the instance number, you could have that as a separate int field.

Where do you need the output_id?

> +
>  /* RFBI */
> =20
>  struct rfbi_timings {
> @@ -492,6 +502,24 @@ struct omap_dsi_pin_config {
>  	int pins[OMAP_DSS_MAX_DSI_PINS];
>  };
> =20
> +struct omap_dss_output {
> +	struct list_head list;
> +
> +	/* display type supported by the output */
> +	enum omap_display_type type;
> +
> +	/* output instance */
> +	enum omap_dss_output_id id;

So instead of omap_dss_output_id, you'd have omap_display_type type and
int id, which together tell the supported output and also the output
driver instance.

 Tomi


--=-+d9Q1DlkXL4vSkRCaNhO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQN3ZlAAoJEPo9qoy8lh71ow4QALH2jk6BLhh97pVtx7hDWbAG
+1JMP27ctqn6Uof+NEVJEheDTKIFEN+nFxMTNkdnisqpgfTkdtCu2yMlpP3vzC+e
jjipuxBsezj7b7dGj8eTAtvZ6XP0sfE7O/hjAXP8sFEdmObCQajWPJb6pcJqsW8i
BJ412wdoIk2XZlkF4xQEM+xtdAHNE8/miOwWj8+FqPANEPQUwDTIJI9Ek8I6nwnM
gBOOAut7C4y74O8OsYZGO/9Ovv495U+d0sNtEhv82I5zTrmfIvfZfN16AQzOO4vM
Gmge4F+WXrJxCdHKrLnvJ4dITsPaaL35sZyDy3isbJNGtHdxTIxlil2ZUqGN0Ots
jluiitHXKwdb8kt+IPYiZu9eMqbKlQaLKWJGS7j6mNZSQShv32GPrnxsmGOiSOMd
jchfV+QNlWEzXwlBj30K7/rf4Fo1h+3Pg+meepQgGfkx/if8YKI0wxH05Xw1vaSL
kFU4HAdoDwii8BIzQF7cFQGMxVOcjvsUi0wM1eTGxoQ1VkI25pCAPtRRj/zKu/G1
v7XplTyLM59Fj/OsbfxzbFgr8i8EaG+1dXMjdybuL+pxlwUPzzF/5azV4lHdJY2c
heXda0pu+8auMhaG4njxQU3QSnnAMK1I8TBuY06XkmA6ILZopySndK5zgWAvyvTG
6NwFBd1o2OI4JJ/b1Ee5
=ksHH
-----END PGP SIGNATURE-----

--=-+d9Q1DlkXL4vSkRCaNhO--

