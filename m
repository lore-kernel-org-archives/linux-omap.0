From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 1/3] omap mailbox: extend API to take a callback param
Date: Fri, 2 Jul 2010 15:16:29 +0300
Message-ID: <AANLkTingYD9DEngtSouUPetNiqBzIjGlRroHh5r2ajHp@mail.gmail.com>
References: <1278072305-17943-1-git-send-email-Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:56757 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756528Ab0GBMQt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Jul 2010 08:16:49 -0400
Received: by pwi5 with SMTP id 5so587367pwi.19
        for <linux-omap@vger.kernel.org>; Fri, 02 Jul 2010 05:16:49 -0700 (PDT)
In-Reply-To: <1278072305-17943-1-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Hiroshi,

Please consider waiting with pulling of these three patches.

After discussions in l-o, we realized some more work is needed to
support OMAP4 multiple senders scenarios.

Such work can completely replace these 3 patches (retaining their
functionality but adding multiple senders/receivers support).

Thanks,
Ohad.


On Fri, Jul 2, 2010 at 3:05 PM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> w=
rote:
> From: ext Ohad Ben-Cohen <ohad@wizery.com>
>
> Let mailbox users set the callback pointer via the
> omap_mbox_get API, instead of having users directly
> manipulating the mailbox structures.
>
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> ---
> =A0arch/arm/plat-omap/include/plat/mailbox.h | =A0 =A02 +-
> =A0arch/arm/plat-omap/mailbox.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A04=
 +++-
> =A02 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/plat-omap/include/plat/mailbox.h b/arch/arm/pla=
t-omap/include/plat/mailbox.h
> index 9976565..0b45664 100644
> --- a/arch/arm/plat-omap/include/plat/mailbox.h
> +++ b/arch/arm/plat-omap/include/plat/mailbox.h
> @@ -62,7 +62,7 @@ struct omap_mbox {
> =A0int omap_mbox_msg_send(struct omap_mbox *, mbox_msg_t msg);
> =A0void omap_mbox_init_seq(struct omap_mbox *);
>
> -struct omap_mbox *omap_mbox_get(const char *);
> +struct omap_mbox *omap_mbox_get(const char *name, int (*callback)(vo=
id *));
> =A0void omap_mbox_put(struct omap_mbox *);
>
> =A0int omap_mbox_register(struct device *parent, struct omap_mbox **)=
;
> diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbo=
x.c
> index d2fafb8..14b716d 100644
> --- a/arch/arm/plat-omap/mailbox.c
> +++ b/arch/arm/plat-omap/mailbox.c
> @@ -305,7 +305,7 @@ static void omap_mbox_fini(struct omap_mbox *mbox=
)
> =A0 =A0 =A0 =A0}
> =A0}
>
> -struct omap_mbox *omap_mbox_get(const char *name)
> +struct omap_mbox *omap_mbox_get(const char *name, int (*callback)(vo=
id *))
> =A0{
> =A0 =A0 =A0 =A0struct omap_mbox *mbox;
> =A0 =A0 =A0 =A0int ret;
> @@ -324,6 +324,8 @@ struct omap_mbox *omap_mbox_get(const char *name)
> =A0 =A0 =A0 =A0if (ret)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ERR_PTR(-ENODEV);
>
> + =A0 =A0 =A0 mbox->rxq->callback =3D callback;
> +
> =A0 =A0 =A0 =A0return mbox;
> =A0}
> =A0EXPORT_SYMBOL(omap_mbox_get);
> --
> 1.7.1.rc2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
