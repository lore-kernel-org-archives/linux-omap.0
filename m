From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP baseline test results for v3.16-rc4
Date: Tue, 29 Jul 2014 22:39:40 -0700
Message-ID: <20140730053940.GX29045@atomide.com>
References: <alpine.DEB.2.02.1407062339420.15016@utopia.booyaka.com>
 <20140707080238.GF28884@atomide.com>
 <alpine.DEB.2.02.1407251857480.5875@utopia.booyaka.com>
 <20140729064243.GF29045@atomide.com>
 <alpine.DEB.2.02.1407290810160.22957@utopia.booyaka.com>
 <20140729084930.GH29045@atomide.com>
 <alpine.DEB.2.02.1407291225070.13035@utopia.booyaka.com>
 <alpine.DEB.2.02.1407291256270.13035@utopia.booyaka.com>
 <20140729145312.GT29045@atomide.com>
 <alpine.DEB.2.02.1407291922370.13035@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:32172 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751020AbaG3FlH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Jul 2014 01:41:07 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1407291922370.13035@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org

* Paul Walmsley <paul@pwsan.com> [140729 12:39]:
> On Tue, 29 Jul 2014, Tony Lindgren wrote:
> 
> > Hmm maybe different u-boot version then? I'm using
> > 2014.04-00001-g5f09f5b.
> >  
> > > Are you using NFS root on 37xxevm or MMC root?
> > 
> > Using nfsroot and omap2plus_defconfig. My dmesg attached
> > in case it provides some clues. I don't have console=ttyO
> > here, but I've verified that it works with that too.
> 
> Walked through the PM test script by hand, and the proximal cause of the 
> problem became obvious...
> 
> Turns out a five-second delay for a three-second autosuspend_delay_ms is 
> no longer sufficient time for kernels to enter idle.  A ten-second sleep 
> seems to be long enough.

Oh OK.
 
> Not sure what exactly is causing that weirdness yet, or when that started 
> happening.  Am suspecting it could be some of the RCU changes over the 
> past couple of years.  We don't have RCU_FAST_NO_HZ enabled in 
> omap2plus_defconfig; we should probably switch that on.

OK
 
> Now 37xxevm and the 3730beaglexm are entering idle as they should be.  
> Test report below; logs etc. have been uploaded.  Thanks for the debug 
> discussion,

Great, good to hear you found what caused it :)
 
> PM: chip retention via dynamic idle:
>     FAIL ( 5/ 7): 2430sdp, 3530es3beagle, 4430es2panda, 4460pandaes,
> 		  4460varsomom
>     Pass ( 2/ 7): 3730beaglexm, 37xxevm
> 
> PM: chip off except CORE via suspend:
>     Pass ( 1/ 1): 3730beaglexm
> 
> PM: chip off except CORE via dynamic idle:
>     Pass ( 1/ 1): 3730beaglexm
> 
> PM: chip off via suspend:
>     FAIL ( 4/ 5): 3530es3beagle, 4430es2panda, 4460pandaes,
> 		  4460varsomom
>     Pass ( 1/ 5): 37xxevm
> 
> PM: chip off via dynamic idle:
>     FAIL ( 4/ 5): 3530es3beagle, 4430es2panda, 4460pandaes,
> 		  4460varsomom
>     Pass ( 1/ 5): 37xxevm

The following patch should fix the tests above for 3530es3beagle.
Care to test and ack as I don't have one?

Regards,

Tony

8< -----------------------------------
From: Tony Lindgren <tony@atomide.com>
Date: Tue, 29 Jul 2014 22:36:59 -0700
Subject: [PATCH] ARM: dts: Enable UART wake-up events for beagleboard

For device tree based booting, we need to use wake-up
interrupts like we already do for some omaps. This fixes
a PM regression on beagleboard compared to legacy booting.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -292,6 +292,7 @@
 &uart3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart3_pins>;
+	interrupts-extended = <&intc 74 &omap3_pmx_core OMAP3_UART3_RX>;
 };
 
 &gpio1 {
