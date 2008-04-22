From: "Syed Mohammed, Khasim" <khasim@ti.com>
Subject: RE: [PATCH 2/2] PLAT-OMAP: MCBSP: Move code mach specific from plat-omap to mach-omap
Date: Tue, 22 Apr 2008 15:40:20 +0530
Message-ID: <7EAD1AEEA7621C45899FE99123E124A00192263C@dbde01.ent.ti.com>
References: <20080414181827.GE4463@kedavra.cpe.vivax.com.br><1208203891-11225-1-git-send-email-edubezval@gmail.com><1208203891-11225-2-git-send-email-edubezval@gmail.com><20080421183305.GB12099@atomide.com><a0580c510804212329p141712d7g97bf9f07dbd59621@mail.gmail.com><7EAD1AEEA7621C45899FE99123E124A001922611@dbde01.ent.ti.com> <20080422123819.c46428d6.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:58429 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761998AbYDVKKl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Apr 2008 06:10:41 -0400
Content-class: urn:content-classes:message
In-Reply-To: <20080422123819.c46428d6.jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Eduardo Valentin <eduardo.valentin@indt.org.br>

Hi Jarkko,

> -----Original Message-----
> From: Jarkko Nikula [mailto:jarkko.nikula@nokia.com]
> Sent: Tuesday, April 22, 2008 3:08 PM
> To: Syed Mohammed, Khasim
> Cc: Eduardo Valentin; Tony Lindgren; linux-omap@vger.kernel.org; Eduardo
> Valentin
> Subject: Re: [PATCH 2/2] PLAT-OMAP: MCBSP: Move code mach specific from
> plat-omap to mach-omap
> 
> On Tue, 22 Apr 2008 14:54:21 +0530
> "ext Syed Mohammed, Khasim" <khasim@ti.com> wrote:
> 
> > Good to know you are volunteering for upgrading McBSP driver.
> >
> > Can you also make sure that McBSP driver uses DMA chaining APIs? With
> > out chaining support McBSP Driver will be unusable for a real time
> > audio playback.
> >
> Multichannel chaining is not necessary AFAIK because we can set up
> OMAP DMA transfer so that interrupt is generated in end of each ALSA
> period and then link channel with itself.
> 

Thanks for giving this info, will check this out. 

Regards,
Khasim
