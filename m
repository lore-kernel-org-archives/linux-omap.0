From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Fri, 14 May 2010 21:32:02 +0100
Message-ID: <20100514203202.GA12409@srcf.ucam.org>
References: <1272667021-21312-1-git-send-email-arve@android.com>
	<87wrvl5479.fsf@deeprootsystems.com>
	<20100503215028.GB18910@srcf.ucam.org>
	<alpine.DEB.2.00.1005141408260.3348@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1005141408260.3348@utopia.booyaka.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, Liam Girdwood <lrg@slimlogic.co.uk>, Len Brown <len.brown@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Oleg Nesterov <oleg@redhat.com>, linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@stericsson.com>, Daniel Walker <dwalker@codeaurora.org>, Theodore Ts'o <tytso@mit.edu>, Brian Swetland <swetland@google.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Geoff Smith <geoffx.smith@intel.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-omap@vger.kernel.org

On Fri, May 14, 2010 at 02:20:43PM -0600, Paul Walmsley wrote:
> Hello,
> 
> On Mon, 3 May 2010, Matthew Garrett wrote:
> 
> > I agree that the runtime scenario is a far more appealing one from an 
> > aesthetic standpoint, but so far we don't have a very compelling 
> > argument for dealing with the starting and stopping of userspace.
> 
> The problem of how to start and stop (some) userspace is not specifically 
> system power management-related, nor top-down, /sys/power/state-suspend 
> related.  PM is just one potential user.
>
> It's hard to see how the Android opportunistic suspend approach would be 
> useful for the other use-cases (e.g., checkpoint/restart).  On the other 
> hand, it's easier to see how something like freezer cgroups could be 
> useful for system power management and checkpoint/restart.

And difficult to see how to implement something using freezer cgroups 
that actually works in this case. Look, I don't want to sound like I 
have a one-track mind or anything, but all of these arguments would be 
significantly more compelling if someone would actually provide a 
concrete implementation proposal that deals with the set of use-cases 
that Google's implementation does and which doesn't make anyone cry. 
Otherwise the immeasurably most likely outcome is that this code gets 
merged and we get to live with it.
 
-- 
Matthew Garrett | mjg59@srcf.ucam.org
