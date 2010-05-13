From: Tony Lindgren <tony@atomide.com>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 6)
Date: Thu, 13 May 2010 12:17:17 -0700
Message-ID: <20100513191717.GA3428@atomide.com>
References: <alpine.DEB.2.00.1005122118530.7624@utopia.booyaka.com>
 <Pine.LNX.4.44L0.1005131002380.1695-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1005131002380.1695-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Paul Walmsley <paul@pwsan.com>, Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Kernel development list <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Kevin Hilman <khilman@deeprootsystems.com>, magnus.damm@gmail.com, Theodore Ts'o <tytso@mit.edu>, mark gross <mgross@linux.intel.com>, Arjan van de Ven <arjan@infradead.org>, Geoff Smith <geoffx.smith@intel.com>, Brian Swetland <swetland@google.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <mjg@redhat.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, Vitaly Wool <vitalywool@gmail.com>, Linus Walleij <linus.walleij@ericsson.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: linux-omap@vger.kernel.org

* Alan Stern <stern@rowland.harvard.edu> [100513 07:11]:
> On Wed, 12 May 2010, Paul Walmsley wrote:
> 
> > Hello,
> > 
> > Some general comments on the suspend blockers/wakelock/opportunistic
> > suspend v6 patch series, posted here:
> > 
> >     https://lists.linux-foundation.org/pipermail/linux-pm/2010-April/025146.html
> > 
> > The comments below are somewhat telegraphic in the interests of 
> > readability - more specific comments to follow in later E-mails. I am 
> > indebted to those of us who discussed these issues at LPC last year and 
> > ELC this year for several stimulating discussions.
> > 
> > There are several general problems with the design of opportunistic
> > suspend and suspend-blocks.
> > 
> > 1. The opportunistic suspend code bypasses existing Linux kernel code,
> >    such as timers and the scheduler, that indicates when code
> >    needs to run, and when the system is idle.
> 
> Whoa!  That's not my understanding at all.
> 
> As I see it, opportunistic suspend doesn't bypass any code that isn't 
> already bypassed by the existing suspend code.  Users can do
> 
> 	echo mem >/sys/power/state
> 
> whenever they want, without regard to kernel timers and the scheduler 
> (other than the fact that the user's thread must be running in order to 
> carry out the write, of course).

The difference between echo mem > /sys/power/state and suspend blocks
is that with suspend blocks the system keeps running. And that's why 
it should be handled by runtime power management instead.

The suspend blocks seems like a hack to spam filter good and bad
apps from timer usage point of view. Applications are categorized
as good or bad depending if they grab a susped blocker or not.

I believe categorizing the apps should be instead done with some
timer flags or cgroups instead.

Cheers,

Tony
