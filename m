From: Kevin Hilman <khilman@ti.com>
Subject: Re: Suspend broken on 3.3?
Date: Mon, 09 Apr 2012 07:27:22 -0700
Message-ID: <87zkalc75h.fsf@ti.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:37691 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755553Ab2DIO1T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Apr 2012 10:27:19 -0400
Received: by pbcwz17 with SMTP id wz17so5165852pbc.13
        for <linux-omap@vger.kernel.org>; Mon, 09 Apr 2012 07:27:18 -0700 (PDT)
In-Reply-To: <CAMrsUdLMYVwd3rupHtrNKC0rMvx1-3B=4usOh8cwTUy8DX_hVg@mail.gmail.com>
	(Govindraj Raja's message of "Mon, 9 Apr 2012 16:57:23 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Raja, Govindraj" <govindraj.raja@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Joe Woodward <jw@terrafix.co.uk>, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, neilb@suse.de

"Raja, Govindraj" <govindraj.raja@ti.com> writes:

[...]

> So incase of uart wakeups are disabled and uart tx/rx is requested
> can we prevent MPU from low power state.

I think that would be a mistake.

The main point of disabling UART wakeups is to save power by preventing
unwanted wakups on UARTs that don't need/want them.  If we then leave
MPU enabled because UART wakeups are disabled, that would defeat the
power-saving goals of disabling wakeups in the first place.

Presumably, if a user disables UART wakeups, it means either 1) that
UART is not used or 2) performance is not critical.

IMO, we simply need to ensure that the defaults are correct.  When UARTs
are initialized/enabled wakeups should be enabled by default.  The user
can then override this if desired, and will obviously see a performance
impact.  But that's what happens with wakeups disabled.

Kevin
