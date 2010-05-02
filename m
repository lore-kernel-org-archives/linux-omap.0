From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] omap: mailbox: trivial cleanups
Date: Sun, 2 May 2010 20:53:28 +0300
Message-ID: <s2t94a0d4531005021053yfd53463bx18289118ddf1befd@mail.gmail.com>
References: <1272816321-32494-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:54051 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758355Ab0EBRx3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 2 May 2010 13:53:29 -0400
Received: by bwz19 with SMTP id 19so936553bwz.21
        for <linux-omap@vger.kernel.org>; Sun, 02 May 2010 10:53:28 -0700 (PDT)
In-Reply-To: <1272816321-32494-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Hiroshi Doyu <hiroshi.doyu@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>

On Sun, May 2, 2010 at 7:05 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> @@ -419,7 +416,9 @@ static int __devinit omap2_mbox_probe(struct plat=
form_device *pdev)
> =C2=A0#endif
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
>
> +#if defined(CONFIG_ARCH_OMAP2420) /* IVA */
> =C2=A0err_iva1:
> +#endif
> =C2=A0 =C2=A0 =C2=A0 =C2=A0omap_mbox_unregister(&mbox_dsp_info);

Actually this seems to be wrong, shouldn't it be mbox_iva_info?

Perhaps this makes more sense:

--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -406,21 +406,18 @@ static int __devinit omap2_mbox_probe(struct
platform_device *pdev)
                if (unlikely(!res)) {
                        dev_err(&pdev->dev, "invalid irq resource\n");
                        ret =3D -ENODEV;
-                       goto err_iva1;
+                       goto err_dsp;
                }
                mbox_iva_info.irq =3D res->start;
                ret =3D omap_mbox_register(&pdev->dev, &mbox_iva_info);
-               if (ret)
-                       goto err_iva1;
+               if (ret) {
+                       omap_mbox_unregister(&mbox_iva_info);
+                       goto err_dsp;
+               }
        }
 #endif
        return 0;

-#if defined(CONFIG_ARCH_OMAP2420) /* IVA */
-err_iva1:
-       omap_mbox_unregister(&mbox_iva_info);
-#endif
-
 err_dsp:
        iounmap(mbox_base);
        return ret;

Although there's really no point in calling omap_mbox_unregister if
omap_mbox_register fails. And the probe() function returns error,
shouldn't all the previous registrations be removed?

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
