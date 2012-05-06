From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH v2 1/3] omap: mailbox: enable mailbox irq per instance
Date: Sun, 6 May 2012 19:00:00 +0300
Message-ID: <CAK=WgbY3OaDH9ziavrXG4oM1ztO3mTmL_eoLPOzCHHKQpHn20w@mail.gmail.com>
References: <1334360392-1494-1-git-send-email-jgutierrez@ti.com> <1334360392-1494-2-git-send-email-jgutierrez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:57929 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752380Ab2EFQAV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 6 May 2012 12:00:21 -0400
Received: by yenm10 with SMTP id m10so3205270yen.19
        for <linux-omap@vger.kernel.org>; Sun, 06 May 2012 09:00:20 -0700 (PDT)
In-Reply-To: <1334360392-1494-2-git-send-email-jgutierrez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Juan Gutierrez <jgutierrez@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Suman Anna <s-anna@ti.com>

Hi Juan,

On Sat, Apr 14, 2012 at 2:39 AM, Juan Gutierrez <jgutierrez@ti.com> wro=
te:
> The machine-specific omap2_mbox_startup is called only once
> to initialize the whole mbox module. Enabling mbox irq at
> startup is only enabling the irq of the very first mailbox
> instance created.
>
> The enable_irq function should be called every time a
> new mbox instance is created,

s/created/opened/

> in the generic platform mailbox layer.

This patch removes an omap2-specific code and then adds it to the
"generic" layer, which also deals with omap1.

Are we sure it's ok ?

OMAP1 doesn't seem to enable its irq at this point: it doesn't even
have a ->startup() handler (which actually somewhat implies it's been
anyway broken for a long time now: omap_mbox_startup() seem to
unhappily bail out if it doesn't find a machine-specific ->startup()
handler).

> diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbo=
x.c
> index ad32621..ebc1ba5 100644
> --- a/arch/arm/plat-omap/mailbox.c
> +++ b/arch/arm/plat-omap/mailbox.c
> @@ -282,6 +282,8 @@ static int omap_mbox_startup(struct omap_mbox *mb=
ox)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mbox->rxq =3D mq;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mq->mbox =3D mbox;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mbox->ops->enable_irq(mbox, IRQ_RX);

Might be nicer to use omap_mbox_enable_irq() here instead of reaching
out for the internal ops.

It also looks like there's a race here: omap_mbox_get() registers the
notifier_block only after omap_mbox_startup() returns, which probably
means there's a small window where an interrupt can be received
without us invoking the user's notifier callback.

This isn't related to your patch of course, but since you're touching
this area, it might be nice if you can fix it (i.e. simply by
registering the notifier_block before enabling the mbox's irq).

> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0mutex_unlock(&mbox_configured_lock);
> =A0 =A0 =A0 =A0return 0;
> @@ -305,6 +307,7 @@ static void omap_mbox_fini(struct omap_mbox *mbox=
)
> =A0 =A0 =A0 =A0mutex_lock(&mbox_configured_lock);
>
> =A0 =A0 =A0 =A0if (!--mbox->use_count) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mbox->ops->disable_irq(mbox, IRQ_RX);

omap_mbox_disable_irq() ?

Thanks,
Ohad.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
