From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Mon, 17 May 2010 22:35:30 +0100
Message-ID: <20100517213530.GB2395@srcf.ucam.org>
References: <87aas2azc5.fsf@deeprootsystems.com>
	<20100514231510.GG16989@thunk.org>
	<87r5laa4oc.fsf@deeprootsystems.com>
	<AANLkTilL90pYVlquvMDAEPHj_AraEi9Qzk-0tTjw9Bkx@mail.gmail.com>
	<20100517193440.GA32066@srcf.ucam.org>
	<CEE6BB42CAD6E947908279175AF8470A025A726242@EXDCVYMBSTM006.EQ1STM.local>
	<20100517210615.GB1873@srcf.ucam.org>
	<CEE6BB42CAD6E947908279175AF8470A025A726244@EXDCVYMBSTM006.EQ1STM.local>
	<20100517212437.GA2190@srcf.ucam.org>
	<1274131764.25625.54.camel@c-dwalke-linux.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1274131764.25625.54.camel@c-dwalke-linux.qualcomm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Daniel Walker <dwalker@codeaurora.org>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Jesse Bar nes <jbarnes@virtuousgeek.org>, Oleg Nesterov <oleg@redhat.com>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Len Brown <len.brown@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linus WALLEIJ <linus.walleij@stericsson.com>, "tytso@mit.edu" <tytso@mit.edu>, Geoff Smith <geoffx.smith@intel.com>, Brian Swetland <swetland@google.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-omap@vger.kernel.org

On Mon, May 17, 2010 at 02:29:24PM -0700, Daniel Walker wrote:
> On Mon, 2010-05-17 at 22:24 +0100, Matthew Garrett wrote:
> > > I was more thinking about something new, that isn't freezing anything.
> > > The only purpose would be to group the stuff that CPUidle can ignore,
> > > and let CPUidle ignore it, so that the system can still be idled.
> > 
> > So they'd be on the runqeue but wouldn't factor into cpuidle's 
> > calculations of when the next wakeup should be? Ok. I think that still 
> > leaves you with the same problem - you're not scheduling that task, so 
> > how do you know to execute it when a network packet is received? I think 
> > you also still have the race condition.
> 
> Couldn't you special case the network packet situation ? Like the idle
> loop could take into account that there are packets flowing through the
> networking stack that may need to get handled.

And once you've done that for every wakeup source you have something 
that looks pretty much like suspend blockers.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
