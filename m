From: Robert Nelson <robertcnelson@gmail.com>
Subject: Re: [PATCH] ARM: OMAP: Beagle: support MMC gpio_wp differences on xM
Date: Wed, 11 Aug 2010 08:52:12 -0500
Message-ID: <AANLkTim+fmmVtf1O_yf0ZRC83s_GhD3N20XtBF2n=t9i@mail.gmail.com>
References: <1281451216-23725-1-git-send-email-robertcnelson@gmail.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B030E700860@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:46359 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752251Ab0HKNwO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Aug 2010 09:52:14 -0400
Received: by eya25 with SMTP id 25so45821eya.19
        for <linux-omap@vger.kernel.org>; Wed, 11 Aug 2010 06:52:13 -0700 (PDT)
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B030E700860@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ghorai, Sukumar" <s-ghorai@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>> - =A0 =A0 if (system_rev >=3D 0x20 && system_rev <=3D 0x34301000) {
>> + =A0 =A0 if (cpu_is_omap3630()) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 mmc[0].gpio_wp =3D -EINVAL;
>> + =A0 =A0 } else if (system_rev >=3D 0x20 && system_rev <=3D 0x34301=
000) {
> [Ghorai] it's an old code. But I think we can replace the hardcode va=
lue to use omap_rev() as you are changing the same! Or default for all =
omap34xx?

It's actually broken too. ;)

My Bx board falls into that "Cx" if..  (and explains why the
write-protect lever on my sd card is ignored on that test system)

Looking at mainline u-boot, where system_rev is defined and passed to
the kernel, it is a constant 0x20...

I'm going to try using gpio pins 171/172/173 which were used to
identify what Beagle Hardware Rev (Ax/Bx, C2/C3, C4, xM)

>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_mux_init_gpio(23, OMAP_PIN_INPUT);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc[0].gpio_wp =3D 23;
>> =A0 =A0 =A0 } else {

Regards,

--=20
Robert Nelson
http://www.rcn-ee.com/
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
