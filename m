From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv6 2/7] ARM: OMAP4460: Workaround for ROM bug because of
 CA9 r2pX GIC control register change.
Date: Wed, 18 Jul 2012 12:51:45 +0300
Message-ID: <1342605105.4672.95.camel@sokoban>
References: <1339428387-4800-1-git-send-email-t-kristo@ti.com>
	 <1339428387-4800-3-git-send-email-t-kristo@ti.com>
	 <alpine.DEB.2.00.1207180314250.28834@utopia.booyaka.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44252 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752076Ab2GRJv5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Jul 2012 05:51:57 -0400
In-Reply-To: <alpine.DEB.2.00.1207180314250.28834@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

On Wed, 2012-07-18 at 03:17 -0600, Paul Walmsley wrote:
> Hi
> 
> one trivial comment
> 
> On Mon, 11 Jun 2012, Tero Kristo wrote:
> 
> > diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
> > index 46ab9d9..8d7de4f 100644
> > --- a/arch/arm/mach-omap2/pm.h
> > +++ b/arch/arm/mach-omap2/pm.h
> > @@ -88,6 +88,8 @@ extern void enable_omap3630_toggle_l2_on_restore(void);
> >  static inline void enable_omap3630_toggle_l2_on_restore(void) { }
> >  #endif		/* defined(CONFIG_PM) && defined(CONFIG_ARCH_OMAP3) */
> >  
> > +#define PM_OMAP4_ROM_SMP_BOOT_ERRATUM_xxx	(1 << 0)
> 
> "xxx" isn't unique, nor is it descriptive :-)  
> 
> Looking at the mail threads on this one, it sounds like there may not be a 
> public erratum number associated with this.  If there is, the 'xxx' should 
> be replaced with the number.  If there isn't, then it would be good to 
> make up something short, like "GICD" to replace the "xxx".

There isn't public erratum number for this, thats the reason for xxx. I
can change the xxx to GICD though if that is better.

-Tero


