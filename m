From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/4] Updating Kconfig and Makefile for OMAP3 EVM support
Date: Wed, 16 Apr 2008 13:49:18 -0700
Message-ID: <20080416204917.GE17055@atomide.com>
References: <7EAD1AEEA7621C45899FE99123E124A0018C8603@dbde01.ent.ti.com> <20080414180447.GA4463@kedavra.cpe.vivax.com.br> <7EAD1AEEA7621C45899FE99123E124A0018C8749@dbde01.ent.ti.com> <e2a24afe53a509270888ce07ab944818@felipebalbi.com> <7EAD1AEEA7621C45899FE99123E124A0018C87BA@dbde01.ent.ti.com> <0d3cf630a9b3224f095a15864f78a779@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:56198 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751972AbYDPUtW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Apr 2008 16:49:22 -0400
Content-Disposition: inline
In-Reply-To: <0d3cf630a9b3224f095a15864f78a779@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: "Syed Mohammed, Khasim" <khasim@ti.com>, linux-omap@vger.kernel.org

Hi,

* Felipe Balbi <me@felipebalbi.com> [080415 02:34]:
> 
> 
> On Tue, 15 Apr 2008 14:50:20 +0530, "Syed Mohammed, Khasim" <khasim@ti.com>
> wrote:
> > 
> >> 
> >> >> > Index: my_branch/arch/arm/mach-omap2/Kconfig
> >> >> >
> > ===================================================================
> >> >> > --- my_branch.orig/arch/arm/mach-omap2/Kconfig	2008-04-14
> >> >> 16:07:11.000000000 +0530
> >> >> > +++ my_branch/arch/arm/mach-omap2/Kconfig	2008-04-14
> >> >> 16:07:41.000000000 +0530
> >> >> > @@ -98,10 +98,14 @@
> >> >> >  	bool "OMAP 2430 SDP board"
> >> >> >  	depends on ARCH_OMAP2 && ARCH_OMAP2430
> >> >> >
> >> >> > +config MACH_OMAP_2430OSK
> >> >> > +	bool "OMAP 2430 OSK board"
> >> >> > +	depends on ARCH_OMAP2 && ARCH_OMAP24XX
> >> >> > +
> >> >> >  config MACH_OMAP_3430SDP
> >> >> >  	bool "OMAP 3430 SDP board"
> >> >> >  	depends on ARCH_OMAP3 && ARCH_OMAP34XX
> >> >> >
> >> >> > -config MACH_OMAP_2430OSK
> >> >> > -	bool "OMAP 2430 OSK board"
> >> >> > -	depends on ARCH_OMAP2 && ARCH_OMAP24XX
> >> >> > +config MACH_OMAP3EVM
> >> >> > +	bool "OMAP 3530 EVM board"
> >> >> > +	depends on ARCH_OMAP3 && ARCH_OMAP34XX
> >> >>
> >> >> Do you really need to move 2430OSK here?
> >> >> It looks like unnecessary change.
> >> >>
> >> >> please revert.
> >> >>
> >> > This change is good as it lists all omap2 followed by omap3 boards.
> >> > Otherwise it mixes OMAP2 boards with OMAP3 boards.
> >> 
> >> so put it in a separate patch. It has nothing to do with
> >> "Adding support for OMAP3 EVM"
> > 
> > Why? ???
> > 
> > These lines add OMAP3 EVM
> > 
> > +config MACH_OMAP3EVM
> > +	bool "OMAP 3530 EVM board"
> > +	depends on ARCH_OMAP3 && ARCH_OMAP34XX
> > 
> > The other lines are re-arranging OMAP2 and OMAP3 boards. 
> 
> Yes, re-arranging omap2/3 is another "task". Has nothing to do with
> "adding omap3 evm". I'd rather see these two changes split in two
> separate patches but Tony might be the one with the final word anyway. :-p
> If he's ok with this patch...
> 
> > 
> > We can make two separate patches but this fix seems to be simple.

Looks like they're separate now, good. In general patches should be
separate and independent of each other.

Tony
