From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH v4 5/5] OMAP: mailbox: add notification support for
 multiple readers
Date: Wed, 24 Nov 2010 10:59:54 +0530
Message-ID: <AANLkTi=tzuzOMa6kPp-a6+yn6xMLGtdVSvAxPFP5RU5q@mail.gmail.com>
References: <1290547617-16640-1-git-send-email-h-kanigeri2@ti.com> <1290547617-16640-6-git-send-email-h-kanigeri2@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:37465 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750710Ab0KXFaf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Nov 2010 00:30:35 -0500
Received: by iwn1 with SMTP id 1so11826218iwn.37
        for <linux-omap@vger.kernel.org>; Tue, 23 Nov 2010 21:30:35 -0800 (PST)
In-Reply-To: <1290547617-16640-6-git-send-email-h-kanigeri2@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hari Kanigeri <h-kanigeri2@ti.com>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, linux omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Benoit Cousson <b-cousson@ti.com>, Felipe Balbi <balbi@ti.com>, Fernando Guzman Lugo <x0095840@ti.com>

On Wed, Nov 24, 2010 at 02:56, Hari Kanigeri <h-kanigeri2@ti.com> wrote=
:
> In the current mailbox driver, the mailbox internal pointer for
> callback can be directly manipulated by the Users, so a second
> User can easily corrupt the first user's callback pointer.
> The initial effort to correct this issue can be referred here:
> https://patchwork.kernel.org/patch/107520/
>
> Along with fixing the above stated issue, this patch =A0adds the
> flexibility option to register notifications from
> multiple readers to the events received on a mailbox instance.
> The discussion regarding this can be referred here.
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg30671.html
>
> Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
> Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
> ---
> =A0arch/arm/plat-omap/include/plat/mailbox.h | =A0 =A07 +-
> =A0arch/arm/plat-omap/mailbox.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0104 +=
+++++++++++++++-------------
> =A02 files changed, 62 insertions(+), 49 deletions(-)
>

<<snip>>

> @@ -363,10 +372,13 @@ int omap_mbox_register(struct device *parent, s=
truct omap_mbox **list)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D PTR_ERR(mbox->=
dev);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_out;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> +

Do this change in the patch where the below code was added.

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (cpu_is_omap44xx())
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mbox->rev =3D OMAP_MBO=
X_IP_VERSION_2;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mbox->rev =3D OMAP_MBO=
X_IP_LEGACY;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 BLOCKING_INIT_NOTIFIER_HEAD(&mbox->noti=
fier);
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0return 0;
>
> --
> 1.7.0
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
