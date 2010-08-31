From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 06/11] OMAP: McBSP: Fix static function warning
Date: Tue, 31 Aug 2010 10:34:37 +0300
Message-ID: <201008311034.37939.peter.ujfalusi@nokia.com>
References: <1282856209-15645-1-git-send-email-manjugk@ti.com> <1282856209-15645-7-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:33796 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756832Ab0HaHvo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Aug 2010 03:51:44 -0400
In-Reply-To: <1282856209-15645-7-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>

Hi,

this is audio related file, so use the alsa-devel for this patch, and a=
lso CC=20
the maintainers (Jarkko, Liam, Mark, and me).

On Thursday 26 August 2010 23:56:44 ext G, Manjunath Kondaiah wrote:
> From: Manjunatha GK <manjugk@ti.com>
>=20
> This patch fixes sparse warning due non declaration of static functio=
n
>=20
> sound/soc/omap/omap-mcbsp.c:783:5: warning: symbol
> 'omap_mcbsp_st_info_volsw' was not declared. Should it be static?
>=20
> Signed-off-by: Manjunatha GK <manjugk@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Nishanth Menon <nm@ti.com>
> ---
>  sound/soc/omap/omap-mcbsp.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.=
c
> index 86f2139..5768381 100644
> --- a/sound/soc/omap/omap-mcbsp.c
> +++ b/sound/soc/omap/omap-mcbsp.c
> @@ -780,7 +780,7 @@ struct snd_soc_dai omap_mcbsp_dai[] =3D {
>=20
>  EXPORT_SYMBOL_GPL(omap_mcbsp_dai);
>=20
> -int omap_mcbsp_st_info_volsw(struct snd_kcontrol *kcontrol,
> +static int omap_mcbsp_st_info_volsw(struct snd_kcontrol *kcontrol,
>  			struct snd_ctl_elem_info *uinfo)
>  {
>  	struct soc_mixer_control *mc =3D

Thanks,
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
