From: Paul Walmsley <paul@pwsan.com>
Subject: Re: Suspend broken on 3.3?
Date: Thu, 5 Apr 2012 18:29:42 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204051812320.10302@utopia.booyaka.com>
References: <WC20120329112755.541787@terrafix.co.uk> <WC20120329114024.43178C@terrafix.co.uk> <CAMrsUdKR4nwbBEOx9JPeS=GLDPyioHuijK2596=q2OwJ+ARbxA@mail.gmail.com> <WC20120330075339.4017FC@terrafix.co.uk> <CAMrsUdKTx84_oHyS9JTCBTqtV-7907snCGFDrOXnPuNVSnvz7w@mail.gmail.com>
 <WC20120330092609.901834@terrafix.co.uk> <CAMrsUdJrJZXjYOs87xmT_J0w7S=VZyfR0tBmhhuYOFmFsOB3SA@mail.gmail.com> <WC20120330110442.381887@terrafix.co.uk> <CAMrsUd+AvVp3n1oAREEEmCSBaeA-m68j7gLjXEeJKimX1erfUw@mail.gmail.com> <CAMrsUd+K_EwXfypgYWNyAhR7b47avTpWDemS87OTkpH81cJ6Aw@mail.gmail.com>
 <alpine.DEB.2.00.1204040852460.8000@utopia.booyaka.com> <CAMrsUd+WZcUvHGdR4WyF4uh35D17K9DXFAqpLHKBUbL1_5viDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45355 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753203Ab2DFA3n (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Apr 2012 20:29:43 -0400
In-Reply-To: <CAMrsUd+WZcUvHGdR4WyF4uh35D17K9DXFAqpLHKBUbL1_5viDA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Raja, Govindraj" <govindraj.raja@ti.com>, Kevin Hilman <khilman@ti.com>
Cc: Joe Woodward <jw@terrafix.co.uk>, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, neilb@suse.de

On Wed, 4 Apr 2012, Raja, Govindraj wrote:

> On Wed, Apr 4, 2012 at 8:26 PM, Paul Walmsley <paul@pwsan.com> wrote:
> > On Mon, 2 Apr 2012, Raja, Govindraj wrote:
> >
> >> As of now what I can think of is to update qos reqest to prevent MPU
> >> from transitioning in case of port activity if wakeup capability for port
> >> is disabled.
> >
> > Haven't been following this thread closely, but this doesn't seem right.
> > Why would changing the UART driver's ability to wake from suspend via the
> > sysfs file prevent the driver from using hardware wakeups to wake from
> > dynamic idle?
> 
> 
> IIUC wakeup capability is needed in suspend path or in cpu idle path.
> 
> once uart wakeup capability is disabled from sysfs the Module level 
> wakeup from PM_WKEN1 reg on omap3 and pad wakeup from pin mux data given 
> will be disabled..

As far as I know, that sysfs wakeup file is not meant to disable 
all module-level wakeup.  Kevin can correct me if I'm wrong, but I think
it's only supposed to control wakeup from suspend.

So in my opinion, that sysfs file should not affect dynamic 
module-level, or I/O ring wakeup at all.  If it is intended to affect 
dynamic idle wakeup, then we also will need code to prevent the UART from 
disabling its clocks when the sysfs wakeup file is set to disabled.

> So after we enter suspend and wakeup from suspend using keypad press,
> now through pm workqueue the MPU enters retention and uart module level
> wakeups disabled at this point console becomes slower to respond.
> 
> Now enabling wakeups from sysfs enter suspend/resume to enable wakeups
> and once we come back from wakeup console response is better.
> 
> So disabling uart module level wake up and allowing MPU to enter retention
> is making console slow.


- Paul
