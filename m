From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 02/12] ARM: OMAP3: Store reboot mode in scratchpad on
	OMAP34xx
Date: Mon, 16 Mar 2009 22:21:46 +0000
Message-ID: <20090316222146.GA8150@n2100.arm.linux.org.uk>
References: <20090310205824.16425.97745.stgit@localhost> <20090310210333.16425.80205.stgit@localhost> <20090315155105.GB10786@n2100.arm.linux.org.uk> <49BE792B.1090901@solidboot.com> <20090316171008.GF31868@n2100.arm.linux.org.uk> <49BE8F08.3000100@solidboot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42825 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752979AbZCPWWF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Mar 2009 18:22:05 -0400
Content-Disposition: inline
In-Reply-To: <49BE8F08.3000100@solidboot.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Juha Yrjola <juha.yrjola@solidboot.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.arm.linux.org.uk, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org

On Mon, Mar 16, 2009 at 07:40:24PM +0200, Juha Yrjola wrote:
> Russell King - ARM Linux wrote:
>
>> Right.  You are aware that there is already a mechanism for doing this
>> in the generic kernel (obviously not)?
>
> I am. Unfortunately, glibc fails to support this mechanism, as you say.  
> I didn't want to start making such intrusive changes for our trivial 
> need.

Yes, glibc sucks with that - they hide the Linux reboot syscall.
Luckily, it is accessible via the syscall() interface:

#include <linux/reboot.h>

int sys_reboot(const char *cmd)
{
	return syscall(SYS_reboot, LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2C,
			LINUX_REBOOT_CMD_RESTART2, cmd);
}

>> sys_reboot() with LINUX_REBOOT_CMD_RESTART2 takes a string in addition
>> to the standard parameters.  This string is passed into machine_restart()
>> which we currently ignore.  If LINUX_REBOOT_CMD_RESTART is used, this
>> string is NULL.
>>
>> We could change machine_restart() to pass this parameter through to
>> arm_pm_restart() and ultimately down to arch_reset().
>
> Sure. With RESTART2, I could've even used the reboot notifier chain with  
> an OMAP3-specific driver to store the string.

The notifier chain is called in any case.

> Are you suggesting to get rid of reboot_mode altogether? If not, could  
> we still have the sysfs mechanism? A one-character reboot_mode would be  
> plenty enough for us.

No, reboot mode tells _how_ to perform the reboot - whether that be
by hardware reset, gpio reset or a soft call via the reset address.
It's not supposed to tell the boot loader what to do.
