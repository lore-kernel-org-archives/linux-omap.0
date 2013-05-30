From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [PATCH 03/32] OMAPDSS: add omap_dss_find_output()
Date: Thu, 30 May 2013 13:07:07 +0200
Message-ID: <20130530110707.GH19468@game.jcrosoft.org>
References: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com>
 <1369906493-27538-4-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 12.mo5.mail-out.ovh.net ([46.105.39.65]:55099 "EHLO
	mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932733Ab3E3OtE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 May 2013 10:49:04 -0400
Received: from mail624.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with SMTP id C6ED1FFA956
	for <linux-omap@vger.kernel.org>; Thu, 30 May 2013 13:11:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1369906493-27538-4-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

On 12:34 Thu 30 May     , Tomi Valkeinen wrote:
> Add a support function to find a DSS output by given name. This is used
> in later patches to link the panels to DSS outputs.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>  drivers/video/omap2/dss/output.c | 13 +++++++++++++
>  include/video/omapdss.h          |  1 +
>  2 files changed, 14 insertions(+)
> 
> diff --git a/drivers/video/omap2/dss/output.c b/drivers/video/omap2/dss/output.c
> index 5214df6..3274628 100644
> --- a/drivers/video/omap2/dss/output.c
> +++ b/drivers/video/omap2/dss/output.c
> @@ -115,6 +115,19 @@ struct omap_dss_output *omap_dss_get_output(enum omap_dss_output_id id)
>  }
>  EXPORT_SYMBOL(omap_dss_get_output);
GPL please
>  
> +struct omap_dss_output *omap_dss_find_output(const char *name)
> +{
> +	struct omap_dss_output *out;
> +
> +	list_for_each_entry(out, &output_list, list) {
> +		if (strcmp(out->name, name) == 0)
> +			return out;
> +	}
> +
> +	return NULL;
> +}
I this in so many drivers could we have a macro to generate such function?

> +EXPORT_SYMBOL(omap_dss_find_output);
ditto GPL

Best Regards,
J.
> +
>  static const struct dss_mgr_ops *dss_mgr_ops;
>  
>  int dss_install_mgr_ops(const struct dss_mgr_ops *mgr_ops)
> diff --git a/include/video/omapdss.h b/include/video/omapdss.h
> index d5f1fff..aad47a2 100644
> --- a/include/video/omapdss.h
> +++ b/include/video/omapdss.h
> @@ -779,6 +779,7 @@ int omap_dss_get_num_overlays(void);
>  struct omap_overlay *omap_dss_get_overlay(int num);
>  
>  struct omap_dss_output *omap_dss_get_output(enum omap_dss_output_id id);
> +struct omap_dss_output *omap_dss_find_output(const char *name);
>  int omapdss_output_set_device(struct omap_dss_output *out,
>  		struct omap_dss_device *dssdev);
>  int omapdss_output_unset_device(struct omap_dss_output *out);
> -- 
> 1.8.1.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
