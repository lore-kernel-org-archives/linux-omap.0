From: Paul Walmsley <paul@pwsan.com>
Subject: Re: Suspend broken on 3.3?
Date: Wed, 11 Apr 2012 13:34:06 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204111323210.29473@utopia.booyaka.com>
References: <WC20120329112755.541787@terrafix.co.uk> <CAMrsUdKTx84_oHyS9JTCBTqtV-7907snCGFDrOXnPuNVSnvz7w@mail.gmail.com> <WC20120330092609.901834@terrafix.co.uk> <CAMrsUdJrJZXjYOs87xmT_J0w7S=VZyfR0tBmhhuYOFmFsOB3SA@mail.gmail.com> <WC20120330110442.381887@terrafix.co.uk>
 <CAMrsUd+AvVp3n1oAREEEmCSBaeA-m68j7gLjXEeJKimX1erfUw@mail.gmail.com> <CAMrsUd+K_EwXfypgYWNyAhR7b47avTpWDemS87OTkpH81cJ6Aw@mail.gmail.com> <alpine.DEB.2.00.1204040852460.8000@utopia.booyaka.com> <CAMrsUd+WZcUvHGdR4WyF4uh35D17K9DXFAqpLHKBUbL1_5viDA@mail.gmail.com>
 <alpine.DEB.2.00.1204051812320.10302@utopia.booyaka.com> <87iphdeyaf.fsf@ti.com> <CAMrsUdLMYVwd3rupHtrNKC0rMvx1-3B=4usOh8cwTUy8DX_hVg@mail.gmail.com> <87zkalc75h.fsf@ti.com> <alpine.DEB.2.00.1204090944191.6640@utopia.booyaka.com> <874nssde5h.fsf@ti.com>
 <CAMrsUd+SLko-L=B9gfqSpdcYQrqmAgXa0yFVWrR2YXuW9FBLmQ@mail.gmail.com> <87fwcb5urr.fsf@ti.com> <CAMrsUd+-5_6dFxcj=BCt+gHwnzA7zBev0t_nQ3dQAGZzWq8X0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42968 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755215Ab2DKTeH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Apr 2012 15:34:07 -0400
In-Reply-To: <CAMrsUd+-5_6dFxcj=BCt+gHwnzA7zBev0t_nQ3dQAGZzWq8X0w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Raja, Govindraj" <govindraj.raja@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, Joe Woodward <jw@terrafix.co.uk>, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, neilb@suse.de, linux-serial@vger.kernel.org

Hi

a few brief comments based on a quick scan:

On Wed, 11 Apr 2012, Raja, Govindraj wrote:

> Here is the patch [1] to do the same.

- I don't see where it affects I/O wakeups for the UART.  If I/O wakeups 
are still set on the UART pads, won't that still wake the chip up from 
suspend, even if module-level wakeups are disabled?

- The UART driver and integration code should not be reading from or 
writing to registers outside the UART IP block.  PRM register reads and 
writes belong in the PRM code, which should then export a higher-level 
interface to the calling code.  This is because, aside from making the 
code easier to read and debug, we're trying to move the PRM and CM code to 
drivers/.

- The code to change the PM_WKEN* and test the PM_WKST* bits should 
probably be called from omap_hwmod_{enable,disable}_wakeup(), not the UART 
code directly.  The UART code shouldn't need to care about the hardware 
details; it should just ask the integration layer to enable or disable 
module-level wakeups.

As you work on these changes, please split them up into several different 
topic series - one for the PRM changes, one for hwmod code/data changes, 
and one for the UART driver/integration changes.  Just note the 
dependencies in the series description E-mails.  That way, we can avoid 
merge conflicts.


- Paul
