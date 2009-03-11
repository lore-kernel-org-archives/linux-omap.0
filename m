From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: Suspend/Resume support with Omap2fb
Date: Wed, 11 Mar 2009 16:17:44 +0530
Message-ID: <19F8576C6E063C45BE387C64729E73940427C51A3F@dbde02.ent.ti.com>
References: <1236763861.12797.29.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33346 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754563AbZCKKr7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Mar 2009 06:47:59 -0400
In-Reply-To: <1236763861.12797.29.camel@tubuntu>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



Thanks,
Vaibhav Hiremath

> -----Original Message-----
> From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> Sent: Wednesday, March 11, 2009 3:01 PM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org
> Subject: RE: Suspend/Resume support with Omap2fb
> 
> On Wed, 2009-03-11 at 09:46 +0100, ext Hiremath, Vaibhav wrote:
> >
> > Thanks,
> > Vaibhav Hiremath
> >
> > > -----Original Message-----
> > > From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> > > Sent: Wednesday, March 11, 2009 1:23 PM
> > > To: Hiremath, Vaibhav
> > > Cc: linux-omap@vger.kernel.org
> > > Subject: Re: Suspend/Resume support with Omap2fb
> > >
> > > Hi,
> > >
> > > On Wed, 2009-03-11 at 07:55 +0100, ext Hiremath, Vaibhav wrote:
> > > > Hi,
> > > >
> > > > I am using New Frame-Buffer driver which is based on DSS2
> library
> > > submitted by Tomi, and I am trying to add full power management
> > > support. But things are not working out as expected, every time
> when
> > > I am issuing command "echo mem > /sys/power/state" the system
> > > doesn't go into off state. It always points to dss_prwdm, below
> are
> > > the steps I am following -
> > >
> > > OFF mode should work. I have verified it with DSI, DPI and SDI.
> > > However,
> > > it needs passing the get_last_off_on_transaction_id pointer in
> > > omap_dss_platform_data.
> > >
> > > Also, see below.
> > >
> > [Hiremath, Vaibhav] I believe this is only required when you do
> save and restore context right?
> 
> Well, yes. But you need to save and restore context if you want OFF
> mode.
> 
[Hiremath, Vaibhav] As I mentioned I am hitting full OFF state (state5), and save and restore is happening perfectly fine.

> > Actually I have modified that part of code where it doesn't expect
> this pointer and save/restore happens perfectly fine, which I am
> very will sure about, since I am hitting state5 of CPU_IDLE (Full
> OFF state) and it resumes back with the same state.
> >
> > Again one more data point which I missed in last mail is, I am
> following clk->usecount which shows me 0. That means clocks are
> already disabled.
> >
> > root@arago:~# cat /sys/devices/platform/omap-dss/clk
> > - dss -
> > internal clk count      0
> > dss_ick         83000000        0
> > dss1_alwon_fck  96000000        0
> > dss2_alwon_fck  13000000        0
> > dss_tv_fck      54000000        0
> > dss_96m_fck     96000000        0
> > - dispc -
> > dispc fclk source = dss1_alwon_fclk
> > pixel clk = 96000000 / 1 / 5 = 19200000
> > root@arago:~#
> >
> >
> > > > 	- Build the kernel with CPU_IDLE
> > > > 	- Enable all the PM flags
> > > >
> > > > 		# echo 1 > /sys/power/sleep_while_idle
> > > > 		# echo 1 > /sys/power/clocks_off_while_idle
> > > > 		# echo 1 > /sys/power/enable_off_mode
> > > >
> > > >  	- From Linux prompt issue command
> > > >
> > > > 		# echo mem > /sys/power/state
> > > >
> > > > The log is -
> > > > ------------
> > > >
> > > > root@arago:~# echo mem > /sys/power/state
> > > > <6>PM: Syncing filesystems ... PM: Syncing filesystems ...
> done.
> > > > done.
> > > > Freezing user space processes ... Freezing user space
> processes
> > > ... (elapsed 0.00 seconds) (elapsed 0.00 seconds) done.
> > > > done.
> > > > Freezing remaining freezable tasks ... Freezing remaining
> > > freezable tasks ... (elapsed 0.06 seconds) (elapsed 0.06
> seconds)
> > > done.done.
> > > > Suspending console(s) (use no_console_suspend to debug)
> > > > Suspending console(s) (use no_console_suspend to debug)
> > > > <6>omap-backlight: suspending...
> > > > omapfb_suspend
> > > >
> > > > omapfb_resume
> > > > <6>omap-backlight: resuming...
> > > > omap-backlight: suspending...
> > > > omapfb_suspend
> > > > Powerdomain (core_pwrdm) didn't enter target state 0
> > > > Powerdomain (dss_pwrdm) didn't enter target state 0
> > > > Powerdomain (per_pwrdm) didn't enter target state 0
> > > > Could not enter target state in pm_suspend
> > > > eth0: link down
> > > > omapfb_resume
> > > > omap-backlight: resuming...
> > > > Restarting tasks ... Restarting tasks ... done.
> > > > done.
> > > >
> > > > root@arago:~#
> > > >
> > > >
> > > > Some analysis which I observed during debugging this issue -
> > > >
> > > > 	- The root-cause is, DSS PowerDomain always shows it is
> in ON
> > > state (PWRDM_POWER_ON), and if I understand correctly this is
> only
> > > dependent on clocks. But I am making sure that DSS clocks are
> > > disabled. And with CPU_IDLE enabled I am going to complete OFF
> > > state. (/sys/devices/system/cpu/cpu0/cpuidle/state5/usage is
> > > incrementing).
> > > >
> > > > 	- If I compile out framebuffer driver and include DSS2
> and
> > > V4L2 driver, everything works fine. I am not sure how "omapfb"
> is
> > > being tied with PowerDomain. Again I have seen references in
> > > arch/arm/mach-omap2/omapdev3xxx.h to the pdev_name = "omapfb",
> not
> > > sure how this is being used.
> > >
> > > You have to change it to omapdss (or omap-dss in earlier DSS2
> > > versions).
> > >
> > [Hiremath, Vaibhav] I have tried this option also, didn't work
> out.
> > Tomi,
> >
> > Do you have summary or list of changes required in clock and
> PowerDomain related files to make it work?
> >
> > How have you tested this?
> > Have you also tested with "echo mem > /sys/power/state"?
> > Are you using Kevin's power management tree? What is default
> configuration of your kernel during this test?
> 
> It's been some time since I tested it, but it did work on OMAP3 SDP
> with
> the pm-branch. Only changed needed were the
> get_last_off_on_transaction_id and omapfb -> omapdss. I also tested
> echo
> mem > ....
> 
> I'll try to find time to test it again with latest trees.
> 
[Hiremath, Vaibhav] That would be great, I am also trying few things here at my end. Hopefully I will get something.
>  Tomi
> 
> 

