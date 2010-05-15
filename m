From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Sat, 15 May 2010 21:52:15 +0200
Message-ID: <201005152152.15996.rjw@sisk.pl>
References: <1272667021-21312-1-git-send-email-arve@android.com>
	<87aas2azc5.fsf@deeprootsystems.com>
	<20100514231510.GG16989@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100514231510.GG16989@thunk.org>
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
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@infradead.org>, Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Arve@smtp1.linux-foundation.org, Oleg Nesterov <oleg@redhat.com>, Liam Girdwood <lrg@slimlogic.co.uk>, linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@stericsson.com>, Daniel Walker <dwalker@codeaurora.org>, Brian Swetland <swetland@google.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Geoff Smith <geoffx.smith@intel.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>
List-Id: linux-omap@vger.kernel.org

On Saturday 15 May 2010, tytso@mit.edu wrote:
> On Fri, May 14, 2010 at 03:32:58PM -0700, Kevin Hilman wrote:
> > Another likely reason that that there hasn't been an alternate
> > proposal (at least from some of us that are raising concerns) is
> > because we already have a working solution to dynamic, system-wide PM
> > that is 1) already in mainline and 2) shipping on consumer devices
> > with very strict power budgets (as already pointed out in detail by
> > Paul[2].)
> 
> The examples cited where the things like the Palm Pre, and the Nokia
> N770/800/810 series.  #1, what works on one embedded
> chipset/architecture might not work on another, and #2, the battery
> lifetime on the N770 and N800 (both of which I have) is **appalling**
> **bad**.
> 
> I really don't understand why people are so opposed to merging code
> that works well for a very large set of devices and products.  Just
> because *you* don't need it is not a sufficiently good reason to argue
> for it not be merged.  If you don't want to use it, then don't CONFIG
> it in.

Violently agreed.

And really, the only semi-technical argument against the opportunistic suspend
feature I've seen so far in this thread is that it _may_ _be_ possible to
achieve the same goal in a different way.  If I don't see anything more serious
than that, I will take the patchset and push it to Linus (patches [1-6/8] from
version 7 to be precise, as soon as the changelogs are improved as
requested).

Thanks,
Rafael
