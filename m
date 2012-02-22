From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: Latest OMAP randconfig build error
Date: Wed, 22 Feb 2012 21:55:56 +0200
Message-ID: <CAK=WgbY1b4qJXNr7=KyjdqGfexrum=XpTF3QYsw=OgFzv5NQ_A@mail.gmail.com>
References: <20120222085130.GE22675@n2100.arm.linux.org.uk>
 <CAK=WgbYxJyLoYs6vcj0dhSSAFX3vHqZAOHcr9t3+xEAh4ZPBNA@mail.gmail.com> <20120222175822.GV18185@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:50706 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752244Ab2BVT4Q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Feb 2012 14:56:16 -0500
Received: by iacb35 with SMTP id b35so449766iac.19
        for <linux-omap@vger.kernel.org>; Wed, 22 Feb 2012 11:56:16 -0800 (PST)
In-Reply-To: <20120222175822.GV18185@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, "Anna, Suman" <s-anna@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

On Wed, Feb 22, 2012 at 7:58 PM, Tony Lindgren <tony@atomide.com> wrote=
:
> 2430=A0is like omap3 for the mailbox.

Gotcha, thanks.

This one below isn't pretty, but it should satisfy all build
permutations and still be correct hw-wise.

If it looks good to you I'll submit it properly.

diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbo=
x.c
index 609ea2d..6f0f228 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -281,8 +281,14 @@ static struct omap_mbox mbox_iva_info =3D {
 	.ops	=3D &omap2_mbox_ops,
 	.priv	=3D &omap2_mbox_iva_priv,
 };
+#endif

-struct omap_mbox *omap2_mboxes[] =3D { &mbox_dsp_info, &mbox_iva_info,=
 NULL };
+#if defined(CONFIG_ARCH_OMAP2)
+struct omap_mbox *omap2_mboxes[] =3D { &mbox_dsp_info,
+#if defined(CONFIG_SOC_OMAP2420)
+					&mbox_iva_info,
+#endif
+					NULL };
 #endif

 #if defined(CONFIG_ARCH_OMAP4)
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
