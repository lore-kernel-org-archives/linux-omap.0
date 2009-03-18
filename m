From: Nicholas Chen <nchen@cs.umd.edu>
Subject: Re: new PM branch available
Date: Wed, 18 Mar 2009 14:56:33 -0400
Message-ID: <794F9949-C366-41CE-BC4C-AB9AAA95FFD2@cs.umd.edu>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from server-nat-4.cs.umd.edu ([128.8.127.147]:1104 "EHLO
	bacon.cs.umd.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751670AbZCRTcz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Mar 2009 15:32:55 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org

Dear Kevin,

I recently checked out the latest PM branch from your git repository  
and put it on the Beagleboard (B5). I have been largely able to  
reproduce the results others have reported on this PM thread, but I  
believe my CORE and PER powerdomains are not hitting RET or OFF.

I think this based on the following:
after I
echo 1 > enable_off_mode
echo 1 > sleep_while_idle
echo mem > state

Suspending starts but upon resume I see the following:
...
Powerdomain (core_pwrdm) didn't enter target state 0
Powerdomain (per_pwrdm) didn't enter target state 0
Could not enter target state in pm_suspend

looking at debug/pm_debug/count/
I see that only the core_pwrdm and per_pwrdm have 0's next to OFF: and  
RET:

Based on the thread, the resolution seems  to be to disable USB and  
upgrade u-boot. I think I have done both. My u-boot is 2009.03-rc2  
from Steve Sakoman's tree, and I have disabled USB support in my  
Kernel build. Is there something that I am overlooking? Also, I'm  
curious if the two powerdomains linked (i.e. I need to fix PER before  
CORE will shut off or vice versa).

Nick

