From: Ingo Molnar <mingo@elte.hu>
Subject: Re: suspend blockers & Android integration
Date: Fri, 4 Jun 2010 02:39:34 +0200
Message-ID: <20100604003934.GA5221@elte.hu>
References: <20100603193045.GA7188@elte.hu>
 <20100603231153.GA11302@elte.hu>
 <20100603232302.GA16184@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100603232302.GA16184@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
To: tytso@mit.edu
Cc: Brian Swetland <swetland@google.com>, Neil Brown <neilb@suse.de>, Arve Hj?nnev?g <arve@android.com>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, Felipe Balbi <felipe.balbi@nokia.com>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, James Bottomley <James.Bottomley@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Kevin Hilman <khilman@deeprootsystems.com>, "H. Peter Anvin" <hpa@zytor.com>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-omap@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

>  - Create a 'deep idle' mode that suspends. This, if all constraints
>    are met, is triggered by the scheduler automatically: just like the other
>    idle modes are triggered currently. This approach fixes the wakeup
>    races because an incoming wakeup event will set need_resched() and
>    abort the suspend.
> 
>    ( This mode can even use the existing suspend code to bring stuff down,
>      therefore it also solves the pending timer problem and works even on
>      PC style x86. )

Note that this does not necessarily have to be implemented as 'execute suspend 
from the idle task' code: scheduling from the idle task, while can certainly 
be made to work, is a somewhat recursive concept that we might want to avoid 
for robustness reasons.

Instead, the 'deepest idle' (suspend) method could consist of a wakeup of a 
kernel thread (or of any of the existing kernel threads such as the migration 
thread) - which kernel thread then does a race-free suspend: it offlines all 
but one CPU [on platforms that need that] and then initiates the suspend - but 
aborts the attempt if there's any sign of wakeup activity.

Thanks,

	Ingo
