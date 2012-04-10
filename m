From: "Raja, Govindraj" <govindraj.raja@ti.com>
Subject: Re: Suspend broken on 3.3?
Date: Tue, 10 Apr 2012 14:56:56 +0530
Message-ID: <CAMrsUd+SLko-L=B9gfqSpdcYQrqmAgXa0yFVWrR2YXuW9FBLmQ@mail.gmail.com>
References: <WC20120329112755.541787@terrafix.co.uk> <WC20120329114024.43178C@terrafix.co.uk>
 <CAMrsUdKR4nwbBEOx9JPeS=GLDPyioHuijK2596=q2OwJ+ARbxA@mail.gmail.com>
 <WC20120330075339.4017FC@terrafix.co.uk> <CAMrsUdKTx84_oHyS9JTCBTqtV-7907snCGFDrOXnPuNVSnvz7w@mail.gmail.com>
 <WC20120330092609.901834@terrafix.co.uk> <CAMrsUdJrJZXjYOs87xmT_J0w7S=VZyfR0tBmhhuYOFmFsOB3SA@mail.gmail.com>
 <WC20120330110442.381887@terrafix.co.uk> <CAMrsUd+AvVp3n1oAREEEmCSBaeA-m68j7gLjXEeJKimX1erfUw@mail.gmail.com>
 <CAMrsUd+K_EwXfypgYWNyAhR7b47avTpWDemS87OTkpH81cJ6Aw@mail.gmail.com>
 <alpine.DEB.2.00.1204040852460.8000@utopia.booyaka.com> <CAMrsUd+WZcUvHGdR4WyF4uh35D17K9DXFAqpLHKBUbL1_5viDA@mail.gmail.com>
 <alpine.DEB.2.00.1204051812320.10302@utopia.booyaka.com> <87iphdeyaf.fsf@ti.com>
 <CAMrsUdLMYVwd3rupHtrNKC0rMvx1-3B=4usOh8cwTUy8DX_hVg@mail.gmail.com>
 <87zkalc75h.fsf@ti.com> <alpine.DEB.2.00.1204090944191.6640@utopia.booyaka.com>
 <874nssde5h.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog136.obsmtp.com ([74.125.149.85]:38647 "EHLO
	psmtp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754341Ab2DJJ1R convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Apr 2012 05:27:17 -0400
Received: by obbef5 with SMTP id ef5so7091309obb.38
        for <linux-omap@vger.kernel.org>; Tue, 10 Apr 2012 02:27:16 -0700 (PDT)
In-Reply-To: <874nssde5h.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Joe Woodward <jw@terrafix.co.uk>, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, neilb@suse.de, linux-serial@vger.kernel.org

Hi Kevin,

On Mon, Apr 9, 2012 at 10:40 PM, Kevin Hilman <khilman@ti.com> wrote:
> Paul Walmsley <paul@pwsan.com> writes:
>
> [...]
>
>> I don't understand why a user would ever want to disable dynamic wak=
eups
>> on an in-use serial port via the sysfs power/wakeup file. =A0(Disabl=
ing
>> wakeups from suspend is a different matter, of course.) =A0The OMAP =
UART
>> driver needs hardware wakeups to function for FIFO drain wakeups, et=
c.
>> So to me it really doesn't make sense to disable those types of wake=
up
>> events, ever. =A0But maybe you know of some use-case that I don't?
>
> No, I don't have a use-case in mind.
>
> The more I try to remember why we added support to use the sysfs wake=
up
> attribute to manage idle, the more I think we can probably drop it no=
w.
> IIRC, it was added because on most boards we used to blindly initiali=
ze
> all the UARTs, including default wakeup settings (we still do this on
> many boards.)
>
> However, now that we have a real PM-aware driver for OMAP UARTs, this
> should all be handled from the driver itself, so the sysfs wakeup
> attribute should go back to only managing wakeups from suspend and
> wakeups during idle should always be on for in-use UARTs.

Just to summarize on how the behavior should be IIUC if user disables u=
art
wakeup from sysfs and does system wide suspend it should _not_ wakeup
from uart.

And if the system is woken up from suspend due to keypad press and
uart resumes we have keep module level wakeup enabled from here.

We might need some minor changes in omap-serial to have this behavior
which I plan to do once we are aligned on this.

--
Thanks,
Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
