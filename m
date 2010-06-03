From: Brian Swetland <swetland@google.com>
Subject: Re: [PATCH] - race-free suspend. Was: Re: [linux-pm] [PATCH 0/8]
	Suspend block api (version 8)
Date: Wed, 2 Jun 2010 23:43:06 -0700
Message-ID: <AANLkTikuf6bKVHoGRTjrM_2kPtZqUM6J76Z0hNUQxT_3@mail.gmail.com>
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
	<AANLkTikXy__71nBNW0EFbyL_qNf0nQ68pW9KymWlTk7L@mail.gmail.com>
	<20100603163307.721b1c23@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100603163307.721b1c23@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: Neil Brown <neilb@suse.de>
Cc: =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, Felipe Balbi <felipe.balbi@nokia.com>, Peter Zijlstra <peterz@infradead.org>, "Paul@smtp1.linux-foundation.org" <Paul@smtp1.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, James Bottomley <James.Bottomley@suse.de>
List-Id: linux-omap@vger.kernel.org

On Wed, Jun 2, 2010 at 11:33 PM, Neil Brown <neilb@suse.de> wrote:
>>
>> The current suspend-blocker proposal already involves userspace
>> changes (it's different than our existing wakelock interface), and
>> we're certainly not opposed to any/all userspace changes on principl=
e,
>> but on the other hand we're not interested in significant reworks of
>> userspace unless they actually improve the situation somehow. =C2=A0=
I think
>> bottlenecking events through a central daemon would represent a step
>> backwards.
>
> I guess it becomes an question of economics for you then. =C2=A0Does =
the cost of
> whatever user-space changes are required exceed the value of using an=
 upstream
> kernel? =C2=A0Both the cost and the value would be very hard to estim=
ate in
> advance. =C2=A0I don't envy you the decision...

Well, at this point we've invested more engineering hours in the
various rewrites of this (single) patchset and discussion around it
than we have spent on rebasing our trees on roughly every other
mainline release since 2.6.16 or so, across five years of Android
development.  We think there's some good value to be had (all the
usual reasons) by heading upstream, so we're still discussing these
patches and exploring alternatives, but yes, from one way of looking
at it, it'd certainly be cheaper to just keep maintaining our own
trees.

Brian
