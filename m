From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: cpuidle and NO_HZ
Date: Sat, 24 Jan 2009 00:36:17 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301C6EC7322@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301C6DD0347@dbde02.ent.ti.com>
	<8bf247760901220906n1ab095a0h695e9c1f5e8db916@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301C6DD03F9@dbde02.ent.ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301C6EC7222@dbde02.ent.ti.com>
	<8bf247760901230752h4835083foaa486311425c6c68@mail.gmail.com>
 <87ab9i6i9j.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39778 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752814AbZAWTG3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Jan 2009 14:06:29 -0500
In-Reply-To: <87ab9i6i9j.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, Sriram V <vshrirama@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Kevin Hilman
> Sent: Friday, January 23, 2009 11:02 PM
> To: Sriram V
> Cc: Premi, Sanjeev; linux-omap@vger.kernel.org
> Subject: Re: cpuidle and NO_HZ
> 
> Sriram V <vshrirama@gmail.com> writes:
> 
> > Sanjeev,
> > I am not really sure what the problem could be.
> > By enabling smc irq as wakeup resulted in faster nfs mounts 
> compared 
> > to before. however this does not happen everytime.
> > On enabling smc debug i can see interrupts happening all while.
> > for me ping stops after a while.
> >
> > Booting out a MMC card. I am unable to ping from the board. 
> i see rx 
> > overruns. However i can smc interrupts happening

[sp] Haven't tried booting from MMC so far

> >
> > For some reason this happens only when cpuidle is enabled.
> 

[sp] I notice it only when both cpuidle & dynamic tick are enabled.
BTW, what is the uboot version you are using?

> Are you allowing the chip to hit OFF (by 'echo 1 >
> /sys/power/enable_off_mode') or are you only hitting retention.
> 
> This is most likely a latency issue.  For starters, you could 
> modify the smc91x driver to register a latency requirement 
> with the OMAP PM layer.  This would prevent entering deeper 
> C-states which may have wakeup latencies that the smc91x 
> cannot handle.
> 

[sp] Once the kernel boots-up (thought very slow & late), powertop doesn't indicate any state transition from C0 despite enabling sleep_when_idle.

> Alternatively, you you do some experiments to see exactly 
> which C-states are causing the problems.  You could modify 
> cpuidle34xx.c and set the 'valid' flag in the higher C-states 
> to zero so that they cannot be entered and see which C-states 
> (if any) are working.
> 
> That being said, I'm not sure how this could be happening 
> during boot, since the UART clocks should be preventing 
> retention or off until you 'echo 1 > /sys/power/clocks_off_when_idle.'
> 
> Kevin
> 
> >
> >
> >
> >
> >
> >
> >  But, i also see
> >
> >
> > Regards,
> > sriram
> >
> >
> >
> >  as i said this could be something else.
> >
> > Regards,
> > sriram
> >
> >
> >
> >
> > On Fri, Jan 23, 2009 at 6:58 PM, Premi, Sanjeev 
> <premi@ti.com> wrote:
> >>> -----Original Message-----
> >>> From: linux-omap-owner@vger.kernel.org 
> >>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Premi, 
> >>> Sanjeev
> >>> Sent: Friday, January 23, 2009 12:02 AM
> >>> To: Sriram V
> >>> Cc: linux-omap@vger.kernel.org
> >>> Subject: RE: cpuidle and NO_HZ
> >>>
> >>> > -----Original Message-----
> >>> > From: Sriram V [mailto:vshrirama@gmail.com]
> >>> > Sent: Thursday, January 22, 2009 10:37 PM
> >>> > To: Premi, Sanjeev
> >>> > Cc: linux-omap@vger.kernel.org
> >>> > Subject: Re: cpuidle and NO_HZ
> >>> >
> >>> > Sanjeev,
> >>> >
> >>> > On Thu, Jan 22, 2009 at 8:14 PM, Premi, Sanjeev
> >>> <premi@ti.com> wrote:
> >>> > > Hi all,
> >>> > >
> >>> > > While trying to use NFS hosted filesystem, I have made a
> >>> > strange observation. Have verified it on multiple 
> OMAP3EVM boards.
> >>> > >
> >>> > > With CONFIG_NO_HZ and CONFIG_CPU_IDLE, after the print
> >>> > "Freeing init memory: 152K" in the log below; the boot
> >>> sequence almost
> >>> > stops for approx a minute before proceeding further.
> >>> > >
> >>> > >   Sending DHCP requests .<6>eth0: link up, 100Mbps,
> >>> > full-duplex, lpa 0x01E1
> >>> > >   ., OK
> >>> > >   IP-Config: Got DHCP answer from 0.0.0.0, my address is
> >>> 192.168.1.9
> >>> > >   IP-Config: Complete:
> >>> > >     device=eth0, addr=192.168.1.9, mask=255.255.255.0,
> >>> > gw=192.168.1.9,
> >>> > >     host=192.168.1.9, domain=india.ti.com, nis-domain=(none),
> >>> > >     bootserver=0.0.0.0, rootserver=192.168.1.2, rootpath=
> >>> > >   Looking up port of RPC 100003/2 on 192.168.1.2
> >>> > >   Looking up port of RPC 100005/1 on 192.168.1.2
> >>> > >   VFS: Mounted root (nfs filesystem).
> >>> > >   Freeing init memory: 152K
> >>> > >   init started: BusyBox v1.11.1 (2008-08-06 21:12:30 IST)
> >>> > >   starting pid 442, tty '': '/etc/init.d/rcS'
> >>> > >
> >>> >
> >>> > This seems to be a wakeup issue. SMC gpio irq needs to be
> >>> enabled as a
> >>> > wakeup source.
> >>> > I notice that sometimes even after enabling it as a 
> wakeup source 
> >>> > network interface has trouble. either it is too slow or it
> >>> just hangs
> >>> > during nfs mount or takes a long time to mount. this 
> issue could 
> >>> > be somewhere else
> >>> >
> >>> > I also notice that the whenever network interface hangs 
> during nfs 
> >>> > mount.
> >>> > the nfs server would have exited.
> >>>
> >>> [sp]Thanks. I will try the patch.
> >>>
> >>> I did believe it was a wakeup issue until I had not tried 
> the ping.
> >>> All pings were successful; indicating that eth interface 
> is still up.
> >>>
> >>> The 'mount' succeeding after about a minute is confirms 
> it as well.
> >>>
> >>> Best regards,
> >>> Sanjeev
> >>> >
> >>
> >> [sp] The patch did not help :( behavior is still the same
> >>
> >>> >
> >>> >
> >>> > Regards,
> >>> > sriram
> >>> >
> >>> >
> >>> >
> >>> >
> >>> >
> >>> >
> >>> >
> >>> > > Later, the system response is slow.
> >>> > >
> >>> > > Toggling either of these CONFIG options seems to resolve
> >>> the issue.
> >>> > >
> >>> > > My initial suspicion was on the SMC911x driver, but during
> >>> > this 'wait' period ping requests to the EVM are successful.
> >>> > >
> >>> > > Just wanted to check if anyone has seen this behavior.
> >>> > > (I am on Kevin's latest PM branch 998bd5675a1e...).
> >>> > >
> >>> > > Best regards,
> >>> > > Sanjeev
> >>> > > --
> >>> > > To unsubscribe from this list: send the line "unsubscribe
> >>> > linux-omap"
> >>> > > in the body of a message to majordomo@vger.kernel.org More
> >>> > majordomo
> >>> > > info at  http://vger.kernel.org/majordomo-info.html
> >>> > >
> >>> > --
> >>> To unsubscribe from this list: send the line "unsubscribe 
> >>> linux-omap" in the body of a message to majordomo@vger.kernel.org 
> >>> More majordomo info at http://vger.kernel.org/majordomo-info.html
> >>>
> >>>
> > --
> > To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" 
> > in the body of a message to majordomo@vger.kernel.org More 
> majordomo 
> > info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
> http://vger.kernel.org/majordomo-info.html
> 
> 