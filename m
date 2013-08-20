From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH] ARM: omap2: Use a consistent AM33XX SoC option
 description
Date: Tue, 20 Aug 2013 13:42:53 -0300
Message-ID: <20130820164251.GC4889@localhost>
References: <1375997528-396-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <CABxcv=keV2Jf4gDwF477a9Msk6b-RgDBcxK1QyhchWffbKAoXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:33858 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751783Ab3HTQmv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Aug 2013 12:42:51 -0400
Content-Disposition: inline
In-Reply-To: <CABxcv=keV2Jf4gDwF477a9Msk6b-RgDBcxK1QyhchWffbKAoXw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Fri, Aug 09, 2013 at 11:18:43AM +0200, Javier Martinez Canillas wrot=
e:
> On Thu, Aug 8, 2013 at 11:32 PM, Ezequiel Garcia
> <ezequiel.garcia@free-electrons.com> wrote:
> > Fix the option description to match the other TI SoCs.
> > This is just a cosmetic change.
> >
> > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > ---
> >  arch/arm/mach-omap2/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kcon=
fig
> > index 76170dd..56021c6 100644
> > --- a/arch/arm/mach-omap2/Kconfig
> > +++ b/arch/arm/mach-omap2/Kconfig
> > @@ -64,7 +64,7 @@ config SOC_OMAP5
> >         select ARM_ERRATA_798181 if SMP
> >
> >  config SOC_AM33XX
> > -       bool "AM33XX support"
> > +       bool "TI AM33XX"
> >         depends on ARCH_MULTI_V7
> >         select ARCH_OMAP2PLUS
> >         select ARM_CPU_SUSPEND if PM
> > --
> > 1.8.1.5
> >
> >
>=20
> Reviewed-by: Javier Martinez Canillas <javier@dowhile0.org>

ping?
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
