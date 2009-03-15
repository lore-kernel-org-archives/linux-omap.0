From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: Overo broken after recent mainline merge
Date: Sun, 15 Mar 2009 12:56:03 -0700
Message-ID: <5e088bd90903151256v554ee5edwbf36d2ebc29add03@mail.gmail.com>
References: <5e088bd90903140624u5b5098f4vd9b1afa937325779@mail.gmail.com>
	 <200903141208.30413.david-b@pacbell.net>
	 <5e088bd90903141647s2faee448s6472f6b7bb9e0ba4@mail.gmail.com>
	 <200903141900.08727.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.168]:60933 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754454AbZCOT4F convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 15 Mar 2009 15:56:05 -0400
Received: by wf-out-1314.google.com with SMTP id 28so1508917wfa.4
        for <linux-omap@vger.kernel.org>; Sun, 15 Mar 2009 12:56:03 -0700 (PDT)
In-Reply-To: <200903141900.08727.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>, linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

On Sat, Mar 14, 2009 at 7:00 PM, David Brownell <david-b@pacbell.net> w=
rote:

> Works for me, and I think you've got all the patches that
> should matter. =A0 This is against today's GIT, yes?
> Does taking #3 away help?

I'm not sure why it is working for you!  Perhaps you have some patches
that aren't included in the current tree?

I believe the root issue is in your recent Overo patch
(http://marc.info/?l=3Dlinux-omap&m=3D123679791627030&w=3D2)

In particular, these lines:

+	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
+	mmc[0].gpio_cd =3D gpio + 0;

Overo, having a microSD slot, doesn't have a card detect switch. The
other part of your patch sets gpio_cd properly:

+static struct twl4030_hsmmc_info mmc[] =3D {
+	{
+		.mmc		=3D 1,
+		.wires		=3D 4,
+		.gpio_cd	=3D -EINVAL,
+		.gpio_wp	=3D -EINVAL,
+	},
+	{
+		.mmc		=3D 2,
+		.wires		=3D 4,
+		.gpio_cd	=3D -EINVAL,
+		.gpio_wp	=3D -EINVAL,
+		.transceiver	=3D true,
+		.ocr_mask	=3D 0x00100000,	/* 3.3V */
+	},
+	{}	/* Terminator */
+};

So all I had to do was remove the above 2 lines to get a successful boo=
t.

Steve
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
