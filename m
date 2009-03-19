From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 02/12] ARM: OMAP3: Store reboot mode in scratchpad on
	OMAP34xx
Date: Thu, 19 Mar 2009 08:56:44 -0700
Message-ID: <20090319155642.GI29546@atomide.com>
References: <20090310210333.16425.80205.stgit@localhost> <20090315155105.GB10786@n2100.arm.linux.org.uk> <49BE792B.1090901@solidboot.com> <20090316171008.GF31868@n2100.arm.linux.org.uk> <49BE8F08.3000100@solidboot.com> <20090316222146.GA8150@n2100.arm.linux.org.uk> <20090318182805.GA29546@atomide.com> <20090318192626.GC30132@n2100.arm.linux.org.uk> <20090318201003.GB29546@atomide.com> <20090319000833.GE30132@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:52174 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282AbZCSP4r (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Mar 2009 11:56:47 -0400
Content-Disposition: inline
In-Reply-To: <20090319000833.GE30132@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Juha Yrjola <juha.yrjola@solidboot.com>, linux-arm-kernel@lists.arm.linux.org.uk, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [090318 17:08]:
> On Wed, Mar 18, 2009 at 01:10:04PM -0700, Tony Lindgren wrote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [090318 12:26]:
> > > On Wed, Mar 18, 2009 at 11:28:06AM -0700, Tony Lindgren wrote:
> > > > * Russell King - ARM Linux <linux@arm.linux.org.uk> [090316 15:22]:
> > > > > On Mon, Mar 16, 2009 at 07:40:24PM +0200, Juha Yrjola wrote:
> > > > > > Russell King - ARM Linux wrote:
> > > > > >
> > > > > >> Right.  You are aware that there is already a mechanism for doing this
> > > > > >> in the generic kernel (obviously not)?
> > > > > >
> > > > > > I am. Unfortunately, glibc fails to support this mechanism, as you say.  
> > > > > > I didn't want to start making such intrusive changes for our trivial 
> > > > > > need.
> > > > > 
> > > > > Yes, glibc sucks with that - they hide the Linux reboot syscall.
> > > > > Luckily, it is accessible via the syscall() interface:
> > > > > 
> > > > > #include <linux/reboot.h>
> > > > > 
> > > > > int sys_reboot(const char *cmd)
> > > > > {
> > > > > 	return syscall(SYS_reboot, LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2C,
> > > > > 			LINUX_REBOOT_CMD_RESTART2, cmd);
> > > > > }
> > > > > 
> > > > > >> sys_reboot() with LINUX_REBOOT_CMD_RESTART2 takes a string in addition
> > > > > >> to the standard parameters.  This string is passed into machine_restart()
> > > > > >> which we currently ignore.  If LINUX_REBOOT_CMD_RESTART is used, this
> > > > > >> string is NULL.
> > > > > >>
> > > > > >> We could change machine_restart() to pass this parameter through to
> > > > > >> arm_pm_restart() and ultimately down to arch_reset().
> > > > > >
> > > > > > Sure. With RESTART2, I could've even used the reboot notifier chain with  
> > > > > > an OMAP3-specific driver to store the string.
> > > > > 
> > > > > The notifier chain is called in any case.
> > > > > 
> > > > > > Are you suggesting to get rid of reboot_mode altogether? If not, could  
> > > > > > we still have the sysfs mechanism? A one-character reboot_mode would be  
> > > > > > plenty enough for us.
> > > > > 
> > > > > No, reboot mode tells _how_ to perform the reboot - whether that be
> > > > > by hardware reset, gpio reset or a soft call via the reset address.
> > > > > It's not supposed to tell the boot loader what to do.
> > > > 
> > > > So if the reboot mode can't be used for this.. Should we change Juha's
> > > > sysfs interface patch to store something else like bootloader_mode?
> > > > 
> > > > I guess we cannot use kexec for this either?
> > > 
> > > Why not use the mechanism that's already there as I've already pointed
> > > out?
> > 
> > Sorry I misunderstood, I thought you did not want to use reboot_mode
> > for this at all..
> 
> I don't want to use reboot_mode for this.  machine_restart() and the
> reboot syscall has a way of passing a string to the platform specific
> code, and I'm suggesting that if you want the boot loader to do some
> magic, that's the way to do it.  Use the 'cmd' argument provided to
> arch_reset() by the patch below - this will either be NULL if the
> standard reboot call is used, or a string if the alternative version
> is used.
> 
> > To recap, so we change machine_restart() like you described above, and then
> > this patch is still valid, except to update the description.
> 
> No, you've still got the wrong end of the stick.

<snip>

> diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
> index 811be55..0a0d49a 100644
> --- a/arch/arm/include/asm/system.h
> +++ b/arch/arm/include/asm/system.h
> @@ -97,8 +97,8 @@ extern void __show_regs(struct pt_regs *);
>  extern int cpu_architecture(void);
>  extern void cpu_init(void);
>  
> -void arm_machine_restart(char mode);
> -extern void (*arm_pm_restart)(char str);
> +void arm_machine_restart(char mode, const char *cmd);
> +extern void (*arm_pm_restart)(char str, const char *cmd);
>  
>  #define UDBG_UNDEFINED	(1 << 0)
>  #define UDBG_SYSCALL	(1 << 1)
> diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
> index af377c7..2de14e2 100644
> --- a/arch/arm/kernel/process.c
> +++ b/arch/arm/kernel/process.c
> @@ -83,7 +83,7 @@ static int __init hlt_setup(char *__unused)
>  __setup("nohlt", nohlt_setup);
>  __setup("hlt", hlt_setup);
>  
> -void arm_machine_restart(char mode)
> +void arm_machine_restart(char mode, const char *cmd)
>  {
>  	/*
>  	 * Clean and disable cache, and turn off interrupts
> @@ -100,7 +100,7 @@ void arm_machine_restart(char mode)
>  	/*
>  	 * Now call the architecture specific reboot code.
>  	 */
> -	arch_reset(mode);
> +	arch_reset(mode, cmd);
>  
>  	/*
>  	 * Whoops - the architecture was unable to reboot.
> @@ -120,7 +120,7 @@ EXPORT_SYMBOL(pm_idle);
>  void (*pm_power_off)(void);
>  EXPORT_SYMBOL(pm_power_off);
>  
> -void (*arm_pm_restart)(char str) = arm_machine_restart;
> +void (*arm_pm_restart)(char str, const char *cmd) = arm_machine_restart;
>  EXPORT_SYMBOL_GPL(arm_pm_restart);
>  
>  
> @@ -195,9 +195,9 @@ void machine_power_off(void)
>  		pm_power_off();
>  }
>  
> -void machine_restart(char * __unused)
> +void machine_restart(char *cmd)
>  {
> -	arm_pm_restart(reboot_mode);
> +	arm_pm_restart(reboot_mode, cmd);
>  }
>  
>  void __show_regs(struct pt_regs *regs)

<snip>

Got it now, looks good to me.

Acked-by: Tony Lindgren <tony@atomide.com>
