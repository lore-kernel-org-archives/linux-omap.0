From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Fixed OMAP3 version check
Date: Thu, 25 Sep 2008 15:18:42 +0300
Message-ID: <20080925121841.GQ5222@atomide.com>
References: <1221572797-15949-1-git-send-email-tero.kristo@nokia.com> <1221572797-15949-2-git-send-email-tero.kristo@nokia.com> <20080925101750.GG5222@atomide.com> <B71CE868F2BC2847B3F23C5A8EE394308CEC47@vaebe110.NOE.Nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:57080 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752736AbYIYMSr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Sep 2008 08:18:47 -0400
Content-Disposition: inline
In-Reply-To: <B71CE868F2BC2847B3F23C5A8EE394308CEC47@vaebe110.NOE.Nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero.Kristo@nokia.com
Cc: linux-omap@vger.kernel.org

* Tero.Kristo@nokia.com <Tero.Kristo@nokia.com> [080925 15:10]:
> Hi,
> 
> Here is a fix that works on top of your patch. Tested with ES2.1 and
> ES3.0 chips. I left out the caching for CPU type.

Thanks, I'll merge your fix into my patch and push it to l-o. Will
also create a series for patches for upstream to fix cpu detection.

For the caching of the omap type, if we need to set up something,
let's set up some other register in addition to system_rev. That allows
more tests, like the package type. But let's do it once we really need
it.

Tony

> 
> -Tero 
> 
> >-----Original Message-----
> >From: ext Tony Lindgren [mailto:tony@atomide.com] 
> >Sent: 25 September, 2008 13:18
> >To: Kristo Tero (Nokia-D/Tampere)
> >Cc: linux-omap@vger.kernel.org
> >Subject: Re: [PATCH] Fixed OMAP3 version check
> >
> >Hi,
> >
> >* Tero Kristo <tero.kristo@nokia.com> [080916 14:59]:
> >> CPU version was reported incorrectly (e.g. ES3.0 instead of ES2.1.) 
> >> Also added a piece of optimization for CPU type check (omap_type()).
> >> 
> >> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
> >> ---
> >>  arch/arm/mach-omap2/id.c |    7 +++++--
> >>  1 files changed, 5 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/arch/arm/mach-omap2/id.c 
> >b/arch/arm/mach-omap2/id.c index 
> >> ab7a6e9..4e2b449 100644
> >> --- a/arch/arm/mach-omap2/id.c
> >> +++ b/arch/arm/mach-omap2/id.c
> >> @@ -37,7 +37,10 @@ EXPORT_SYMBOL(omap_chip_is);
> >>  
> >>  int omap_type(void)
> >>  {
> >> -	u32 val = 0;
> >> +	static u32 val;
> >> +
> >> +	if (val != 0)
> >> +		return val;
> >
> >Hmm I guess this would return a random val? :)
> >
> >
> >>  	if (cpu_is_omap24xx()) {
> >>  		val = omap_ctrl_readl(OMAP24XX_CONTROL_STATUS);
> >> @@ -169,7 +172,7 @@ void __init omap34xx_check_revision(void)
> >>  	rev = (idcode >> 28) & 0xff;
> >>  
> >>  	if (hawkeye == 0xb7ae)
> >> -		system_rev = 0x34300034 | ((1 + rev) << 12);
> >> +		system_rev = 0x34300034 | (rev << 12);
> >>  
> >>  out:
> >>  	switch (system_rev) {
> >
> >Well AFAIK here are the numbers for rev:
> >
> >ES1.0	   0	/* Cannot read idcode register */
> >ES2.0	   0
> >ES2.1	   1
> >ES3.0	   2
> >
> >While ES3.0 TRM claims:
> >
> >ES1.0 	   0
> >ES2.0	   1
> >ES2.1	   2
> >ES3.0	   3
> >
> >Which I think is incorrect at least for ES2.0 and ES2.1.
> >
> >Can you please try the attached patch and see if it detects 
> >your ES3.0 correctly?
> >
> >Tony
> >


