From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 00/29] Move OMAP2+ over to use COMMON clock
Date: Sun, 16 Sep 2012 20:36:54 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1209162033400.698@utopia.booyaka.com>
References: <1339678038-23082-1-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1209110403130.23042@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:49754 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752608Ab2IPUgz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 Sep 2012 16:36:55 -0400
In-Reply-To: <alpine.DEB.2.00.1209110403130.23042@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: mturquette@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, 11 Sep 2012, Paul Walmsley wrote:

> Then the branch was PM-tested to determine whether it can suspend and 
> serial-resume properly, and whether dynamic idle works.  These tests 
> didn't go so well:
> 
> - 3530ES3 Beagleboard here was able to enter retention-idle
>   suspend, and leave it with serial wakeup, but the CORE powerdomain never 
>   entered a low-power state.  Dynamic retention-idle with serial wakeup
>   never resumed, and the test stopped there:
> 
>   http://www.pwsan.com/omap/testlogs/common_clk_testing_devel_3.7/20120911000742/boot/3530es3beagle/3530es3beagle_log.txt
> 
> - 37xx EVM and 3730 Beagle XM fared better; they made it through the whole 
>   test program, but the CORE powerdomain also never entered a low-power
>   state:
> 
>   http://www.pwsan.com/omap/testlogs/common_clk_testing_devel_3.7/20120911000742/boot/37xxevm/37xxevm_log.txt
>   http://www.pwsan.com/omap/testlogs/common_clk_testing_devel_3.7/20120911000742/boot/3730beaglexm/3730beaglexm_log.txt

Thanks to debugging work by some TI LDC engineers, these two issues have 
been resolved.  Some clockdomain associations had been removed that were 
necessary for the OMAP power management code to function correctly.  The 
obvious ones have been restored to the clock data, and the branch updated.


- Paul
