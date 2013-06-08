From: Russ Dill <Russ.Dill@ti.com>
Subject: Re: [PATCH 2/7] omap: mailbox: check for NULL nb in mailbox_put
Date: Sat, 8 Jun 2013 11:46:39 -0700
Message-ID: <CA+Bv8XZW-Xv7D-TxqTiUF-t-QESMQqWGOq2fLshXVA-N7if_5w@mail.gmail.com>
References: <1370656664-41250-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qe0-f49.google.com ([209.85.128.49]:51801 "EHLO
	mail-qe0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752378Ab3FHSqk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 8 Jun 2013 14:46:40 -0400
Received: by mail-qe0-f49.google.com with SMTP id cz11so3373653qeb.36
        for <linux-omap@vger.kernel.org>; Sat, 08 Jun 2013 11:46:40 -0700 (PDT)
In-Reply-To: <1370656664-41250-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Ohad Ben-Cohen <ohad@wizery.com>, Omar Ramirez Luna <omar.ramirez@copitl.com>, Jassi Brar <jaswinder.singh@linaro.org>, Loic Pallardy <loic.pallardy@st.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Fernando Guzman Lugo <lugo.fernando@gmail.com>

On Fri, Jun 7, 2013 at 6:57 PM, Suman Anna <s-anna@ti.com> wrote:
> The mailbox_put function must check the notifier block for
> NULL before trying to unregister it.

I'm going to nack this one. Why must it check for NULL? None of the
callers pass a NULL argument and blocking_notifier_chain_unregister
handles a NULL nb argument just fine.

> Signed-off-by: Fernando Guzman Lugo <lugo.fernando@gmail.com>
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
>  arch/arm/plat-omap/mailbox.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
> index 42377ef..5fb4027 100644
> --- a/arch/arm/plat-omap/mailbox.c
> +++ b/arch/arm/plat-omap/mailbox.c
> @@ -356,7 +356,8 @@ EXPORT_SYMBOL(omap_mbox_get);
>
>  void omap_mbox_put(struct omap_mbox *mbox, struct notifier_block *nb)
>  {
> -       blocking_notifier_chain_unregister(&mbox->notifier, nb);
> +       if (nb)
> +               blocking_notifier_chain_unregister(&mbox->notifier, nb);
>         omap_mbox_fini(mbox);
>  }
>  EXPORT_SYMBOL(omap_mbox_put);
> --
> 1.8.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
