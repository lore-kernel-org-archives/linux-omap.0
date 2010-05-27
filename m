From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Fri, 28 May 2010 00:15:14 +0100
Message-ID: <20100528001514.28e593ef@lxorguk.ukuu.org.uk>
References: <Pine.LNX.4.44L0.1005271253240.3239-100000@iolanthe.rowland.org>
	<20100527174019.GA3187@srcf.ucam.org>
	<1274982447.27810.5684.camel@twins>
	<201005280041.43553.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201005280041.43553.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Mickler <florian@mickler.org>, Peter Zijlstra <peterz@infradead.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Florian@smtp1.linux-foundation.org, Linux@smtp1.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>, List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, felipe.balbi@nokia.com
List-Id: linux-omap@vger.kernel.org

> The approach with user space power manager suggested by Dmitry and Alan Stern
> may work, but it still assumes some kind of suspend blockers to be present in
> the kernel.  If we reject that too, I wonder what approach Google is supposed
> to use and still get the same battery life they get with suspend blockers.

I'm getting less convinced it needs suspend blockers at all for this case,
assuming that you are willing to have a policy that is based on

- assuming apps play nicely
- having the information to user space you need (who woke us, who blocked
  us, events)
- dealing with offenders primarily from user space using that information

I'm fairly happy about the following so far

- we should have a common interface for seeing some pm events (like
  duh ?) but it does need careful thought so the watcher doesn't change
  the behaviour and break it. (Message "We are suspending", gosh someone
  is running to receive the message, resume being the obvious case)

- Suspend is (for many platforms) just a cotinuation down the power
  chain. Demonstrated and implemented on ARM. Very much the direction of
  S0i1/S0i3 on x86 MID devices. Proved by the fact it has been done and
  made to work, and by reading the Moorestown PR.

- Given a non forced (that is 'idle down') transition to a suspend level
  we can implement a 'suspend as idle' on many embedded platforms in a
  manner which is not racy at kernel level. Apparently implemented
  already on ARM

- Given a non forced transition to such a suspend level and the reporting
  of certain events we can do a full user space managed graphical UI type
  environment policy in a race free fashion

- With notification of who caused a resume and maybe a bit of other
  general stat gathering it is possible to identify and handle abuses of
  power resource. Proved by the fact we can do this with powertop but
  more elegance in the interfaces would be nice.

I am not sure if a pm event is what is needed for this or a sum 'hardware
triggered wake up' event.

I accept that current ACPI based laptops probably couldn't make use of
such a feature but I don't think this is important at the moment.

A resource constraint model might help further in the ACPI case. It's
useful for other stuff but it might well be a distraction and
implementation detail in terms of the basic question about what is needed
for something like Android.

At this point the input of the Android team and the Nokia people would
be rather more useful to me.

Alan
