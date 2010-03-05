From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: RE: [PATCH 4/4] DSS2: clear spurious SYNC_LOST_DIGIT interrupts
Date: Fri, 5 Mar 2010 09:19:44 -0600
Message-ID: <A24693684029E5489D1D202277BE894453CC5CA0@dlee02.ent.ti.com>
References: <1267795582-21004-1-git-send-email-ville.syrjala@nokia.com>
 <1267795582-21004-4-git-send-email-ville.syrjala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51667 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753605Ab0CEPTr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Mar 2010 10:19:47 -0500
In-Reply-To: <1267795582-21004-4-git-send-email-ville.syrjala@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ville.syrjala@nokia.com" <ville.syrjala@nokia.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Ville,

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of ville.syrjala@nokia.com
> Sent: Friday, March 05, 2010 7:26 AM
> To: Tomi Valkeinen
> Cc: linux-fbdev@vger.kernel.org; linux-omap@vger.kernel.org; Ville Sy=
rj=E4l=E4
> Subject: [PATCH 4/4] DSS2: clear spurious SYNC_LOST_DIGIT interrupts
>=20
> From: Ville Syrj=E4l=E4 <ville.syrjala@nokia.com>
>=20
> When DSS transitions from off mode to on VENC may generate a spurious
> SYNC_LOST_DIGIT error. Just ack it when restoring the context. Also
> restore IRQENABLE last to avoid triggering interrupts before the
> context is fully restored.

(Tomi or anyone can correct me if I'm wrong)

AFAIK, The solution for spurious interrupts is to flush posted bus writ=
es during interrupt handling, which can be achieved by reading the same=
 register just after you have written it.

Tomi, what do you think?

Regards,
Sergio

>=20
> Signed-off-by: Ville Syrj=E4l=E4 <ville.syrjala@nokia.com>
> ---
>  drivers/video/omap2/dss/dispc.c |   11 ++++++++++-
>  1 files changed, 10 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/video/omap2/dss/dispc.c
> b/drivers/video/omap2/dss/dispc.c
> index e777e35..b8c1603 100644
> --- a/drivers/video/omap2/dss/dispc.c
> +++ b/drivers/video/omap2/dss/dispc.c
> @@ -335,7 +335,7 @@ void dispc_save_context(void)
>  void dispc_restore_context(void)
>  {
>  	RR(SYSCONFIG);
> -	RR(IRQENABLE);
> +	/*RR(IRQENABLE);*/
>  	/*RR(CONTROL);*/
>  	RR(CONFIG);
>  	RR(DEFAULT_COLOR0);
> @@ -472,6 +472,15 @@ void dispc_restore_context(void)
>=20
>  	/* enable last, because LCD & DIGIT enable are here */
>  	RR(CONTROL);
> +
> +	/* clear spurious SYNC_LOST_DIGIT interrupts */
> +	dispc_write_reg(DISPC_IRQSTATUS, DISPC_IRQ_SYNC_LOST_DIGIT);
> +
> +	/*
> +	 * enable last so IRQs won't trigger before
> +	 * the context is fully restored
> +	 */
> +	RR(IRQENABLE);
>  }
>=20
>  #undef SR
> --
> 1.6.4.4
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
