From: tytso@mit.edu
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Fri, 14 May 2010 19:15:10 -0400
Message-ID: <20100514231510.GG16989@thunk.org>
References: <1272667021-21312-1-git-send-email-arve@android.com>
	<87wrvl5479.fsf@deeprootsystems.com>
	<20100503215028.GB18910@srcf.ucam.org>
	<alpine.DEB.2.00.1005141408260.3348@utopia.booyaka.com>
	<20100514203202.GA12409@srcf.ucam.org>
	<87aas2azc5.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87aas2azc5.fsf@deeprootsystems.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@infradead.org>, Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Oleg Nesterov <oleg@redhat.com>, Liam Girdwood <lrg@slimlogic.co.uk>, linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@stericsson.com>, Daniel Walker <dwalker@codeaurora.org>, Brian Swetland <swetland@google.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Geoff Smith <geoffx.smith@intel.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>
List-Id: linux-omap@vger.kernel.org

On Fri, May 14, 2010 at 03:32:58PM -0700, Kevin Hilman wrote:
> Another likely reason that that there hasn't been an alternate
> proposal (at least from some of us that are raising concerns) is
> because we already have a working solution to dynamic, system-wide PM
> that is 1) already in mainline and 2) shipping on consumer devices
> with very strict power budgets (as already pointed out in detail by
> Paul[2].)

The examples cited where the things like the Palm Pre, and the Nokia
N770/800/810 series.  #1, what works on one embedded
chipset/architecture might not work on another, and #2, the battery
lifetime on the N770 and N800 (both of which I have) is **appalling**
**bad**.

I really don't understand why people are so opposed to merging code
that works well for a very large set of devices and products.  Just
because *you* don't need it is not a sufficiently good reason to argue
for it not be merged.  If you don't want to use it, then don't CONFIG
it in.

						- Ted
