From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH 2/2] staging: tidspbridge: rmgr code cleanup
Date: Wed, 22 Dec 2010 14:52:58 -0600
Message-ID: <AANLkTikMD-pEQNNNKOx+1kZt=y896Ciz_kU60NsNzhGJ@mail.gmail.com>
References: <1291931258-30744-1-git-send-email-ionut.nicu@mindbit.ro>
	<1291931258-30744-3-git-send-email-ionut.nicu@mindbit.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:33347 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751886Ab0LVUw6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Dec 2010 15:52:58 -0500
Received: by mail-gy0-f170.google.com with SMTP id 2so2089782gyf.1
        for <linux-omap@vger.kernel.org>; Wed, 22 Dec 2010 12:52:58 -0800 (PST)
In-Reply-To: <1291931258-30744-3-git-send-email-ionut.nicu@mindbit.ro>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ionut Nicu <ionut.nicu@gmail.com>
Cc: Greg Kroah-Hartman <greg@kroah.com>, Sapiens Rene <rene.sapiens@ti.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Fernando Guzman Lugo <x0095840@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, Ionut Nicu <ionut.nicu@mindbit.ro>

Hi Ionut,

On Thu, Dec 9, 2010 at 3:47 PM, Ionut Nicu <ionut.nicu@gmail.com> wrote=
:
> Reorganized some code in the rmgr module to increase
> its readability. No functional changes were done.
>
> Signed-off-by: Ionut Nicu <ionut.nicu@mindbit.ro>
> ---
> =A0drivers/staging/tidspbridge/rmgr/drv.c =A0| =A0171 +++++++++------=
-----
> =A0drivers/staging/tidspbridge/rmgr/node.c | =A0 81 +++++-----
> =A0drivers/staging/tidspbridge/rmgr/rmm.c =A0| =A0266 +++++++++++++--=
---------------
> =A03 files changed, 229 insertions(+), 289 deletions(-)
>
> diff --git a/drivers/staging/tidspbridge/rmgr/drv.c b/drivers/staging=
/tidspbridge/rmgr/drv.c
> index e0fc895..71a9489 100644
> --- a/drivers/staging/tidspbridge/rmgr/drv.c
> +++ b/drivers/staging/tidspbridge/rmgr/drv.c
> @@ -304,40 +304,28 @@ int drv_proc_update_strm_res(u32 num_bufs, void=
 *strm_resources)
=2E..
> @@ -608,40 +596,28 @@ int drv_request_resources(u32 dw_context, u32 *=
dev_node_strg)
> =A0 =A0 =A0 =A0DBC_REQUIRE(dw_context !=3D 0);
> =A0 =A0 =A0 =A0DBC_REQUIRE(dev_node_strg !=3D NULL);
>
> - =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0* =A0Allocate memory to hold the string. This will l=
ive untill
> - =A0 =A0 =A0 =A0* =A0it is freed in the Release resources. Update th=
e driver object
> - =A0 =A0 =A0 =A0* =A0list.
> - =A0 =A0 =A0 =A0*/
> -
> =A0 =A0 =A0 =A0if (!drv_datap || !drv_datap->drv_object)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D -ENODATA;
> - =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdrv_object =3D drv_datap->drv_object;
> -
> - =A0 =A0 =A0 if (!status) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pszdev_node =3D kzalloc(sizeof(struct d=
rv_ext), GFP_KERNEL);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pszdev_node) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 strncpy(pszdev_node->sz=
_string,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (char *=
)dw_context, MAXREGPATHLENGTH - 1);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pszdev_node->sz_string[=
MAXREGPATHLENGTH - 1] =3D '\0';
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Update the Driver Ob=
ject List */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *dev_node_strg =3D (u32=
) pszdev_node->sz_string;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_add_tail(&pszdev_n=
ode->link,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 &pdrv_object->dev_node_string);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D -ENOMEM;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *dev_node_strg =3D 0;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> - =A0 =A0 =A0 } else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(bridge, "%s: Failed to get Driv=
er Object from Registry",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 *dev_node_strg =3D 0;
> - =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODATA;
> +
> + =A0 =A0 =A0 pdrv_object =3D drv_datap->drv_object;
> + =A0 =A0 =A0 *dev_node_strg =3D 0;
> +
> + =A0 =A0 =A0 pszdev_node =3D kzalloc(sizeof(struct drv_ext), GFP_KER=
NEL);
> + =A0 =A0 =A0 if (!pszdev_node)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> +
> + =A0 =A0 =A0 strncpy(pszdev_node->sz_string, (char *)dw_context,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MAXREGPATHLENGTH - 1);
> + =A0 =A0 =A0 pszdev_node->sz_string[MAXREGPATHLENGTH - 1] =3D '\0';
> + =A0 =A0 =A0 *dev_node_strg =3D (u32) pszdev_node->sz_string;
> +
> + =A0 =A0 =A0 /* Update the Driver Object List */
> + =A0 =A0 =A0 list_add_tail((struct list_head *)pszdev_node,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &pdrv_object->dev_node_=
string);

I'm not quite comfortable casting to list_head ptr, given that there
is already a member of that type, if the struct type of pszdev_node is
moved around and the first member changes, there should be issues.

Any reason to use them in this patch?

Regards,

Omar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
