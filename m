From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-V2 4/4] ARM: OMAP3+: hwmod: Add AM33XX HWMOD data
Date: Wed, 18 Jul 2012 09:46:39 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA70918@DBDE01.ent.ti.com>
References: <1338285402-11306-1-git-send-email-hvaibhav@ti.com>
 <1338285402-11306-5-git-send-email-hvaibhav@ti.com>
 <alpine.DEB.2.00.1207171353190.28834@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43883 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752964Ab2GRJqr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Jul 2012 05:46:47 -0400
In-Reply-To: <alpine.DEB.2.00.1207171353190.28834@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Mohammed, Afzal" <afzal@ti.com>, "Bedia, Vaibhav" <vaibhav.bedia@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>

On Wed, Jul 18, 2012 at 01:29:01, Paul Walmsley wrote:
> Hi Vaibhav
> 
> a comment.
> 
> On Tue, 29 May 2012, Vaibhav Hiremath wrote:
> 
> > This patch adds HWMOD data for all the peripherals of
> > AM335X device and also hooks up to the existing OMAP framework.
> 
> 
> ...
> 
> > diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> > new file mode 100644
> > index 0000000..df888fe
> > --- /dev/null
> > +++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> > @@ -0,0 +1,3368 @@
> 
> ...
> 
> > +static struct omap_hwmod_irq_info am33xx_emif_irqs[] = {
> > +	{ .name = "ddrerr0", .irq = 101 },
> > +	{ .irq = -1 }
> > +};
> 
> So the above array of struct omap_hwmod_irq_info records has a terminator 
> (which is correct), but many similar arrays do not, such as:
> 
> > +/* l3_main (l3_fast) */
> > +static struct omap_hwmod_irq_info am33xx_l3_main_irqs[] = {
> > +	{ .name = "l3debug", .irq = 9 },
> > +	{ .name = "l3appint", .irq = 10 },
> > +};
> 
> and
> 
> > +static struct omap_hwmod_irq_info am33xx_mpu_irqs[] = {
> > +	{ .name = "emuint", .irq = 0 },
> > +	{ .name = "commtx", .irq = 1 },
> > +	{ .name = "commrx", .irq = 2 },
> > +	{ .name = "bench", .irq = 3 },
> > +};
> 
> and
> 
> > +static struct omap_hwmod_rst_info am33xx_wkup_m3_resets[] = {
> > +	{ .name = "wkup_m3", .rst_shift = 3, .st_shift = 5 },
> > +};
> > +
> > +static struct omap_hwmod_irq_info am33xx_wkup_m3_irqs[] = {
> > +	{ .name = "txev", .irq = 78 },
> > +};
> 
> and several others.  
> 
> Could you add those, please?
> 

Thanks Paul for the review, I will fix it next version.

> The omap_hwmod_dma_info arrays look clean to me.
> 

Have you done with review? Should I wait for further comments or submit the 
next version?

Thanks,
Vaibhav

