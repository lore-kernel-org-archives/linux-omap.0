From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH v3 1/2] omap: mailbox: enable mailbox irq per instance
Date: Thu, 10 May 2012 08:25:27 +0300
Message-ID: <CAK=WgbYhPVRtptozudJ0MLOq4jdQFrnds7UkkNL_Gdo0cuU4Fg@mail.gmail.com>
References: <1336616370-28268-1-git-send-email-jgutierrez@ti.com> <1336616370-28268-2-git-send-email-jgutierrez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:40286 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954Ab2EJFZt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 May 2012 01:25:49 -0400
Received: by yenm10 with SMTP id m10so1098163yen.19
        for <linux-omap@vger.kernel.org>; Wed, 09 May 2012 22:25:48 -0700 (PDT)
In-Reply-To: <1336616370-28268-2-git-send-email-jgutierrez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Juan Gutierrez <jgutierrez@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Suman Anna <s-anna@ti.com>

On Thu, May 10, 2012 at 5:19 AM, Juan Gutierrez <jgutierrez@ti.com> wro=
te:
> @@ -338,13 +341,13 @@ struct omap_mbox *omap_mbox_get(const char *nam=
e, struct notifier_block *nb)
> =A0 =A0 =A0 =A0if (!mbox)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ERR_PTR(-ENOENT);
>
> + =A0 =A0 =A0 if (nb)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 blocking_notifier_chain_register(&mbox-=
>notifier, nb);
> +
> =A0 =A0 =A0 =A0ret =3D omap_mbox_startup(mbox);
> =A0 =A0 =A0 =A0if (ret)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ERR_PTR(-ENODEV);

Let's unroll blocking_notifier_chain_register when omap_mbox_startup fa=
ils.

Care to do a quick respin of this one with it ?

Thanks,
Ohad.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
