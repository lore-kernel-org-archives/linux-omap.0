From: Neil Brown <neilb@suse.de>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Tue, 1 Jun 2010 12:20:12 +1000
Message-ID: <20100601122012.1edeaf48@notabene.brown>
References: <Pine.LNX.4.44L0.1005271303190.3239-100000@iolanthe.rowland.org>
	<201006010005.19554.rjw@sisk.pl>
	<20100601090023.788cabf4@notabene.brown>
	<201006010232.20263.rjw@sisk.pl>
	<20100601113309.609349fd@notabene.brown>
	<alpine.LFD.2.00.1006010340160.2933@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.00.1006010340160.2933@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, Felipe Balbi <felipe.balbi@nokia.com>, Arve =?UTF-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>, Peter Zijlstra <peterz@infradead.org>, "Paul@smtp1.linux-foundation.org" <Paul@smtp1.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-omap@vger.kernel.org

On Tue, 1 Jun 2010 03:49:37 +0200 (CEST)
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Tue, 1 Jun 2010, Neil Brown wrote:
> > And if you are right that the race window cannot be closed, then the whole
> > suspend-blocker infrastructure is pointless as the purpose of it is simply to
> > close that window.  If it really does not and cannot work, then it would be
> > best to reject it for that reason rather than for less concrete aesthetic
> > arguments.
> > But presumably it does work in practice on Android hardware so ..... confused.
> > 
> > Having just seen the email from Thomas, maybe you mean that it cannot be
> > closed on devices using ACPI, but can on other devices.  I can sort-of
> > imagine how that would be the case (I tried reading an ACPI spec once - my
> > hat is of to those of you who understand it).
> > That shouldn't prevent us from closing the race window on "sane" hardware
> > that allows it.  This would, I think, be sufficient for Android's needs.
> > 
> > I'm hoping we can get agreement on:
> >   - there is a race with suspend
> 
> That's a matter of how you define "suspend". 

I define "suspend" as

    echo mem > /sys/power/state

> 
> If "suspend" is another deep idle state and the hardware is sane,
> there is no race at all - assumed that the driver/platform developer
> got it right. It's not rocket science to transition from "normal" irq
> delivery to wakeup based delivery raceless (except for PC style x86
> hardware of today)
> 
> If "suspend" is the thing we are used to via /sys/power/state then the
> race will persist forever except for the suspend blocker workaround,
> which we can express in QoS terms as well w/o adding another suspend
> related user space API.

I'm not interested in adding another user-space API if it can possibly be
avoided, and I think it can.  But that is a later step in the process.

I think you have acknowledged that there is a race with suspend - thanks.
Next step was "can it be closed".
You seem to suggest that it can, but you describe it as a "work around"
rather than a "bug fix"...

Do you agree that the race is a "bug", and therefore it is appropriate to
"fix" it assuming an acceptable fix can be found (which I think it can)?

If you agree that it is appropriate for try to fix this bug, then the next
step would be to get the Android devs to agree that a fix could - in
principle - address the need for which they created suspend-blockers.
Arve: can you confirm that?

Then, with a clear and agreed goal, we can look at possible fixes.

Thanks,
NeilBrown

> 
> Thanks,
> 
> 	tglx
