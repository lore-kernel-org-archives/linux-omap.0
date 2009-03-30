From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: PM branch rebased to 2.6.29
Date: Mon, 30 Mar 2009 15:38:48 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301CC5699A0@dbde02.ent.ti.com>
References: <87bprz9zju.fsf@deeprootsystems.com>
	 <1237914611.23022.124.camel@blackhole>
	 <87zlfaztcd.fsf@deeprootsystems.com>
	 <1237925484.23022.133.camel@blackhole>
	 <49C940CA.9070805@deeprootsystems.com>
 <f9d2a5e10903271350x2d534c76nc55c492b8acd1d4e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39832 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755137AbZC3KJG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Mar 2009 06:09:06 -0400
In-Reply-To: <f9d2a5e10903271350x2d534c76nc55c492b8acd1d4e@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <russ.dill@gmail.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: Peter Barada <peterb@logicpd.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org=20
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Russ Dill
> Sent: Saturday, March 28, 2009 2:21 AM
> To: Kevin Hilman
> Cc: Peter Barada; linux-omap@vger.kernel.org
> Subject: Re: PM branch rebased to 2.6.29
>=20
> On Tue, Mar 24, 2009 at 1:21 PM, Kevin Hilman
> <khilman@deeprootsystems.com> wrote:
> > Peter Barada wrote:
> >>
> >> On Tue, 2009-03-24 at 11:08 -0700, Kevin Hilman wrote:
> >>>
> >>> Peter Barada <peterb@logicpd.com> writes:
> >>>
> >>>> On Tue, 2009-03-17 at 22:21 -0700, Kevin Hilman wrote:
> >>>>>
> >>>>> FYI...
> >>>>> The PM branch has now been rebased to today's=20
> linux-omap HEAD which is
> >>>>> based on v2.6.29-rc8. =A0The previous PM branch has been=20
> renamed to
> >>>>> pm-2.6.28. =A0Depending on when you look, Tony's=20
> linux-omap tree may not
> >>>>> (yet) have the latest PM branch. =A0If not, you can use=20
> my PM tree[1]
> >>>>> directly. =A0Also, pm-2.6.28 will only be available on my tree.
> >>>>>
> >>>>> Tested on OMAP3 Beagle and RX51 and was able to hit RET=20
> and OFF in
> >>>>> suspend and in PM idle with minimal kernel. =A0No testing=20
> yet done for
> >>>>> CPUidle or DVFS. =A0Please test on your hardware and=20
> submit results to
> >>>>> the list. =A0Thanks.
> >>>>
> >>>> Kevin, =A0did you build/test with
> >>>> the /arc/arm/config/omap3_beagle_defconfig, and
> >>>> arc/arm/configs/rx51_defconfig or some other=20
> config(could you send it to
> >>>> me if it isn't in the PM tree)?
> >>>
> >>> I started with the ones in the tree, but I disable most=20
> of the drivers
> >>> and turn on some debugging features. =A0Attached is the one=20
> I used for
> >>> beagle.
> >>> [...]
> >>
> >> Hmm, I modified your config to add smc911x support so I can have a=
n
> >> nfsroot, added selector/code for my board(based on=20
> omap3beagle.c) and
> >> brought it up on my hardware, but I'm not sure if its=20
> working correctly.
> >> It does look to pause in the suspend sate, and comes out=20
> when I hit a
> >> key on the console, but the messages don't look quite right as
> >> core_pwrdm and per_pwrdm state they didn't go into state 1=20
> (full log
> >> attached):
> >>
> >> omap3530# echo mem > /sys/power/state
> >> PM: Syncing filesystems ... done.
> >> PM: Preparing system for mem sleep
> >> Freezing user space processes ... (elapsed 0.00 seconds) done.
> >> Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done=
=2E
> >> PM: Entering mem sleep
> >> Powerdomain (core_pwrdm) didn't enter target state 1
> >> Powerdomain (per_pwrdm) didn't enter target state 1
> >> Could not enter target state in pm_suspend
> >> eth0: smc911x_reset timeout waiting for PM restore
> >>
> >> eth0: link down
> >> PM: Finishing wakeup.
> >> Restarting tasks ... done.
> >> omap3530# omap3530# eth0: link up, 100Mbps, full-duplex, lpa 0x45E=
1
> >>
> >>
> >> Is this expected?
> >>
> >
> > Yes, you haven't allowed the UART clocks to go off during=20
> idle/suspend and
> > there are UARTs in both CORE and PER.
> >
> > Try this before going into suspend:
> >
> > =A0echo 1 > /sys/power/clocks_off_while_idle
> >
> > This will allow UART clocks to be disabled on suspend, and=20
> also allow them
> > to be disabled after 5 seconds of UART inactivity allowing=20
> retention in idle
> > as well.
> >

I had found that two drivers that could prevent clocks_off are
USB and DSS because of the way they use clk_enable().

Can you try building without theses drivers just for verification?

Best regards,
Sanjeev
>=20
> I'm having the same problem, and setting clocks_off_while_idle doesn'=
t
> help. I was initially suspicious that the bits in PM_WKEN1_CORE and
> PM_WKEN3_CORE needed to be cleared (for core), but using devmem2 to
> clear them didn't help.
>=20
> For the purposes that I'm using my board for, I need to get everythin=
g
> into the lowest power consumption possible while sleeping. eg,
> everything in off mode but the WKUP domain.
> --
> To unsubscribe from this list: send the line "unsubscribe=20
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
> --
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
