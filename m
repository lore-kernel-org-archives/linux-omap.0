From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 02/12] ARM: OMAP3: Store reboot mode in scratchpad on
	OMAP34xx
Date: Mon, 16 Mar 2009 17:10:08 +0000
Message-ID: <20090316171008.GF31868@n2100.arm.linux.org.uk>
References: <20090310205824.16425.97745.stgit@localhost> <20090310210333.16425.80205.stgit@localhost> <20090315155105.GB10786@n2100.arm.linux.org.uk> <49BE792B.1090901@solidboot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:47609 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753709AbZCPRKc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Mar 2009 13:10:32 -0400
Content-Disposition: inline
In-Reply-To: <49BE792B.1090901@solidboot.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Juha Yrjola <juha.yrjola@solidboot.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.arm.linux.org.uk, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org

On Mon, Mar 16, 2009 at 06:07:07PM +0200, Juha Yrjola wrote:
> Russell King - ARM Linux wrote:
>>> The reboot mode can be communicated to a bootloader (or the
>>> kernel itself) with a scratchpad register. This functionality
>>> is especially useful, if userspace is allowed to change
>>> the reboot mode.
>>
>> The reason for this being...
>
> If my other patch [1] is applied, we are able to let user space tell the  
> bootloader which mode to boot to.
>
> On the Nokia Linux mobile devices, flashing is done mostly by the  
> bootloader. If a USB host is connected at bootup, we enter a USB loop  
> with a certain timeout. The timeout is disabled when the first flashing  
> command arrives. This is no problem for Linux, but some unluckier  
> operating systems are not able to even load their drivers quickly enough.
>
> Hence, we need a way to let the bootloader know when to safely disable  
> the timeout (when the user explicitly wants to perform flashing, that 
> is).

Right.  You are aware that there is already a mechanism for doing this
in the generic kernel (obviously not)?

sys_reboot() with LINUX_REBOOT_CMD_RESTART2 takes a string in addition
to the standard parameters.  This string is passed into machine_restart()
which we currently ignore.  If LINUX_REBOOT_CMD_RESTART is used, this
string is NULL.

We could change machine_restart() to pass this parameter through to
arm_pm_restart() and ultimately down to arch_reset().

That said, I don't see a version of reboot() which will pass a string
to the reboot() sysctl... there must be one around for the feature to
be present.
