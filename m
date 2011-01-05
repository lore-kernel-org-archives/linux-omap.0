From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: OMAP4 panda gets stuck during reboot
Date: Wed, 5 Jan 2011 19:52:34 +0530
Message-ID: <7f40d94c30aa807513e7cdbc097a5caf@mail.gmail.com>
References: <20110105140801.GC2304@legolas.emea.dhcp.ti.com>
 <45ff6d061a3e0bdcaf676671bf447b3b@mail.gmail.com> <20110105141814.GF2304@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:55744 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751146Ab1AEOWg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Jan 2011 09:22:36 -0500
Received: by mail-gy0-f173.google.com with SMTP id 5so6849821gye.32
        for <linux-omap@vger.kernel.org>; Wed, 05 Jan 2011 06:22:36 -0800 (PST)
In-Reply-To: <20110105141814.GF2304@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Felipe Balbi [mailto:balbi@ti.com]
> Sent: Wednesday, January 05, 2011 7:48 PM
> To: Santosh Shilimkar
> Cc: balbi@ti.com; Russell King; Tony Lindgren; Linux ARM Kernel
> Mailing List; Linux OMAP Mailing List
> Subject: Re: OMAP4 panda gets stuck during reboot
>
> Hi,
>
> On Wed, Jan 05, 2011 at 07:44:31PM +0530, Santosh Shilimkar wrote:
> > > What could it be ? Any more debugging I could do to help ?
> > >
> > This is known and seems to OMAP specific issue. Test patch and
>
> Doesn't look like omap-specific from patch description. Looks like
> like
> CPU1 is turned off and the instruction to flush PMD entry fails.
> Could
> it be that all ARM SMPs are affected ?
>
Thread is broken some how. There were more emails on this one...
Russell confirmed that he don't see the issue on his A9 Versatile
platform and no one else complained except OMAP.

Copy pasting some last updates..

------------------------------------------------
> -----Original Message-----
> From: Catalin Marinas [mailto:catalin.marinas@arm.com]
> Sent: Wednesday, November 10, 2010 7:35 PM
> To: Russell King - ARM Linux
> Cc: Shilimkar, Santosh; linux-arm-kernel@lists.infradead.org; Gadiyar,
> Anand
> Subject: Re: [PATCH] ARM: Temporary fix for broken arch reboot
>
> On Wed, 2010-11-10 at 10:06 +0000, Russell King - ARM Linux wrote:
> > On Wed, Nov 10, 2010 at 11:25:21AM +0530, Shilimkar, Santosh wrote:
> > > > -----Original Message-----
> > > > From: Catalin Marinas [mailto:catalin.marinas@arm.com]
> > > > Sent: Tuesday, November 09, 2010 10:08 PM
> > > > To: Russell King - ARM Linux
> > > > Cc: Shilimkar, Santosh; linux-arm-kernel@lists.infradead.org;
> Gadiyar,
> > > > Anand
> > > > Subject: Re: [PATCH] ARM: Temporary fix for broken arch reboot
> > > >
> > > > On Tue, 2010-11-09 at 13:18 +0000, Russell King - ARM Linux wrote:
> > > > > On Tue, Nov 09, 2010 at 06:40:39PM +0530, Shilimkar, Santosh
> wrote:
> > > > > > With commit 3d3f78d752bf, reboot seems to broken on ARM
> > > > > > machines. CPU dies while doing flush_pmd_entry() as part of
> > > > > > setup_mm_for_reboot()
> > > >
> > > > What do you mean by 'dies'? Can you still connect with a debugger
or
> it
> > > > got to some weird state?
> > > >
> > > It goes to some weird state. Basically the emulation connection
dies,
> > > and debugger gets disconnected.
> > >
> > > > > > I know this is not the fix but intention is to report the
> > > > > > issue and also provide temporary fix till it get fixed
correctly
> > > > >
> > > > > So you're now rebooting with the secondary CPUs still running.
I
> guess
> > > > > that the secondary CPUs end up crashing and don't restart.
> > > > >
> > > > > I think more the question is why the CP15 cache clean/flush is
> hanging
> > > > > with the other CPUs taken down.  All the other CPUs will be
doing
> is
> > > > > sitting in a loop doing nothing.
> > > >
> > > > I can't think of anything. Did the other CPUs print 'stopping'?
> > > No it doesn't not print anything.
> >
> > The processing of the IPI is asynchronous to the CPU which is
rebooting
> > continuing - which means that if there is some kind of bus lockup, you
> > won't get anything from any of the CPUs.
>
> The printing only happens for SYSTEM_BOOTING or SYSTEM_RUNNING. I
> suspect in this case we have SYSTEM_RESTARTING and the condition in
> ipi_cpu_stop() is false, therefore no printing. It may be worth putting
> some printks outside the 'if' to see whether the secondary CPUs get
> there.
>
While doing some experiments on this issue, one interesting
observation I made. Looks like there is race between two
Cores which makes system behave badly in reboot path.

Just adding a delay in the ipi_cpu_stop() makes the reboot work
as well

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 8c19595..f7dadbf 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -526,6 +526,8 @@ static void ipi_cpu_stop(unsigned int cpu)
                spin_unlock(&stop_lock);
        }

+       udelay(500);
+
        set_cpu_online(cpu, false);

        local_fiq_disable();

------------------------------------------------
