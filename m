From: Kevin Hilman <khilman@ti.com>
Subject: Re: Suspend broken on 3.3?
Date: Fri, 06 Apr 2012 07:21:28 -0700
Message-ID: <87iphdeyaf.fsf@ti.com>
References: <WC20120329112755.541787@terrafix.co.uk>
	<WC20120329114024.43178C@terrafix.co.uk>
	<CAMrsUdKR4nwbBEOx9JPeS=GLDPyioHuijK2596=q2OwJ+ARbxA@mail.gmail.com>
	<WC20120330075339.4017FC@terrafix.co.uk>
	<CAMrsUdKTx84_oHyS9JTCBTqtV-7907snCGFDrOXnPuNVSnvz7w@mail.gmail.com>
	<WC20120330092609.901834@terrafix.co.uk>
	<CAMrsUdJrJZXjYOs87xmT_J0w7S=VZyfR0tBmhhuYOFmFsOB3SA@mail.gmail.com>
	<WC20120330110442.381887@terrafix.co.uk>
	<CAMrsUd+AvVp3n1oAREEEmCSBaeA-m68j7gLjXEeJKimX1erfUw@mail.gmail.com>
	<CAMrsUd+K_EwXfypgYWNyAhR7b47avTpWDemS87OTkpH81cJ6Aw@mail.gmail.com>
	<alpine.DEB.2.00.1204040852460.8000@utopia.booyaka.com>
	<CAMrsUd+WZcUvHGdR4WyF4uh35D17K9DXFAqpLHKBUbL1_5viDA@mail.gmail.com>
	<alpine.DEB.2.00.1204051812320.10302@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:34700 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753916Ab2DFOVa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Apr 2012 10:21:30 -0400
Received: by pbcup15 with SMTP id up15so3184718pbc.14
        for <linux-omap@vger.kernel.org>; Fri, 06 Apr 2012 07:21:29 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1204051812320.10302@utopia.booyaka.com> (Paul
	Walmsley's message of "Thu, 5 Apr 2012 18:29:42 -0600 (MDT)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Raja, Govindraj" <govindraj.raja@ti.com>, Joe Woodward <jw@terrafix.co.uk>, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, neilb@suse.de

Paul Walmsley <paul@pwsan.com> writes:

> On Wed, 4 Apr 2012, Raja, Govindraj wrote:
>
>> On Wed, Apr 4, 2012 at 8:26 PM, Paul Walmsley <paul@pwsan.com> wrote:
>> > On Mon, 2 Apr 2012, Raja, Govindraj wrote:
>> >
>> >> As of now what I can think of is to update qos reqest to prevent MPU
>> >> from transitioning in case of port activity if wakeup capability for port
>> >> is disabled.
>> >
>> > Haven't been following this thread closely, but this doesn't seem right.
>> > Why would changing the UART driver's ability to wake from suspend via the
>> > sysfs file prevent the driver from using hardware wakeups to wake from
>> > dynamic idle?
>> 
>> 
>> IIUC wakeup capability is needed in suspend path or in cpu idle path.
>> 
>> once uart wakeup capability is disabled from sysfs the Module level 
>> wakeup from PM_WKEN1 reg on omap3 and pad wakeup from pin mux data given 
>> will be disabled..
>
> As far as I know, that sysfs wakeup file is not meant to disable 
> all module-level wakeup.  Kevin can correct me if I'm wrong, but I think
> it's only supposed to control wakeup from suspend.

In theory, sysfs control is meant for static suspend.  ISTR though that
we were using it for idle as well so there weren't unncessary UART
wakeups from idle on UART activity that was not serial console.

Kevin


