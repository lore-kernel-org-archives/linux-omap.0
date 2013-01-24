From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: OMAP baseline test results for v3.8-rc4
Date: Thu, 24 Jan 2013 12:49:53 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433ECFA0FC@DBDE01.ent.ti.com>
References: <alpine.DEB.2.00.1301202136290.31667@utopia.booyaka.com>
 <50FD6D8D.6030106@mimc.co.uk> <20130121164510.GA18905@kahuna>
 <f36acfaf128c4844b8f696ea4440e253@DLEE74.ent.ti.com>
 <20130121182419.GE10020@beef> <87boci9str.fsf@dell.be.48ers.dk>
 <alpine.DEB.2.00.1301220213390.25789@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36086 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753288Ab3AXMuQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jan 2013 07:50:16 -0500
In-Reply-To: <alpine.DEB.2.00.1301220213390.25789@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, "Porter, Matt" <mporter@ti.com>, Richard Cochran <richardcochran@gmail.com>, "Menon, Nishanth" <nm@ti.com>, Mark Jackson <mpfj-list@mimc.co.uk>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, Peter Korsgaard <jacmet@sunsite.dk>
Cc: "linux-omap\\@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel\\@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Paul,

On Tue, Jan 22, 2013 at 07:54:44, Paul Walmsley wrote:
> 
> Hi guys,
> 
> Regarding the AM33xx test failures with appended DTBs, it would be very 
> helpful if especially the TI people could try reproducing the problem.
> Otherwise it's going to cause problems with merging any new AM33xx 
> patches, since I won't be able to test them without additional work.  
> Plus, this is something that used to work up until d01e4afd, so something 
> isn't right.
> 
> You'll need to use the bootloader that TI originally shipped with the 
> BeagleBones:
> 
> U-Boot 2011.09-00009-gcf6e04d (Mar 08 2012 - 17:15:43)
> 
> This is because many folks don't replace their bootloader.  I do plan to 
> add a test with a recent version of u-boot, but the kernel should not be 
> dependent on the bootloader in any way to work correctly.  If it is, then 
> we need to document what u-boot version the kernel started to work with.
> 
> The Kconfig that I use is here:
> 
> http://www.pwsan.com/omap/testlogs/test_v3.8-rc4/20130120122039/build/am33xx_only/am33xx_only
> 
> It's possible that there's something wrong with the Kconfig.  It's 
> basically just omap2plus_defconfig, but with all OMAP support for 
> non-AM33xx turned off, and with the appended DTB and ATAG compatibility 
> options turned on.
> 
> Let's try to do this ASAP.  That way, if it's some bootloader dependency 
> or bug in the kernel, some fix can be merged during the v3.8-rc series, 
> which is rapidly drawing to a close.
> 

I could not track down U-Boot that you were using so I used the v2013.01 tag
for U-Boot. However, using your build configs for v3.7 and v3.8-rcX I got the same
observations i.e. v3.7 boots but others don't.

One difference that I found was that post v3.7 the configs that you are using have
CONFIG_EARLY_PRINTK set. Once I disabled that I was able to bootup v3.8-rc1/4
(didn't try rc2/3 but I suspect early_printk was the culprit there too).

I checked with Santosh on this and he mentioned that for DT-only boot, which AM335x is,
that's expected behavior.

Can you update your AM335x-only config to disable CONFIG_EARLY_PRINTK or just skip
earlyprintk option in the bootargs for now?

If you still have issues booting can you update your U-Boot to v2013.01 since things
seem to be working fine at this point.

Regards,
Vaibhav
