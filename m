From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH 1/4] omap mailbox: extend API to take a callback param
Date: Thu, 24 Jun 2010 10:02:52 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E4C890B4A@dlee03.ent.ti.com>
References: <1277251896-6890-1-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57497 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755472Ab0FXPDA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jun 2010 11:03:00 -0400
In-Reply-To: <1277251896-6890-1-git-send-email-ohad@wizery.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>

Looks good.

Iommu get has similar signature, probably we could change that too to take the mmu fault notification function as a function argument.

Thank you,
Best regards,
Hari

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Ohad Ben-Cohen
> Sent: Tuesday, June 22, 2010 7:12 PM
> To: linux-omap@vger.kernel.org
> Cc: Hiroshi Doyu; Ramirez Luna, Omar; Ohad Ben-Cohen
> Subject: [PATCH 1/4] omap mailbox: extend API to take a callback param
> 
> Let mailbox users set the callback pointer via the
> omap_mbox_get API, instead of having users directly
> manipulating the mailbox structures.
> 
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> ---
> I can also be contacted at < ohadb at ti dot com >
> 
>  arch/arm/plat-omap/include/plat/mailbox.h |    2 +-
>  arch/arm/plat-omap/mailbox.c              |    4 +++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/plat/mailbox.h b/arch/arm/plat-
> omap/include/plat/mailbox.h
> index 9976565..0b45664 100644
> --- a/arch/arm/plat-omap/include/plat/mailbox.h
> +++ b/arch/arm/plat-omap/include/plat/mailbox.h
> @@ -62,7 +62,7 @@ struct omap_mbox {
>  int omap_mbox_msg_send(struct omap_mbox *, mbox_msg_t msg);
>  void omap_mbox_init_seq(struct omap_mbox *);
> 
> -struct omap_mbox *omap_mbox_get(const char *);
> +struct omap_mbox *omap_mbox_get(const char *name, int (*callback)(void
> *));
>  void omap_mbox_put(struct omap_mbox *);
> 
>  int omap_mbox_register(struct device *parent, struct omap_mbox **);
> diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
> index d2fafb8..14b716d 100644
> --- a/arch/arm/plat-omap/mailbox.c
> +++ b/arch/arm/plat-omap/mailbox.c
> @@ -305,7 +305,7 @@ static void omap_mbox_fini(struct omap_mbox *mbox)
>  	}
>  }
> 
> -struct omap_mbox *omap_mbox_get(const char *name)
> +struct omap_mbox *omap_mbox_get(const char *name, int (*callback)(void
> *))
>  {
>  	struct omap_mbox *mbox;
>  	int ret;
> @@ -324,6 +324,8 @@ struct omap_mbox *omap_mbox_get(const char *name)
>  	if (ret)
>  		return ERR_PTR(-ENODEV);
> 
> +	mbox->rxq->callback = callback;
> +
>  	return mbox;
>  }
>  EXPORT_SYMBOL(omap_mbox_get);
> --
> 1.7.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
