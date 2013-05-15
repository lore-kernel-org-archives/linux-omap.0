From: Yegor Yefremov <yegor_sub1@visionsystems.de>
Subject: Re: am3517: failed to boot 3.10-rc1
Date: Wed, 15 May 2013 10:37:16 +0200
Message-ID: <5193493C.8020301@visionsystems.de>
References: <519202DC.10100@visionsystems.de> <20130514125216.GE21107@arwen.pp.htv.fi> <519235C5.1010608@visionsystems.de>
Reply-To: yegor_sub1@visionsystems.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hhlx01.vscom.de ([62.145.30.242]:48708 "EHLO
	mail.visionsystems.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756602Ab3EOIha (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 May 2013 04:37:30 -0400
In-Reply-To: <519235C5.1010608@visionsystems.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Mark A. Greer" <mgreer@animalcreek.com>, Maxim Podbereznyy <lisarden@gmail.com>

On 14.05.2013 15:01, Yegor Yefremov wrote:
> On 14.05.2013 14:52, Felipe Balbi wrote:
>> On Tue, May 14, 2013 at 11:24:44AM +0200, Yegor Yefremov wrote:
>>> Trying to boot 3.10-rc1 on an am3515 based board. With the same
>>> .config as 3.7 the system comes to RTC stops there. I've also tried
>>> make omap2plus_defconfig with no visible difference. I'm booting from
>>> MMC card and it will be detected by the system. Kernel is from
>>> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git, latest
>>> commit f722406faae2d073cc1d01063d1123c35425939e. Are there any pending
>>> patches needed to boot on am3517?
>> does v3.9 work ? Can you bisect ?
> 
> 'git checkout v3.9' version is working, will try to bisect.

This is bisect's result:

f7b861b7a6d9d1838cbbb5f4053e61578b86d134 is the first bad commit
commit f7b861b7a6d9d1838cbbb5f4053e61578b86d134
Author: Thomas Gleixner <tglx@linutronix.de>
Date:   Thu Mar 21 22:49:38 2013 +0100

    arm: Use generic idle loop

    Use the generic idle loop and replace enable/disable_hlt with the
    respective core functions.

    Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
    Cc: Linus Torvalds <torvalds@linux-foundation.org>
    Cc: Rusty Russell <rusty@rustcorp.com.au>
    Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Reviewed-by: Cc: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
    Cc: Magnus Damm <magnus.damm@gmail.com>
    Cc: Russell King <linux@arm.linux.org.uk>
    Tested-by: Kevin Hilman <khilman@linaro.org> # OMAP
    Link: http://lkml.kernel.org/r/20130321215233.826238797@linutronix.de

:040000 040000 887517403888ff3947bce216aa4c1ff3ce3af434 8dc5236688a80fc64fa4112ce6136ecf3a19bac9 M      arch

Any idea?

Yegor
