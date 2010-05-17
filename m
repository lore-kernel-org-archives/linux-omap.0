From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Mon, 17 May 2010 15:56:44 -0700
Message-ID: <87k4r2t9w3.fsf@deeprootsystems.com>
References: <87wrvl5479.fsf@deeprootsystems.com>
	<20100503215028.GB18910@srcf.ucam.org>
	<alpine.DEB.2.00.1005141408260.3348@utopia.booyaka.com>
	<20100514203202.GA12409@srcf.ucam.org>
	<87aas2azc5.fsf@deeprootsystems.com>
	<20100514231510.GG16989@thunk.org>
	<87r5laa4oc.fsf@deeprootsystems.com>
	<AANLkTilL90pYVlquvMDAEPHj_AraEi9Qzk-0tTjw9Bkx@mail.gmail.com>
	<20100517193440.GA32066@srcf.ucam.org>
	<87ljbi1anb.fsf@deeprootsystems.com>
	<20100517213437.GA2395@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100517213437.GA2395@srcf.ucam.org> (Matthew Garrett's message
	of "Mon\, 17 May 2010 22\:34\:37 +0100")
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

> On Mon, May 17, 2010 at 02:27:52PM -0700, Kevin Hilman wrote:
>> Matthew Garrett <mjg@redhat.com> writes:
>> > Run this (or equivalent code) on an N900 and on an Android. Measure the 
>> > screen-off power draw on both.
>> >
>> > int main() {
>> > 	int i;
>> > 	while (1)
>> > 		i++;
>> > 	return 0;
>> > }
>> 
>> This kind of rogue app will also kill my CPU performance.  For rogue
>> CPU-hog apps, we use _tools_ to find and fix this kind of problem:
>> top, renice, kill, etc. that use features of the scheduler to find
>> and/or solve the problem.
>
> If my phone is able to avoid losing almost all of its standby time 
> without me having to care about whether my bouncing cow game was written 
> by a complete fool or not, that means that my phone is *better* than one 
> where I have to care. 

Someday I hope to see this bouncing cow app I keep hearing about.  I
must be pretty spectacular since can't help talking about it.  ;)

> Would the world be better if said fool could be 
> sent to reeducation camps before being allowed to write any more 
> software? Probably, but sadly that doesn't seem to be something we can 
> implement through code. I'd love it if we could assume that all software 
> is going to be perfect, but in the absence of that ideal world there's a 
> strong incentive to develop technology that does its best to cope with 
> adverse situations.

I completely agree.  

The only thing being debated is the implementation of the coping
mechanism.

In particular, why the coping mechanism for PM "badness" has to be a
large sledgehammer where other badness (CPU, IO, etc.) has been dealt
with using infrastructure like timers, scheduling, throttling, etc.

My shrink would say that the sledgehammer approach to badness might
work for the short term, but eventually that badness is going to seep
out in other, unpredictable places.

My shrink would also probably tell me that since I'm seem to be the
last one left who seems to care, it's probably time to throw in the
towel.

Kevin
