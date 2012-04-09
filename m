From: Paul Walmsley <paul@pwsan.com>
Subject: Re: Suspend broken on 3.3?
Date: Mon, 9 Apr 2012 10:01:24 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204090944191.6640@utopia.booyaka.com>
References: <WC20120329112755.541787@terrafix.co.uk> <WC20120329114024.43178C@terrafix.co.uk> <CAMrsUdKR4nwbBEOx9JPeS=GLDPyioHuijK2596=q2OwJ+ARbxA@mail.gmail.com> <WC20120330075339.4017FC@terrafix.co.uk> <CAMrsUdKTx84_oHyS9JTCBTqtV-7907snCGFDrOXnPuNVSnvz7w@mail.gmail.com>
 <WC20120330092609.901834@terrafix.co.uk> <CAMrsUdJrJZXjYOs87xmT_J0w7S=VZyfR0tBmhhuYOFmFsOB3SA@mail.gmail.com> <WC20120330110442.381887@terrafix.co.uk> <CAMrsUd+AvVp3n1oAREEEmCSBaeA-m68j7gLjXEeJKimX1erfUw@mail.gmail.com> <CAMrsUd+K_EwXfypgYWNyAhR7b47avTpWDemS87OTkpH81cJ6Aw@mail.gmail.com>
 <alpine.DEB.2.00.1204040852460.8000@utopia.booyaka.com> <CAMrsUd+WZcUvHGdR4WyF4uh35D17K9DXFAqpLHKBUbL1_5viDA@mail.gmail.com> <alpine.DEB.2.00.1204051812320.10302@utopia.booyaka.com> <87iphdeyaf.fsf@ti.com> <CAMrsUdLMYVwd3rupHtrNKC0rMvx1-3B=4usOh8cwTUy8DX_hVg@mail.gmail.com>
 <87zkalc75h.fsf@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <87zkalc75h.fsf@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Raja\\, Govindraj" <govindraj.raja@ti.com>, Joe Woodward <jw@terrafix.co.uk>, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, neilb@suse.de, linux-serial@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

cc linux-serial 

Hi

On Mon, 9 Apr 2012, Kevin Hilman wrote:

> Presumably, if a user disables UART wakeups, it means either 1) that
> UART is not used

#1 seems easy enough to handle without the use of power/wakeup.  If there 
are no users of the TTY, then the driver can simply not configure hardware 
wakeups.

> or 2) performance is not critical.

Can you think of a use-case for #2?

> IMO, we simply need to ensure that the defaults are correct.  When UARTs
> are initialized/enabled wakeups should be enabled by default.  The user
> can then override this if desired, and will obviously see a performance
> impact.  But that's what happens with wakeups disabled.

I don't understand why a user would ever want to disable dynamic wakeups 
on an in-use serial port via the sysfs power/wakeup file.  (Disabling 
wakeups from suspend is a different matter, of course.)  The OMAP UART 
driver needs hardware wakeups to function for FIFO drain wakeups, etc.  
So to me it really doesn't make sense to disable those types of wakeup 
events, ever.  But maybe you know of some use-case that I don't?

If the user just wants a transmit-only serial port, they could use the 
termios CREAD flag as Neil mentioned a few months ago, and the driver 
could disable wakeups on incoming RXD (modulo any active flow control of 
course).


- Paul
