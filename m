From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Mon, 17 May 2010 14:27:52 -0700
Message-ID: <87ljbi1anb.fsf@deeprootsystems.com>
References: <1272667021-21312-1-git-send-email-arve@android.com>
	<87wrvl5479.fsf@deeprootsystems.com>
	<20100503215028.GB18910@srcf.ucam.org>
	<alpine.DEB.2.00.1005141408260.3348@utopia.booyaka.com>
	<20100514203202.GA12409@srcf.ucam.org>
	<87aas2azc5.fsf@deeprootsystems.com>
	<20100514231510.GG16989@thunk.org>
	<87r5laa4oc.fsf@deeprootsystems.com>
	<AANLkTilL90pYVlquvMDAEPHj_AraEi9Qzk-0tTjw9Bkx@mail.gmail.com>
	<20100517193440.GA32066@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100517193440.GA32066@srcf.ucam.org> (Matthew Garrett's message
	of "Mon\, 17 May 2010 20\:34\:40 +0100")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Jesse Barnes <jbarnes@virtuousgeek.org>, Oleg Nesterov <oleg@redhat.com>, linux-pm@lists.linux-foundation.org, Liam Girdwood <lrg@slimlogic.co.uk>, Len Brown <len.brown@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@stericsson.com>, Daniel Walker <dwalker@codeaurora.org>, tytso@mit.edu, Geoff Smith <geoffx.smith@intel.com>, Brian Swetland <swetland@google.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-omap@vger.kernel.org

Matthew Garrett <mjg@redhat.com> writes:

> On Mon, May 17, 2010 at 09:27:47PM +0200, Vitaly Wool wrote:
>
>> Exactly. The point is, opportunistic suspend doesn't in fact add any
>> value compared to dynamic PM + CPUIdle. It only produces some false
>> impression that one can handle power management right without using
>> dynamic PM. And this false impression is the cause for many really
>> ugly designs (like, for instance, 15 minutes touchscreen inactivity
>> delay before forcibly shutting down the wireless, as it's done in
>> stock Android framework).
>
> Run this (or equivalent code) on an N900 and on an Android. Measure the 
> screen-off power draw on both.
>
> int main() {
> 	int i;
> 	while (1)
> 		i++;
> 	return 0;
> }

This kind of rogue app will also kill my CPU performance.  For rogue
CPU-hog apps, we use _tools_ to find and fix this kind of problem:
top, renice, kill, etc. that use features of the scheduler to find
and/or solve the problem.

For rogue apps that affect PM, what is being proposed is to bypass the
root causes (timers, scheduler, activity, etc.) and just freeze the
apps.

Rogue CPU-hog apps are generally not tolerated.  The problems are
found using tools and fixed (or removed.)  Why should we do any
different for rogue power-hog apps?

Maybe the tools aren't as good for finding power-sucking apps.
Then we should be focusing on the _tools_ instead of masking the
problem.

Kevin
