From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 2/2] ARM: OMAP: sram: Add am33xx SRAM support
 (minimal)
Date: Mon, 5 Mar 2012 15:14:13 -0800
Message-ID: <20120305231413.GP12083@atomide.com>
References: <1329113715-7634-1-git-send-email-afzal@ti.com>
 <87fweeyfp6.fsf@macbook.be.48ers.dk>
 <B5906170F1614E41A8A28DE3B8D121433179FC35@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:24434 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757410Ab2CEXOS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Mar 2012 18:14:18 -0500
Content-Disposition: inline
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433179FC35@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Cc: Peter Korsgaard <jacmet@sunsite.dk>, "Mohammed, Afzal" <afzal@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Nori, Sekhar" <nsekhar@ti.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>

* Bedia, Vaibhav <vaibhav.bedia@ti.com> [120213 07:36]:
> On Mon, Feb 13, 2012 at 19:54:05, Peter Korsgaard wrote:
> > >>>>> "Afzal" == Afzal Mohammed <afzal@ti.com> writes:
> > 
> >  Afzal> From: Vaibhav Bedia <vaibhav.bedia@ti.com>
> >  Afzal> Update SRAM start & size for am33xx SoC's.
> > 
> 
> This is a really awkward quoting style :|
> 
> > 
> > I don't particular know the omap sram stuff, but doesn't the 33xx have
> > 2x 64K blocks of SRAM?
> > 
> 
> Yes, but since the lower 64KB will not be available on non-GP device and
> only A8 can access it, for now we make use of the higher 64KB which is referred
> to as the OCMC RAM in the TRM. This will also enable SRAM usage by other drivers
> like PRU and McASP.
> 
> >  
> >  Afzal> +static inline int am33xx_sram_init(void)
> >  Afzal> +{
> >  Afzal> +	return 0;
> > 
> > 
> > I know you mentioned it in the commit message, but it might be good with
> > a comment here as well that this dummy function is needed to not get the 34xx
> > init function called for 33xx, so it doesn't get removed when somebody
> > decides to cleanup.
> 
> You are right in saying that the dummy function is needed to avoid 34xx SRAM init.
> We'll have some PM related code coming in soon and hopefully the SRAM code won't change
> Without us noticing ;)

OK, applying into fixes-non-critical-part2. Our sram.c should get turned
into a device driver, there's been already similar sram driver posted
to LAKML. So that should allow us to remove the cpu_is_xxxx checks.

Regards,

Tony
