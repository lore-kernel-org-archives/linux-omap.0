From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.16-rc4
Date: Tue, 29 Jul 2014 08:25:19 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1407290810160.22957@utopia.booyaka.com>
References: <alpine.DEB.2.02.1407062339420.15016@utopia.booyaka.com> <20140707080238.GF28884@atomide.com> <alpine.DEB.2.02.1407251857480.5875@utopia.booyaka.com> <20140729064243.GF29045@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:36828 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038AbaG2IZU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Jul 2014 04:25:20 -0400
In-Reply-To: <20140729064243.GF29045@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org

On Mon, 28 Jul 2014, Tony Lindgren wrote:

> Hmm I think the difference with the working v3.10 one is that you have
> root=/dev/mmcblk0p2 instead of root=/dev/nfs. As the Ethernet on beagle
> is on the USB EHCI, this is still blocking the deeper idle states AFAIK.

Hmm?  There's no Ethernet on the 3530 Beagle.

The hardware configuration on those two boards - the 37xxevm and 
the 3530es3beagle - hasn't changed between the two test runs, AFAIK.

Just to take the Beagle out of the equation, here's a test with the 
37xxevm on 3.11 where it passes the dynamic idle tests:

http://www.pwsan.com/omap/testlogs/test_v3.11/20130902150604/pm/37xxevm/37xxevm_log.txt

And here's one on the 37xxevm on 3.16-rc7 where it fails:

http://www.pwsan.com/omap/testlogs/test_v3.11/20130902150604/pm/37xxevm/37xxevm_log.txt

I should probably read back those writes to autosuspend_delay_ms, just to 
make sure they are reaching the right destinations.  But you might want to 
confirm that you can see the CORE RET count increasing during dynamic idle 
on your 37xxevm.


- Paul
