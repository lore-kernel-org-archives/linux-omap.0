From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Fri, 14 May 2010 14:20:43 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1005141408260.3348@utopia.booyaka.com>
References: <1272667021-21312-1-git-send-email-arve@android.com>
	<87wrvl5479.fsf@deeprootsystems.com>
	<20100503215028.GB18910@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100503215028.GB18910@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, Liam Girdwood <lrg@slimlogic.co.uk>, Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Oleg Nesterov <oleg@redhat.com>, linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@stericsson.com>, Daniel Walker <dwalker@codeaurora.org>, Theodore Ts'o <tytso@mit.edu>, Brian Swetland <swetland@google.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Geoff Smith <geoffx.smith@intel.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-omap@vger.kernel.org

Hello,

On Mon, 3 May 2010, Matthew Garrett wrote:

> I agree that the runtime scenario is a far more appealing one from an 
> aesthetic standpoint, but so far we don't have a very compelling 
> argument for dealing with the starting and stopping of userspace.

The problem of how to start and stop (some) userspace is not specifically 
system power management-related, nor top-down, /sys/power/state-suspend 
related.  PM is just one potential user.

It's hard to see how the Android opportunistic suspend approach would be 
useful for the other use-cases (e.g., checkpoint/restart).  On the other 
hand, it's easier to see how something like freezer cgroups could be 
useful for system power management and checkpoint/restart.

And the Android opportunistic suspend patches have design problems - they 
definitely do not come for free, as noted in [1][2][3] (among others' 
comments).


- Paul


1. Paul Walmsley E-mail to the linux-pm mailing list, dated Wed, 12
   May 2010 21:35:30 -0600: http://lkml.org/lkml/2010/5/12/528

2. Paul Walmsley E-mail to the linux-pm mailing list, dated Fri, 14
   May 2010 00:13:50 -0600:
   http://permalink.gmane.org/gmane.linux.power-management.general/18657

3. Paul Walmsley E-mail to the linux-pm mailing list, dated Fri, 14
   May 2010 00:27:56 -0600:
   http://permalink.gmane.org/gmane.linux.power-management.general/18658
