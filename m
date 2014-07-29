From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP baseline test results for v3.16-rc4
Date: Mon, 28 Jul 2014 23:42:43 -0700
Message-ID: <20140729064243.GF29045@atomide.com>
References: <alpine.DEB.2.02.1407062339420.15016@utopia.booyaka.com>
 <20140707080238.GF28884@atomide.com>
 <alpine.DEB.2.02.1407251857480.5875@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:59146 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751223AbaG2GoI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Jul 2014 02:44:08 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1407251857480.5875@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org

* Paul Walmsley <paul@pwsan.com> [140725 12:16]:
> On Mon, 7 Jul 2014, Tony Lindgren wrote:
> 
> > With v3.16-rc4 the PM features for omap3 should be working
> > finally for device tree based booting. At lest beaglexm and
> > 3xxevm should work.
> 
> Just to follow up briefly on this: there was indeed a bug in the OMAP3 
> test scripts here that resulted in the UART wakeup not being enabled.
> 
> Once that was fixed, system suspend-based chip-retention and chip-off 
> modes work.

OK
 
> However, scheduler-idle based chip-retention and chip-off still are not
> working.  Looking at the logs, it appears that some domains are not 
> dynamically going idle.  For example, looking at:
> 
> http://www.pwsan.com/omap/testlogs/test_v3.16-rc6/20140724142225/pm/37xxevm/37xxevm_log.txt
> 
> it can be seen that core_pwrdm's retention count doesn't increase between 
> the two PM debug dumps.  The important lines are:
> 
> core_pwrdm (ON),OFF:0,RET:2,INA:0,ON:3,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0
> 
> and 
> 
> core_pwrdm (ON),OFF:0,RET:2,INA:0,ON:3,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0
> 
> That's why the test reports mark the dynamic PM modes as failing.
> 
> ...
> 
> Here's an example where things worked:
> 
> http://www.pwsan.com/omap/testlogs/test_v3.10/20130717134228/pm/3530es3beagle/3530es3beagle_log.txt
> 
> In this one, it can be seen that the CORE counts transitioned from:
> 
> core_pwrdm (ON),OFF:0,RET:2,INA:0,ON:3,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0
> 
> to
> 
> core_pwrdm (ON),OFF:0,RET:10,INA:0,ON:11,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0
> 
> between the retention suspend/resume test ending and the dynamic 
> retention idle test ending.

Hmm I think the difference with the working v3.10 one is that you have
root=/dev/mmcblk0p2 instead of root=/dev/nfs. As the Ethernet on beagle
is on the USB EHCI, this is still blocking the deeper idle states AFAIK.

Care to test -rc7 with root=/dev/mmcblk0p2 to see if that works?

On the am37xx-evm nfsroot will work as it's on the GPMC bus.

Regards,

Tony
