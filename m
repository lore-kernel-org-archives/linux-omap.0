From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Fri, 28 May 2010 12:16:36 +0100
Message-ID: <20100528121636.34be17ad@lxorguk.ukuu.org.uk>
References: <20100527222514.0a1710bf@lxorguk.ukuu.org.uk>
	<Pine.LNX.4.44L0.1005271730180.3239-100000@iolanthe.rowland.org>
	<20100527230806.4deb6de3@lxorguk.ukuu.org.uk>
	<20100527220949.GB10602@srcf.ucam.org>
	<20100527232357.6d14fdb2@lxorguk.ukuu.org.uk>
	<AANLkTil6Bo7qZltbLzHJjIDyruKHFQEURpe5LPJEpTws@mail.gmail.com>
	<20100528101755.7b5f6b8a@lxorguk.ukuu.org.uk>
	<AANLkTilYHKKmQePBGW3LVLjUZy7HXHQku2Iub-LWGBm6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTilYHKKmQePBGW3LVLjUZy7HXHQku2Iub-LWGBm6@mail.gmail.com>
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

> > My laptop behaves in
> > that way if for example the battery is almost flat. Your suspend blocker
> > would cause me to lose all my work with a flat battery. This is another
> > example of why the application must not be the policy manager.
> >
> 
> You can still force suspend when the battery gets low.

So now we need suspend blocker blockers - as I predicted.

> > In the normal case in the PC world outside of corner cases like flat
> > batteries the answer is really simple. The laptop suspend to RAM
> > on idle intervals set in the BIOS and the like are sufficient that
> > progress will have been made before it considers going back to sleep
> > again. Right now its about ten seconds in each direction plus other costs
> > (wear on LCD backlight, disc parking etc).
> >
> 
> I'm not sure what you are trying to say here. Are you saying your
> laptop enters S3 from idle?

If I have an alarm set on my laptop it will wake up when the alarm goes
off. Once it has woken up it will not go back to suspend (except for
something libe a battery event) until a timeout has elapsed that began
when the laptop woke up.

This in the laptop work solves the problem of making progress. On a
laptop power budget, with laptop constraints on suspend (both physical
cycle limits of hardware and performance) this works fine.

If I suspend/resume my laptop every time I have a 30 second idle gap I
will need a new laptop much sooner than makes me happy.

I don't claim this is true for a typical mobile phone obviously.

Alan
