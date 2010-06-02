From: Brian Swetland <swetland@google.com>
Subject: Re: [PATCH] - race-free suspend. Was: Re: [linux-pm] [PATCH 0/8]
	Suspend block api (version 8)
Date: Wed, 2 Jun 2010 11:05:18 -0700
Message-ID: <AANLkTikXy__71nBNW0EFbyL_qNf0nQ68pW9KymWlTk7L@mail.gmail.com>
References: <Pine.LNX.4.44L0.1005271303190.3239-100000@iolanthe.rowland.org>
	<201006010005.19554.rjw@sisk.pl>
	<20100601090023.788cabf4@notabene.brown>
	<201006010232.20263.rjw@sisk.pl>
	<20100601113309.609349fd@notabene.brown>
	<alpine.LFD.2.00.1006010340160.2933@localhost.localdomain>
	<20100601122012.1edeaf48@notabene.brown>
	<alpine.LFD.2.00.1006011243350.2933@localhost.localdomain>
	<20100602153235.340a7852@notabene.brown>
	<AANLkTikVjAf5nHdMx2bcHRAUSkq99s-b5YZCECXIJJLy@mail.gmail.com>
	<20100602180614.729246ea@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100602180614.729246ea@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: Neil Brown <neilb@suse.de>
Cc: =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, Felipe Balbi <felipe.balbi@nokia.com>, Peter Zijlstra <peterz@infradead.org>, "Paul@smtp1.linux-foundation.org" <Paul@smtp1.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, James Bottomley <James.Bottomley@suse.de>
List-Id: linux-omap@vger.kernel.org

On Wed, Jun 2, 2010 at 1:06 AM, Neil Brown <neilb@suse.de> wrote:
> On Wed, 2 Jun 2010 00:05:14 -0700
> Arve Hj=C3=B8nnev=C3=A5g <arve@android.com> wrote:
>> > The user-space suspend daemon avoids losing wake-events by using
>> > fcntl(F_OWNER) to ensure it gets a signal whenever any important w=
ake-event
>> > is ready to be read by user-space. =C2=A0This may involve:
>> > =C2=A0- the one daemon processing all wake events
>>
>> Wake up events are not all processed by one daemon.
>
> Not with your current user-space code, no. =C2=A0Are you saying that =
you are not
> open to any significant change in the Android user-space code? =C2=A0=
That would
> make the situation a lot harder to resolve.

There are many wakeup events possible in a typical system --
keypresses or other input events, network traffic, telephony events,
media events (fill audio buffer, fill video decoder buffer, etc), and
I think requiring that all wakeup event processing bottleneck through
a single userspace process is non-optimal here.

The current suspend-blocker proposal already involves userspace
changes (it's different than our existing wakelock interface), and
we're certainly not opposed to any/all userspace changes on principle,
but on the other hand we're not interested in significant reworks of
userspace unless they actually improve the situation somehow.  I think
bottlenecking events through a central daemon would represent a step
backwards.

Brian
