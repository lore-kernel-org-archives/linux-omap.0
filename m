From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 3/6] omap4: l2x0: Override the default l2x0_disable
Date: Thu, 16 Sep 2010 11:26:39 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02CD260130@dbde02.ent.ti.com>
References: <1283846243-11600-1-git-send-email-santosh.shilimkar@ti.com>
 <1283846243-11600-2-git-send-email-santosh.shilimkar@ti.com>
 <1283846243-11600-3-git-send-email-santosh.shilimkar@ti.com>
 <1283846243-11600-4-git-send-email-santosh.shilimkar@ti.com>
 <20100916002134.GL4174@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42157 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753175Ab0IPF5E convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Sep 2010 01:57:04 -0400
In-Reply-To: <20100916002134.GL4174@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Thursday, September 16, 2010 5:52 AM
> To: Shilimkar, Santosh
> Cc: linux-arm-kernel@lists.infradead.org; tglx@linutronix.de;
> catalin.marinas@arm.com; linux-omap@vger.kernel.org
> Subject: Re: [PATCH 3/6] omap4: l2x0: Override the default l2x0_disable
> 
> * Santosh Shilimkar <santosh.shilimkar@ti.com> [100907 00:50]:
> > The machine_kexec() calls outer_disable which can crash on OMAP4
> > becasue of trustzone restrictions.
> >
> > This patch overrides the default l2x0_disable with a OMAP4
> > specific implementation taking care of trustzone
> 
> <snip>
> 
> > @@ -66,6 +73,12 @@ static int __init omap_l2_cache_init(void)
> >
> >  	 */
> >  	l2x0_init(l2cache_base, 0x0e050000, 0xc0000fff);
> >
> > +	/*
> > +	 * Override default outer_cache.disable with a OMAP4
> > +	 * specific one
> > +	*/
> > +	outer_cache.disable = omap4_l2x0_disable;
> > +
> >  	return 0;
> >  }
> >  early_initcall(omap_l2_cache_init);
> 
> Just to be sure.. No outer_cache functions get set unless
> l2x0_init gets called, right? So omap2 and omap3 functions
> always stay NULL with omap3_defconfig?
> 
Yes.
