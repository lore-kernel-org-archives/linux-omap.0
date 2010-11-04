From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH RESEND v5 4/5] omap: nand: ecc layout select from board file
Date: Thu, 4 Nov 2010 12:56:57 +0200
Message-ID: <AANLkTinNrZNuZnFfJKGLF9J3zsHsOTK0+VmUmYH88+c3@mail.gmail.com>
References: <1285596710-25658-1-git-send-email-s-ghorai@ti.com>
	<1285596710-25658-5-git-send-email-s-ghorai@ti.com>
	<AANLkTikKMnzHR5DZqzGdJJbnCXhCpxKA7K2C2ZtPhNke@mail.gmail.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B0356BABFAE@dbde02.ent.ti.com>
	<AANLkTinOhBNUt+gvNb0MWiyHD8ZYgLDJPz8tc=p+CsVW@mail.gmail.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B0356BAC2B6@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:41655 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754678Ab0KDK46 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Nov 2010 06:56:58 -0400
Received: by qyk10 with SMTP id 10so1232703qyk.19
        for <linux-omap@vger.kernel.org>; Thu, 04 Nov 2010 03:56:58 -0700 (PDT)
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B0356BAC2B6@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ghorai, Sukumar" <s-ghorai@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Artem.Bityutskiy@nokia.com" <Artem.Bityutskiy@nokia.com>, Vimal Singh <vimal.newwork@gmail.com>, Tony Lindgren <tony@atomide.com>

On Thu, Nov 4, 2010 at 12:15 PM, Ghorai, Sukumar <s-ghorai@ti.com> wrot=
e:
>> -----Original Message-----
>> From: Grazvydas Ignotas [mailto:notasas@gmail.com]
>> OMAP3 pandora.
>> What I wanted to say is that current mainline code has hw ECC forced
>> which is wrong for some boards, and this patch did not make into las=
t
>> merge window, so NAND is broken. It would be good to take this patch
>> out of larger series you sent earlier and resend as a fix for -rc1, =
so
>> that NAND works on 2.6.37. =A0It's not too large and should probably=
 be
>> ok for -rc2.
>
> [Ghorai]
> There is an additional patch I will send (with this series by next we=
ek) to select the ECC from board file, such that different board file c=
an select the different ECC method.
>
> 1. This is mainly for OMAP3630 onwards and has been aligned with many=
 customers to use the hw ecc.
>
> 2. I did not understand how it's not working, would you please explai=
n again? If you apply the series then it's storing the same ecc value i=
n different location and generated from h/w module.

It most likely works (need to test more), I was just complaining it's
not upstream and sw ecc is broken on both 2.6.36 and 2.6.37.

> 3. This patches are not upstream yet; send me the git-link you referr=
ing that these patches are available in 2.6.37?
Correct, they are not upstream, so that's why suggest sending smaller
fix patch for 2.6.37-rc2, so that sw ecc works on 2.6.37.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
