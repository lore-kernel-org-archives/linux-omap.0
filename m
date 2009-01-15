From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: new PM branch available
Date: Thu, 15 Jan 2009 21:30:47 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301BB98469B@dbde02.ent.ti.com>
References: <87iqoij2me.fsf@deeprootsystems.com>
 <8bf247760901140557t22298e6ch4e56675c03ef65f9@mail.gmail.com>
 <496E1546.4070309@deeprootsystems.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301BB9845FE@dbde02.ent.ti.com>
 <496F4FD5.2020006@deeprootsystems.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301BB98467D@dbde02.ent.ti.com>
 <496F579A.9000003@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49831 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753540AbZAOQBC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Jan 2009 11:01:02 -0500
In-Reply-To: <496F579A.9000003@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

<snip>--<snip>
> >>> Hi Kevin,
> >>>
> >>> I was able to test against the HEAD 'pm' branch on the EVM.
> >>> Here are my observations with default configuration:
> >>>
> >>> 1) CONFIG_DEBUG_LL=y is set by default. The kernel boots fine.
> >>>    I did not notice any 'garbage' problems you and Koen seem to
> >>>    be getting.
> >>>
> >>> 2) Same result when CONFIG_DEBUG_LL is deselcted.
> >> Sanjeev,
> >>
> >> Is this on an an ES3 EVM?  What boot loader revs are you using?
> > 
> > [sp] I am using EVM with ES3.0 while Vaibhav is using one with ES2.1
> 
> What are your x-loader and u-boot versions?  Mine are:
> 
> Texas Instruments X-Loader 1.41
> [...]
> U-Boot 1.1.4 (Jun  5 2008 - 17:53:37)
> 
> 
> >>> 3) With default config, suspend operation fails with this message:
> >>>    <3>omapfb omapfb: timeout waiting for FRAME DONE
> >> This is not a failure, just a warning from the fb driver.  
> >> This should not prevent retention.  I see this on beagle 
> as well, and 
> >> it doesn't prevent retention.
> >>
> >>  From the log below, you didn't copy the part which 
> reports whether 
> >> all domains hit target state.
> > 
> > [sp] This is where it hangs :(
> 
> It's not hung.  It's just sleeping, but refuses to wakeup 

[sp] True.

> (like I should've done this morning.)

[sp] me too!

> 
> What are you using as your wakeup source?  UART?  keypad?

[sp] I try using both (after a reboot).

Also tried the kernel image without FB driver. But observations don't change.

Checking further, with:
  # echo 1 > /sys/power/sleep_while_idle

Suspend / resume 'appear' to work fine with these warnings:
  Powerdomain (core_pwrdm) didn't enter target state 1
  Powerdomain (per_pwrdm) didn't enter target state 1

However, after:
  # echo 1 > /sys/power/clocks_off_while_idle

  Observation is same as mentioned in prev mail.

Best regards,
Sanjeev

> 
> I'm not sure how the UARTs are mux'd on this board, but you 
> probably want to check the wake-enable bits in the padconf 
> reg for the UART pins. 
>   This is done by arch/arm/mach-omap2/serial.c but assumes 
> the UARTs are mux'd using the default registers.  Each UART 
> has a couple possible ways to be mux'd.
> 
> > After sending the last mail, I tried the same without 
> enabling "clocks_off_while_idle" and "sleep_while_idle" then:
> > 
> > omapfb omapfb: timeout waiting for FRAME DONE Powerdomain 
> (core_pwrdm) 
> > didn't enter target state 1 Powerdomain (per_pwrdm) didn't enter 
> > target state 1 Could not enter target state in pm_suspend
> 
> 
> > I am building a config without FB. Will update as soon as I 
> can test it.
> > 
> >> Kevin
> >>
> >>> Here is a sample session from my terminal:
> >>>
> >>> [root@OMAP3EVM /]# uname -a
> >>> Linux OMAP3EVM 2.6.28-omap1-00115-g998bd56 #146 Thu Jan 
> 15 18:47:26 
> >>> IST 2009 armv7l unknown [root@OMAP3EVM /]# echo 1 > 
> >>> /sys/power/clocks_off_while_idle [root@OMAP3EVM /]# echo 1 > 
> >>> /sys/power/sleep_while_idle [root@OMAP3EVM /]#
> >> [root@OMAP3EVM /]# echo
> >>> mem > /sys/power/state
> >>> <6>PM: Syncing filesystems ... PM: Syncing filesystems ... done.
> >>> done.
> >>> Freezing user space processes ... Freezing user space
> >> processes ... (elapsed 0.00 seconds) (elapsed 0.00 seconds) done.
> >>> done.
> >>> Freezing remaining freezable tasks ... Freezing remaining
> >> freezable tasks ... (elapsed 0.06 seconds) (elapsed 0.06
> >> seconds) done.done.
> >>> Suspending console(s) (use no_console_suspend to debug) Suspending
> >>> console(s) (use no_console_suspend to debug)
> >>>
> >>> Best regards,
> >>> Sanjeev
> >>>
<snip>--<snip>