From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/8] ARM: OMAP2+: hwmod: Cleanup sidle/mstandby
 programming
Date: Sun, 31 Mar 2013 01:30:54 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1303310053351.6436@utopia.booyaka.com>
References: <1361354272-18089-1-git-send-email-santosh.shilimkar@ti.com> <1361354272-18089-3-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:35827 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755296Ab3CaBaz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 30 Mar 2013 21:30:55 -0400
In-Reply-To: <1361354272-18089-3-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rnayak@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux@arm.linux.org.uk, khilman@deeprootsystems.com, tony@atomide.com, sourav.poddar@ti.com, vaibhav.bedia@ti.com, linux-arm-kernel@lists.infradead.org

Hi

On Wed, 20 Feb 2013, Santosh Shilimkar wrote:

> From: Rajendra Nayak <rnayak@ti.com>
> 
> _enable_wakeup() and _disable_wakeup() are expected to program the
> OCP_SYSCONFIG.ENAWAKEUP bit.

These functions were originally intended to take care of everything needed 
for the IP block to wake up the chip, including the PRCM WKEN programming.  
ENAWAKEUP is simply one part of that.

> Get rid of the additional sidle/mstandby programming in them, as its 
> confusing (this is expected to be handled elsewhere as part of 
> _enable_sysc()/__idle_sysc())

Sorry, why does the expectation exist for the code to enable and disable 
device wakeup to be part of _enable_sysc()/_idle_sysc(), rather than in 
functions called by _enable_sysc()/_idle_sysc()?

> and unnecessary.

So here's part of the reason why the module wakeup control functions 
should remain separate.  When the kernel boots, all the PM features should 
be disabled.  Then mach-omap2/pm*.c should enables PM features where 
they're needed.

Right now, mach-omap2/pm34xx.c sets module WKEN bits.  (These direct 
register accesses need to be moved as part of the cleanup work, of moving 
the PM/PRM/CM code into drivers.)  But the list of IP blocks that 
should be allowed to wake the system is board-dependent.

So really, what mach-omap2/pm34xx.c should do is to call into the hwmod 
enable-wakeups code to enable MPU wakeups for all the IP blocks that have 
some DT property set, something like 'enable-wakeups'.  Then the hwmod 
code should ensure that the PRM wakeup-enable and GRPSEL bits are 
programmed (by calling into the PRM driver code) and should then either 
set the ENAWAKEUP bits or put the module into smart_wkup MSTANDBY/MIDLE.

Similarly, when the PM driver is unloaded, it should set no-idle on all 
the IP blocks that were marked as wakeup-capable and disable the PRCM 
wakeup control bits, by calling some hwmod disable-wakeups code.

> Well, the _enable_sysc()/_idle_sysc() handled only the mstandby modes
> correctly. So fix them so they also handle the midle modes correctly

If there's a fix here, please split that out into a separate patch.


- Paul
