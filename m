From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH] OMAP3EVM:FIX: Reset the SMSC911x Ethernet controller in
 board_init
Date: Tue, 25 Jan 2011 10:14:16 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404BD7BE1A1@dbde02.ent.ti.com>
References: <hvaibhav@ti.com>
	<1295880108-15584-1-git-send-email-hvaibhav@ti.com>	<87oc769je4.fsf@ti.com>
	<19F8576C6E063C45BE387C64729E739404BD7BE119@dbde02.ent.ti.com>
 <87zkqq80ai.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52613 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752511Ab1AYEo2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Jan 2011 23:44:28 -0500
In-Reply-To: <87zkqq80ai.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Varadarajan, Charulatha" <charu@ti.com>, "tony@atomide.com" <tony@atomide.com>

> -----Original Message-----
> From: Hilman, Kevin
> Sent: Tuesday, January 25, 2011 2:52 AM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org; Varadarajan, Charulatha; tony@atomide.com
> Subject: Re: [PATCH] OMAP3EVM:FIX: Reset the SMSC911x Ethernet controller
> in board_init
> 
> "Hiremath, Vaibhav" <hvaibhav@ti.com> writes:
> 
> >> >
> >> > With addition of HWMOD support to GPIO, the Ethernet controller
> >> > goes undetected for OMAP35xEVM. So explicitely assert the reset
> signal
> >> to
> >> > Ethernet controller smsc911x -
> >> >
> >> > 	- GPIO7 (>=RevG version of EVM's)
> >> > 	- GPIO64 (<=RevD version of EVM's)
> >> >
> >> > I have tested this patch on RevG version of EVM with ES3.1 Si.
> >> > This patch is based on intial version from Charulatha V.
> >> >
> >> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> >>
> >> This didn't apply cleanly to l-o master, with or without your previous
> >> patches which touch the EVM board file.
> >>
> > [Hiremath, Vaibhav] may be order in which you apply the patches is
> different, but should have been trivial to fix, right?
> > I would suggest you to use newer version.
> 
> The order of applying doesn't matter.  Applying the original patch alone
> didn't apply, applying it after the other didn't apply.   V2 doesn't
> apply cleanly either.
> 
> Please be sure it applies cleanly to:
> 
> commit 5b698d68c1a9ebeae76a0e4ca4dbfdb10357143d
> Author: Thomas Weber <weber@corscience.de>
> Date:   Thu Jan 20 14:12:11 2011 +0000
> 
>     omap: omap-mcbsp: Fix building after replacement
> 
>     Fix building omap-mcbsp after replacing ARCH_OMAP24x0 in
>     commit 8a9c1aa6a4caa7db1c2fca4b47168af9077e0f95.
> 
> 
> If your series of EVM patches are interdependent, I suggest sending them
> as a series, so it's clear that they are dependent on each other.
> Also, please Cc linux-arm-kernel on OMAP patches intended for upstream.
> 
[Hiremath, Vaibhav] My head is pointing to same commit. But I think you are right, I should have made complete series of patches. Since these patches are functionally/logically not dependent on each other so I did not make it as a series.

Let me create series and send it again.

> This one (network GPIO) should be separated out though, and go into
> .38-rc (as well as -stable) since omap3evm is has not been bootable
> since 2.6.37.
> 
[Hiremath, Vaibhav] I agree.

> >> > ---
> >> > NOTE: I have not been able to test it on older version of EVM's.
> >>
> >> After manually applying,
> >>
> >> Tested-by: Kevin Hilman <khilman@ti.com>
> >>
> >> I tested on my rev D board with DHCP + nfs rootfs and it's working well.
> >>
> > [Hiremath, Vaibhav] Thanks a lot for validating it.
> >
> >> While testing though, I also noticed that the smsc driver is dumping
> >> some warnings (below) while trying to get the MAC address, resulting in
> >> not using the actual MAC but generating a random one.
> >>
> >> This isn't related to your patch, since it also happens with l-o master,
> >> but was wondering if you saw the same thing?
> >>
> > [Hiremath, Vaibhav] Yes I did see this message, and this is coming from
> >
> > #ifdef CONFIG_DEBUG_SPINLOCK
> > #define SMSC_ASSERT_MAC_LOCK(pdata) \
> >                 WARN_ON(!spin_is_locked(&pdata->mac_lock))
> >
> > And the root-cause is, in __init function we are calling
> smsc911x_read_mac_address->smsc911x_mac_read without holding mac_lock.
> >
> > I will submit the patch to net mailing list for this.
> 
> Thanks, please Cc linux-omap as well.
> 
[Hiremath, Vaibhav] Will do.

Thanks,
Vaibhav
> Kevin
