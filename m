From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/6] ARM: OMAP4: PM: PRM/CM module offsets for OMAP4
Date: Tue, 11 Aug 2009 08:21:32 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0908110816570.17390@utopia.booyaka.com>
References: <1249907048-12163-1-git-send-email-rnayak@ti.com> <1249907048-12163-2-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.0908110632080.17390@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:38266 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752096AbZHKOVc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Aug 2009 10:21:32 -0400
In-Reply-To: <alpine.DEB.2.00.0908110632080.17390@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, b-cousson@ti.com, sakari.poussa@nokia.com

On Tue, 11 Aug 2009, Paul Walmsley wrote:

> On Mon, 10 Aug 2009, Rajendra Nayak wrote:
> 
> > diff --git a/arch/arm/mach-omap2/prcm-common.h b/arch/arm/mach-omap2/prcm-common.h
> > index cb1ae84..ab0dd8e 100644
> > --- a/arch/arm/mach-omap2/prcm-common.h
> > +++ b/arch/arm/mach-omap2/prcm-common.h

...

> > +#define OMAP4430_WKUP_MOD				0x1700
> > +#define OMAP4430_WKUP_CM_MOD				0x1800
> > +#define OMAP4430_EMU_MOD				0x1900
> > +#define OMAP4430_EMU_CM_MOD				0x1A00

...

> 2. It would be better to infix the module name in these, e.g., 
>    OMAP4430_CM2_INSTR_MOD (and add PRM, CM1 variants) rather than 
>    just OMAP4430_INSTR_MOD.

One other comment on macros like the above: it would also be best 
to use the full PRM/CM submodule name.  So, for instance, 
use OMAP4430_PRM_EMU_PRM_MOD and OMAP4430_PRM_EMU_CM_MOD.  

This is to avoid any potential confusion caused by having to remember a 
rule like "when the PRCM submodule name ends in _PRM, drop the _PRM".  One 
can just use the name from the TRM, always prefixed with the module name, 
and suffixed with _MOD (or whatever).

The gen_prcm44xx.py script will generate these in this format.


- Paul
