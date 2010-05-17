From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Mon, 17 May 2010 09:12:03 -0700
Message-ID: <87r5laa4oc.fsf@deeprootsystems.com>
References: <1272667021-21312-1-git-send-email-arve@android.com>
	<87wrvl5479.fsf@deeprootsystems.com>
	<20100503215028.GB18910@srcf.ucam.org>
	<alpine.DEB.2.00.1005141408260.3348@utopia.booyaka.com>
	<20100514203202.GA12409@srcf.ucam.org>
	<87aas2azc5.fsf@deeprootsystems.com>
	<20100514231510.GG16989@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100514231510.GG16989@thunk.org> (tytso@mit.edu's message of
	"Fri\, 14 May 2010 19\:15\:10 -0400")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: tytso@mit.edu
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@infradead.org>, Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Oleg Nesterov <oleg@redhat.com>, Liam Girdwood <lrg@slimlogic.co.uk>, linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@stericsson.com>, Daniel Walker <dwalker@codeaurora.org>, Brian Swetland <swetland@google.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Geoff Smith <geoffx.smith@intel.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>
List-Id: linux-omap@vger.kernel.org

tytso@mit.edu writes:

> On Fri, May 14, 2010 at 03:32:58PM -0700, Kevin Hilman wrote:
>> Another likely reason that that there hasn't been an alternate
>> proposal (at least from some of us that are raising concerns) is
>> because we already have a working solution to dynamic, system-wide PM
>> that is 1) already in mainline and 2) shipping on consumer devices
>> with very strict power budgets (as already pointed out in detail by
>> Paul[2].)
>
> The examples cited where the things like the Palm Pre, and the Nokia
> N770/800/810 series.  #1, what works on one embedded
> chipset/architecture might not work on another, 

In my experience with embedded SoCs they are all remarkably similar in
power management capabilities and control.

> and #2, the battery lifetime on the N770 and N800 (both of which I have)
> is **appalling** **bad**.

Appalling bad compared to what?  

What's probably more interesting in terms of rough comparisons is
comparing similar devices with and without opportunistic suspend.  The
Nokia n900 (maemo) and the Moto Droid (android) use the same SoC (TI
OMAP3) and roughly the same kernel (2.6.2[89], although both are
heavily patched from mainline.)

The n900 *never* suspends.  It only uses dynamic PM + CPUidle.
The droid uses opportunistic suspend (as well as dynamic PM + CPUidle)

I don't know of any more objective comparison of the two, but as a
user of both devices I can say that the active usage is basically the
same (around a day) and the idle use is similar as well, even though
the Droid has a slightly bigger battery (1400 mAh vs. 1320 mAh.)  My
own usage suggests the n900 is a bit better in idle time, but I have
not done any measuring or objective tests.  I'm guessing the
difference is probably because the Droid does not use the deepest
off-mode power states either in idle or suspend (IIRC) where the n900
does.  I suspect that if both were using off-mode and had the same
battery, these differences would go away.

While this is not really a scientific comparison, it at least gives a
rough idea.  If using opportunistic suspend was adding noticably
better battery life, I think this would be a different discussion.

> I really don't understand why people are so opposed to merging code
> that works well for a very large set of devices and products.  Just
> because *you* don't need it is not a sufficiently good reason to argue
> for it not be merged.  If you don't want to use it, then don't CONFIG
> it in.

At least for OMAP, I don't consider "config it out" a viable option.

We would like one kernel (in particular one PM core) to be usable for
a broad range of devices: maemo/meego, Android, webOS, Archos, and
whatever else we haven't seen yet.  Having to config in/out something
as important as core PM functionality has other consequences.  It
makes PM-aware driver and subsystem writers (and maintainers) to have
to develop and validate against two different types of PM
functionality.

As co-maintainer of the PM subsystem for an architecture (OMAP) where
people *really* care about power, I don't consider that a viable or
scalable option.

Kevin
