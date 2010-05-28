From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Fri, 28 May 2010 10:17:55 +0100
Message-ID: <20100528101755.7b5f6b8a@lxorguk.ukuu.org.uk>
References: <20100527222514.0a1710bf@lxorguk.ukuu.org.uk>
	<Pine.LNX.4.44L0.1005271730180.3239-100000@iolanthe.rowland.org>
	<20100527230806.4deb6de3@lxorguk.ukuu.org.uk>
	<20100527220949.GB10602@srcf.ucam.org>
	<20100527232357.6d14fdb2@lxorguk.ukuu.org.uk>
	<AANLkTil6Bo7qZltbLzHJjIDyruKHFQEURpe5LPJEpTws@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTil6Bo7qZltbLzHJjIDyruKHFQEURpe5LPJEpTws@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve =?ISO-8859-14?B?SGr4bm5lduVn?= <arve@android.com>
Cc: Mailing List <linux-omap@vger.kernel.org>, Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux@smtp1.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>, Peter@smtp1.linux-foundation.org, Linux PM <linux-pm@lists.linux-foundation.org>, felipe.balbi@nokia.com
List-Id: linux-omap@vger.kernel.org

> Android does not only run on phones. It is possible that no android
> devices have ACPI, but I don't know that for a fact. What I do know is
> that people want to run Android on x86 hardware and supporting suspend
> could be very benficial.

Sufficently beneficial to justify putting all this stuff all over the
kernel and apps ? That is a *very* high hurdle, doubly so when those
vendors who have chosen to be part of the community are shipping phones
and PDAs just fine without them.
 
> > I would imagine the existing laptops will handle power management limited
> > by the functionality they have available. Just like any other piece of
> > hardware.
> 
> I think existing laptops (and desktops) can benefit from opportunistic
> suspend support. If opportunistic suspend is used for auto-sleep after
> inactivity instead of forced suspend, the user space suspend blocker
> api will allow an application to delay this auto sleep until for
> instance a download completes. This part could also be done with a

This assumes you modify all the applications. That isn't going to happen.
The hardware is going to catch up anyway.

> alarms. I know my desktops can wakeup at a specific time by
> programming an RTC alarm, but without suspend blockers how do you
> ensure that the system does not suspend right after the alarm
> triggered? I have a system that wakes up at specific times requested

How do you know that isn't the correct behavior. My laptop behaves in
that way if for example the battery is almost flat. Your suspend blocker
would cause me to lose all my work with a flat battery. This is another
example of why the application must not be the policy manager.

In the normal case in the PC world outside of corner cases like flat
batteries the answer is really simple. The laptop suspend to RAM
on idle intervals set in the BIOS and the like are sufficient that
progress will have been made before it considers going back to sleep
again. Right now its about ten seconds in each direction plus other costs
(wear on LCD backlight, disc parking etc).

Alan
