From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 3/5] ARM: l2x0: Errata fix for flush by Way operation can
 cause data corruption
Date: Fri, 18 Feb 2011 17:32:32 +0530
Message-ID: <a52fd2d3aaca5ad999974fe3f886d90d@mail.gmail.com>
References: <1297510187-31547-1-git-send-email-santosh.shilimkar@ti.com><1297510187-31547-4-git-send-email-santosh.shilimkar@ti.com><AANLkTimkqZ5datA+7shggbWz3+j=TDg5beUkQK=b1AmK@mail.gmail.com><13596bec9184b117d6a1d02da8e017bf@mail.gmail.com><AANLkTimjXG5-kEW=1vodnGo3Ct_xOS_HihdqN0TeL9ba@mail.gmail.com><33573d5cfc91cf45dc58ee861cccc2ae@mail.gmail.com><4dfaffa99292bf8e36791ea9a68de75e@mail.gmail.com>
 <AANLkTikEjTgisftQV46djrOP8iWMFV267v-efHsVf_Nd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:35616 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754330Ab1BRMCf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Feb 2011 07:02:35 -0500
Received: by mail-qy0-f173.google.com with SMTP id 38so294360qyl.18
        for <linux-omap@vger.kernel.org>; Fri, 18 Feb 2011 04:02:34 -0800 (PST)
In-Reply-To: <AANLkTikEjTgisftQV46djrOP8iWMFV267v-efHsVf_Nd@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, Andrei Warkentin <andreiw@motorola.com>, Kevin Hilman <khilman@ti.com>, tony@atomide.com, linux-omap@vger.kernel.org

> -----Original Message-----
> From: catalin.marinas@gmail.com [mailto:catalin.marinas@gmail.com]
> On Behalf Of Catalin Marinas
> Sent: Wednesday, February 16, 2011 9:24 PM
> To: Santosh Shilimkar
> Cc: linux-arm-kernel@lists.infradead.org; Andrei Warkentin; Kevin
> Hilman; tony@atomide.com; linux-omap@vger.kernel.org
> Subject: Re: [PATCH 3/5] ARM: l2x0: Errata fix for flush by Way
> operation can cause data corruption
>
> On 15 February 2011 07:14, Santosh Shilimkar
> <santosh.shilimkar@ti.com> wrote:
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -1140,7 +1140,7 @@ config ARM_ERRATA_742231
> >
> > =A0config PL310_ERRATA_588369
> > =A0 =A0 =A0 =A0bool "Clean & Invalidate maintenance operations do n=
ot
> invalidate
> > clean lines"
> > - =A0 =A0 =A0 depends on CACHE_L2X0 && ARCH_OMAP4
> > + =A0 =A0 =A0 depends on CACHE_L2X0 && CACHE_PL310
>
> It can just depend on CACHE_PL310 as this depends on CACHE_L2X0.
>
With CACHE_PL310 alone, I get below warning.

warning: (ARCH_OMAP4) selects PL310_ERRATA_588369 which has unmet direc=
t
dependencies (CACHE_PL310)

This is coming because Pl310 can't be selected on V6 and OMAP
common build has V6 and V7 both enabled.

So to avoid the warning and also able to select the errata in
OMAP build, I am making the errata's depends on CACHE_L2X0
with comment.

Regards,
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
