From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Fri, 14 May 2010 11:22:05 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1005141101070.3348@utopia.booyaka.com>
References: <Pine.LNX.4.44L0.1005031301400.1651-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1005031301400.1651-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, Liam Girdwood <lrg@slimlogic.co.uk>, Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Oleg Nesterov <oleg@redhat.com>, linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@stericsson.com>, Daniel Walker <dwalker@codeaurora.org>, Theodore Ts'o <tytso@mit.edu>, Brian Swetland <swetland@google.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Geoff Smith <geoffx.smith@intel.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-omap@vger.kernel.org


Hello,

Please forgive the delay in commenting - I am just now catching up on 
these huge E-mail threads;

On Mon, 3 May 2010, Alan Stern wrote:

> So for example, runtime PM cannot be used to put the system into an S3 
> sleep state.

This is not quite true.  Runtime PM, *in conjunction with CPUIdle,* can 
put many current embedded Linux systems into not just S3, but actually S5.

This is done right now on OMAP in mainline Linux[1].  (S5 is called "C6" 
in that codebase, since the CPUIdle governor is used - this is a 
misnomer.)

This approach allows the system to wake up, or stay running, as requested 
by the timer subsystem, or the scheduler.  No suspend-block-like API is 
needed.

Several consumer-market Linux devices have already shipped using this 
mechanism.

> The simplest example is that suspend blockers can be used to control 
> whether or not the CPU shuts down, whereas runtime PM can't.

Runtime PM still needs to be combined with some sort of governor to 
control not only CPU power states, but also system power states.  CPUIdle 
works pretty well as a system power governor for a single-CPU system, but 
is admittedly something of a hack[2].

Going forward, some sort of basic, system-wide governor is a cleaner 
design[3].  But since the "opportunistic suspend" governor proposed in 
patch 1 ignores timer expiries and the scheduler runqueue, and then hacks 
around that decision by inserting suspend-block calls into code that would 
otherwise work normally, it's not a good approach.


- Paul



1. http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/arm/mach-omap2/cpuidle34xx.c;h=3d3d035db9aff62ce522e0080e570cfdbf8e70cc;hb=4462dc02842698f173f518c1f5ce79c0fb89395a#l292

2. Paul Walmsley E-mail to the linux-pm mailing list, dated Thu, 13
   May 2010 13:01:33 -0600:
   http://permalink.gmane.org/gmane.linux.power-management.general/18592

3. ibid.
