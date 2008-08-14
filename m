From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: Git tree updated to v2.6.26-rc3, all header files moved
Date: Thu, 14 Aug 2008 14:23:16 +0300
Message-ID: <20080814142316.e5c5dd10.jarkko.nikula@nokia.com>
References: <20080814101329.GA9226@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:24291 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752923AbYHNLXp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Aug 2008 07:23:45 -0400
In-Reply-To: <20080814101329.GA9226@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Thu, 14 Aug 2008 13:13:30 +0300
"ext Tony Lindgren" <tony@atomide.com> wrote:

> Hi all,
> 
> I've just pushed an update to v2.6.27-rc3, which moves all machine
> specific headers to arch/arm/plat-omap/include/mach/.
> 
> I've boot tested it on 2430sdp, 3430sdp, n810 and n770. Compile
> tested also on OSK and H2. Please check your boards still work,
> and patch as needed.
> 
Now N800 boots fine. It seems that this commit fixes the problem where
N800 was booting only with DEBUG_LL on:

"
commit c1955a3d4762e7a9bf84035eb3c4886a900f0d15
Author: Peter Zijlstra <a.p.zijlstra@chello.nl>
Date:   Mon Aug 11 08:59:03 2008 +0200

    sched_clock: delay using sched_clock()
    
    Some arch's can't handle sched_clock() being called too early -
delay this until sched_clock_init() has been called.
    
    Reported-by: Bill Gatliff <bgat@billgatliff.com>
    Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
    Tested-by: Nishanth Aravamudan <nacc@us.ibm.com>
    CC: Russell King - ARM Linux <linux@arm.linux.org.uk>
    Signed-off-by: Ingo Molnar <mingo@elte.hu>
"


Jarkko
