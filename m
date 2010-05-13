From: Tony Lindgren <tony@atomide.com>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 6)
Date: Thu, 13 May 2010 13:23:20 -0700
Message-ID: <20100513202320.GF3428@atomide.com>
References: <alpine.DEB.2.00.1005122118530.7624@utopia.booyaka.com>
 <Pine.LNX.4.44L0.1005131002380.1695-100000@iolanthe.rowland.org>
 <20100513191717.GA3428@atomide.com>
 <20100513192522.GA19256@srcf.ucam.org>
 <20100513194205.GC3428@atomide.com>
 <20100513195349.GB19722@srcf.ucam.org>
 <20100513200003.GE3428@atomide.com>
 <20100513200814.GA20254@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100513200814.GA20254@srcf.ucam.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Paul Walmsley <paul@pwsan.com>, Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Kernel development list <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Kevin Hilman <khilman@deeprootsystems.com>, magnus.damm@gmail.com, Theodore Ts'o <tytso@mit.edu>, mark gross <mgross@linux.intel.com>, Arjan van de Ven <arjan@infradead.org>, Geoff Smith <geoffx.smith@intel.com>, Brian Swetland <swetland@google.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, =?utf-8?Q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, Vitaly Wool <vitalywool@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: linux-omap@vger.kernel.org

* Matthew Garrett <mjg@redhat.com> [100513 13:03]:
> On Thu, May 13, 2010 at 01:00:04PM -0700, Tony Lindgren wrote:
> 
> > The system stays running because there's something to do. The system
> > won't suspend until all the processors hit the kernel idle loop and
> > the next_timer_interrupt_critical() returns nothing.
> 
> At which point an application in a busy loop cripples you.

Maybe you could deal with the misbehaving untrusted apps in the userspace
by sending kill -STOP to them when the screen blanks? Then continue
when some event wakes up the system again.

> I think we could implement your suggestion more easily by just giving
> untrusted applications an effectively infinite amount of timer slack,
> but it still doesn't handle the case where an app behaves excrutiatingly
> badly.

Hmm, if you use timer slack then you still need to search through
the whole timer list instead of a smaller critical timer list.
Both ways sound doable though.

Regards,

Tony
