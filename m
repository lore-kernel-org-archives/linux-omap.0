From: Kevin Hilman <khilman@ti.com>
Subject: Re: Suspend broken on 3.3?
Date: Mon, 09 Apr 2012 10:10:50 -0700
Message-ID: <874nssde5h.fsf@ti.com>
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
	<87iphdeyaf.fsf@ti.com>
	<CAMrsUdLMYVwd3rupHtrNKC0rMvx1-3B=4usOh8cwTUy8DX_hVg@mail.gmail.com>
	<87zkalc75h.fsf@ti.com>
	<alpine.DEB.2.00.1204090944191.6640@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.00.1204090944191.6640@utopia.booyaka.com> (Paul
	Walmsley's message of "Mon, 9 Apr 2012 10:01:24 -0600 (MDT)")
Sender: linux-serial-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Raja, Govindraj" <govindraj.raja@ti.com>, Joe Woodward <jw@terrafix.co.uk>, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, neilb@suse.de, linux-serial@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Paul Walmsley <paul@pwsan.com> writes:

[...]

> I don't understand why a user would ever want to disable dynamic wakeups 
> on an in-use serial port via the sysfs power/wakeup file.  (Disabling 
> wakeups from suspend is a different matter, of course.)  The OMAP UART 
> driver needs hardware wakeups to function for FIFO drain wakeups, etc.  
> So to me it really doesn't make sense to disable those types of wakeup 
> events, ever.  But maybe you know of some use-case that I don't?

No, I don't have a use-case in mind.

The more I try to remember why we added support to use the sysfs wakeup
attribute to manage idle, the more I think we can probably drop it now.
IIRC, it was added because on most boards we used to blindly initialize
all the UARTs, including default wakeup settings (we still do this on
many boards.)  

However, now that we have a real PM-aware driver for OMAP UARTs, this
should all be handled from the driver itself, so the sysfs wakeup
attribute should go back to only managing wakeups from suspend and
wakeups during idle should always be on for in-use UARTs.

Kevin
