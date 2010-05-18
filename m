From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Tue, 18 May 2010 02:55:19 +0100
Message-ID: <20100518015519.GA6500@srcf.ucam.org>
References: <1272667021-21312-1-git-send-email-arve@android.com>
	<87aas2azc5.fsf@deeprootsystems.com>
	<20100514231510.GG16989@thunk.org> <201005152152.15996.rjw@sisk.pl>
	<alpine.DEB.2.00.1005171932540.27473@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1005171932540.27473@utopia.booyaka.com>
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
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, Liam Girdwood <lrg@slimlogic.co.uk>, Len Brown <len.brown@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Oleg Nesterov <oleg@redhat.com>, linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@stericsson.com>, Daniel Walker <dwalker@codeaurora.org>, tytso@mit.edu, Brian Swetland <swetland@google.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Geoff Smith <geoffx.smith@intel.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-omap@vger.kernel.org

On Mon, May 17, 2010 at 07:39:44PM -0600, Paul Walmsley wrote:

>       A. To prevent untrusted process timers from waking the system,
>          the processes can be run in a cgroup that calls
>          del_timer_sync() on all process timers upon receipt of some
>          trigger.  When the system returns from the system low-power
>          state and some trigger event happens, add_timer() can be
>          called to add all the cgroup's timers back.

This doesn't work, for the reasons previously discussed.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
