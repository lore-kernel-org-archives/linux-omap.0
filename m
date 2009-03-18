From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 02/12] ARM: OMAP3: Store reboot mode in scratchpad on
	OMAP34xx
Date: Wed, 18 Mar 2009 13:10:04 -0700
Message-ID: <20090318201003.GB29546@atomide.com>
References: <20090310205824.16425.97745.stgit@localhost> <20090310210333.16425.80205.stgit@localhost> <20090315155105.GB10786@n2100.arm.linux.org.uk> <49BE792B.1090901@solidboot.com> <20090316171008.GF31868@n2100.arm.linux.org.uk> <49BE8F08.3000100@solidboot.com> <20090316222146.GA8150@n2100.arm.linux.org.uk> <20090318182805.GA29546@atomide.com> <20090318192626.GC30132@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:65150 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753958AbZCRUKK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Mar 2009 16:10:10 -0400
Content-Disposition: inline
In-Reply-To: <20090318192626.GC30132@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Juha Yrjola <juha.yrjola@solidboot.com>, linux-arm-kernel@lists.arm.linux.org.uk, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [090318 12:26]:
> On Wed, Mar 18, 2009 at 11:28:06AM -0700, Tony Lindgren wrote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [090316 15:22]:
> > > On Mon, Mar 16, 2009 at 07:40:24PM +0200, Juha Yrjola wrote:
> > > > Russell King - ARM Linux wrote:
> > > >
> > > >> Right.  You are aware that there is already a mechanism for doing this
> > > >> in the generic kernel (obviously not)?
> > > >
> > > > I am. Unfortunately, glibc fails to support this mechanism, as you say.  
> > > > I didn't want to start making such intrusive changes for our trivial 
> > > > need.
> > > 
> > > Yes, glibc sucks with that - they hide the Linux reboot syscall.
> > > Luckily, it is accessible via the syscall() interface:
> > > 
> > > #include <linux/reboot.h>
> > > 
> > > int sys_reboot(const char *cmd)
> > > {
> > > 	return syscall(SYS_reboot, LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2C,
> > > 			LINUX_REBOOT_CMD_RESTART2, cmd);
> > > }
> > > 
> > > >> sys_reboot() with LINUX_REBOOT_CMD_RESTART2 takes a string in addition
> > > >> to the standard parameters.  This string is passed into machine_restart()
> > > >> which we currently ignore.  If LINUX_REBOOT_CMD_RESTART is used, this
> > > >> string is NULL.
> > > >>
> > > >> We could change machine_restart() to pass this parameter through to
> > > >> arm_pm_restart() and ultimately down to arch_reset().
> > > >
> > > > Sure. With RESTART2, I could've even used the reboot notifier chain with  
> > > > an OMAP3-specific driver to store the string.
> > > 
> > > The notifier chain is called in any case.
> > > 
> > > > Are you suggesting to get rid of reboot_mode altogether? If not, could  
> > > > we still have the sysfs mechanism? A one-character reboot_mode would be  
> > > > plenty enough for us.
> > > 
> > > No, reboot mode tells _how_ to perform the reboot - whether that be
> > > by hardware reset, gpio reset or a soft call via the reset address.
> > > It's not supposed to tell the boot loader what to do.
> > 
> > So if the reboot mode can't be used for this.. Should we change Juha's
> > sysfs interface patch to store something else like bootloader_mode?
> > 
> > I guess we cannot use kexec for this either?
> 
> Why not use the mechanism that's already there as I've already pointed
> out?

Sorry I misunderstood, I thought you did not want to use reboot_mode
for this at all..

To recap, so we change machine_restart() like you described above, and then
this patch is still valid, except to update the description.

Juha, does that sound OK to you?

> Yes, glibc might be fscked in the head over the reboot() prototype but
> that's easy to work-around as I've demonstrated.

Yeah sounds good to me.

Tony
