From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: OMAP baseline test results for v3.8-rc4
Date: Thu, 7 Feb 2013 14:42:09 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433ED0F110@DBDE01.ent.ti.com>
References: <alpine.DEB.2.00.1301202136290.31667@utopia.booyaka.com>
 <50FD6D8D.6030106@mimc.co.uk> <20130121164510.GA18905@kahuna>
 <f36acfaf128c4844b8f696ea4440e253@DLEE74.ent.ti.com>
 <20130121182419.GE10020@beef> <87boci9str.fsf@dell.be.48ers.dk>
 <alpine.DEB.2.00.1301220213390.25789@utopia.booyaka.com>
 <B5906170F1614E41A8A28DE3B8D121433ECFA0FC@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1302062141480.12769@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44832 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758481Ab3BGOm1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Feb 2013 09:42:27 -0500
In-Reply-To: <alpine.DEB.2.00.1302062141480.12769@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Porter, Matt" <mporter@ti.com>, Richard Cochran <richardcochran@gmail.com>, "Menon, Nishanth" <nm@ti.com>, Mark Jackson <mpfj-list@mimc.co.uk>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, Peter Korsgaard <jacmet@sunsite.dk>, "linux-omap\\@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel\\@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Feb 07, 2013 at 03:30:56, Paul Walmsley wrote:
> Hi Vaibhav,
> 
> On Thu, 24 Jan 2013, Bedia, Vaibhav wrote:
> 
> > I could not track down U-Boot that you were using
> 
> It's posted now at:
> 
> http://www.pwsan.com/omap/bootloaders/beaglebone/u-boot/2011.09-00009-gcf6e04d__20120803171543/
> 
> Care to try it?
> 

Thanks. Unfortunately, I'll be able to do this early next week only.

> > However, using your build configs for v3.7 and v3.8-rcX I got the same
> > observations i.e. v3.7 boots but others don't.
> > 
> > One difference that I found was that post v3.7 the configs that you are using have
> > CONFIG_EARLY_PRINTK set. Once I disabled that I was able to bootup v3.8-rc1/4
> > (didn't try rc2/3 but I suspect early_printk was the culprit there too).
> > 
> > I checked with Santosh on this and he mentioned that for DT-only boot, which AM335x is,
> > that's expected behavior.
> > 
> > Can you update your AM335x-only config to disable CONFIG_EARLY_PRINTK
> 
> Setting CONFIG_EARLY_PRINTK=n doesn't fix the problem I'm seeing.
> 
> I also tried building a v3.8-rc6 kernel with the old v3.7-rc config that 
> was used before; no luck.
> 

Ah, I was really hoping you wouldn't say that ;)

> > or just skip earlyprintk option in the bootargs for now?
> 
> Haven't tried this one yet.
> 
> > If you still have issues booting can you update your U-Boot to v2013.01 since things
> > seem to be working fine at this point.
> 
> Let's try to identify and get rid of bootloader dependencies in the 
> kernel.  They indicate that the kernel isn't initializing something 
> appropriately, which could cause strange problems later.
> 

Agreed. It could also be that the boot-loader is doing something crazy but
we do need to know what's the dependency.

Regards,
Vaibhav
