From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Added support for OMAP35x processor series
Date: Wed, 6 Aug 2008 12:07:09 +0300
Message-ID: <20080806090708.GH19813@atomide.com>
References: <8F7AF80515AF0D4D93307E594F3CB40E0AFDBE42@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:50437 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158AbYHFJHO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Aug 2008 05:07:14 -0400
Content-Disposition: inline
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E0AFDBE42@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kridner, Jason" <jdk@ti.com>
Cc: "'k.kooi@student.utwente.nl'" <k.kooi@student.utwente.nl>, "'linux-omap@vger.kernel.org'" <linux-omap@vger.kernel.org>

* Kridner, Jason <jdk@ti.com> [080805 17:12]:
> No, ROM CRC is useful for detecting between some device revisions, bu=
t not OMAp3430 vs OMAP3530.
>
> ----- Original Message -----
> From: Koen Kooi <k.kooi@student.utwente.nl>
> To: linux-omap@vger.kernel.org <linux-omap@vger.kernel.org>
> Cc: Kridner, Jason
> Sent: Tue Aug 05 05:10:40 2008
> Subject: Re: [PATCH] Added support for OMAP35x processor series
>=20
>=20
> Op 5 aug 2008, om 11:50 heeft Igor Stoppa het volgende geschreven:
>=20
> > On Tue, 2008-08-05 at 15:09 +0530, ext Premi, Sanjeev wrote:
> >> This patch is needed to ensure that we can make decisions based on
> >> the processor capabilities.
> >> E.g. OMAP3503 does not contain a DSP. We shouldn't be trying to
> >> disable/ manage the clocks for
> >> DSP on this processor. Same for SGX.
> >
> > Why can't the detection happen at runtime?
>=20
> AIUI the ID bits are the same (linux misdetect the 3530 on my beagle
> for a 3430). I heard that the only definitive way to do it at runtime
> is to CRC check the ROM code.
>=20
> Jason, is that correct?

Well if there's no way to detect certain omaps during runtime, please
patch arch/arm/plat-omap/common.c to have something like struct
omap_globals omap3503_globals.

BTW, why can't the dsp code detect if the DSP is there or not?

Tony



>=20
> regards,
>=20
> Koen
>=20
> >> Enabling NEON is support iby default is just based on the number o=
f
> >> requests I have been getting
> >> from various users.
> >
> > Huh?
> >
> >
> > --
> >
> > Cheers, Igor
> >
> > ---
> >
> > Igor Stoppa
> > Maemo Software - Nokia Devices R&D - Helsinki
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-
> > omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
>=20
> N?????r??y????b?X??=C7=A7v?^?)=DE=BA{.n?+????{??f??{ay?=1D=CA=87=DA=99=
?,j=07??f???h???z?=1E?w???=0C???j:+v???w?j?m????=07????zZ+?????=DD=A2j"=
??!
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
