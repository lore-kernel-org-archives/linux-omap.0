From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH (for-next)] ASoC: Add support for IGEP v2
Date: Wed, 18 Nov 2009 14:33:40 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030A9CA9BB@dbde02.ent.ti.com>
References: <1258479067-2564-1-git-send-email-eballetbo@gmail.com>
 <4B03B7B2.9090401@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37274 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756556AbZKRJDw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Nov 2009 04:03:52 -0500
In-Reply-To: <4B03B7B2.9090401@compulab.co.il>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>, Enric Balletbo i Serra <eballetbo@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Enric Balletbo i Serra <eballetbo@iseebcn.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>

Mike Rapoport wrote:
> Enric Balletbo i Serra wrote:
> > From: Enric Balletbo i Serra <eballetbo@iseebcn.com>
> > 
> > 
> > Signed-off-by: Enric Balletbo i Serra <eballetbo@iseebcn.com>
> > ---
> >  arch/arm/mach-omap2/Kconfig |    2 +-
> >  sound/soc/omap/Kconfig      |    7 ++
> >  sound/soc/omap/Makefile     |    2 +
> >  sound/soc/omap/igep0020.c   |  148 +++++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 158 insertions(+), 1 deletions(-)
> >  create mode 100644 sound/soc/omap/igep0020.c
> > 
> > diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> > index 68866f3..6922198 100644
> > --- a/arch/arm/mach-omap2/Kconfig
> > +++ b/arch/arm/mach-omap2/Kconfig
> > @@ -114,7 +114,7 @@ config MACH_OMAP_3630SDP
> >  	depends on ARCH_OMAP3 && ARCH_OMAP34XX
> >  
> >  config MACH_IGEP0020
> > -	bool "IGEP0020"
> > +	bool "IGEP v2 board"
> >  	depends on ARCH_OMAP3 && ARCH_OMAP34XX
> >  
> >  config MACH_OMAP_4430SDP

This part isn't relevant to ASoC. Shouldn't it go separately through linux-omap?

It could possibly get folded into the patch adding this board support in the
first place.

- Anand


