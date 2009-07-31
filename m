From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: Re: [PATCH 02/20] OMAP: McBSP: Wakeups utilized
Date: Fri, 31 Jul 2009 10:56:22 +0300
Message-ID: <20090731075622.GA27083@esdhcp037198.research.nokia.com>
References: <1248958183-15015-1-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-2-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-3-git-send-email-eduardo.valentin@nokia.com>
 <20090730215602.8fdcbaf1.jhnikula@gmail.com>
Reply-To: eduardo.valentin@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:17497 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751034AbZGaIHp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 Jul 2009 04:07:45 -0400
Content-Disposition: inline
In-Reply-To: <20090730215602.8fdcbaf1.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Jarkko Nikula <jhnikula@gmail.com>
Cc: "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "alsa-devel@vger.kernel.org" <alsa-devel@vger.kernel.org>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>

On Thu, Jul 30, 2009 at 08:56:02PM +0200, ext Jarkko Nikula wrote:
> On Thu, 30 Jul 2009 15:49:25 +0300
> Eduardo Valentin <eduardo.valentin@nokia.com> wrote:
> 
> > --- a/arch/arm/plat-omap/mcbsp.c
> > +++ b/arch/arm/plat-omap/mcbsp.c
> > @@ -257,6 +257,23 @@ int omap_mcbsp_request(unsigned int id)
> >  	clk_enable(mcbsp->iclk);
> >  	clk_enable(mcbsp->fclk);
> >  
> > +#ifdef CONFIG_ARCH_OMAP34XX
> > +	/*
> 
> I'm sure there is a way to avoid all of these added ifdefs in this patch
> and in patches 7 and 8 as well.

hmmm.. these ifdef's are required because I've put the extra field (for
34xx only) inside an ifdef on their declaration in mcbsp.h. We can remove it
there, but will leave a few extra bytes on !omap3xx binaries.

> 
> 
> -- 
> Jarkko

-- 
Eduardo Valentin
