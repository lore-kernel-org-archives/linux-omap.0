From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Sun, 16 May 2010 20:01:51 +0100
Message-ID: <1274036511.5719.86.camel@finisterre.wolfsonmicro.main>
References: <1272667021-21312-1-git-send-email-arve@android.com>
	<87aas2azc5.fsf@deeprootsystems.com> <20100514231510.GG16989@thunk.org>
	<201005152152.15996.rjw@sisk.pl> (sfid-20100515_205058_772833_CF1FCD2A)
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201005152152.15996.rjw@sisk.pl>
	(sfid-20100515_205058_772833_CF1FCD2A)
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, linux-kernel@vger.kernel.org, Daniel@smtp1.linux-foundation.org, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@infradead.org>, Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Oleg Nesterov <oleg@redhat.com>, Liam Girdwood <lrg@slimlogic.co.uk>, linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@stericsson.com>, lker <dwalker@codeaurora.org>, tytso@mit.edu, Brian Swetland <swetland@google.com>, Greg Kroah-Hartman <gregkh@suse.de>, Geoff Smith <geoffx.smith@intel.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>
List-Id: linux-omap@vger.kernel.org

On Sat, 2010-05-15 at 21:52 +0200, Rafael J. Wysocki wrote:
> On Saturday 15 May 2010, tytso@mit.edu wrote:

> > The examples cited where the things like the Palm Pre, and the Nokia
> > N770/800/810 series.  #1, what works on one embedded
> > chipset/architecture might not work on another, and #2, the battery

Pretty much all of the architectures going after this sort of market
seem to be taking very similar design decisions here. The high degree of
integration on the SoCs kind of forces it since you're always going to
end up with at least some things on the CPU sitting around idle so
something needs to be done to drive their runtime power cost down.
However, this does all require software support and the level of
implementation of that you see does vary.

> > lifetime on the N770 and N800 (both of which I have) is **appalling**
> > **bad**.

Hrm. I've got those devices as well and I don't recall the battery life
being particularly awful when they weren't actively being used which is
the interesting case there. It's been a while but ISTR they compared
well enough with the smartphones of their generation. YMMV, of course.

I guess the other direction to look at this from is that Android devices
seem to have battery lifetimes that are comparable to other smartphones,
including Linux based ones, rather than remarkably better than them.
There's a reasonable number out there that I've seen, using a range of
approaches including both pure runtime PM and also normal suspends
initiated from userspace with varying degrees of control over the
customisation end users can do on their system.

Wakelocks aren't totally going out on a limb in their use of suspend,
general systems in this area aren't actually relying purely on runtime
PM yet. Where wakelocks do stand out from the other solutions I have
seen is that they push the management of the decision to suspend into
the kernel.

I think it's probably most accurate to say that the thing that what
wakelocks are designed to deliver is to make the system more forgiving
of power inefficient application code (providing it doesn't just request
permission to burn the battery, of course). I can't think of any actual
implementations I have seen which do anything special to deal with them.
The argument there would I guess be that the impact on battery life
provides a fairly strong incentive to the application developers to not
do silly things. There's a fairly clear tradeoff there, and neither
approach is going to be universally right.

> And really, the only semi-technical argument against the opportunistic suspend
> feature I've seen so far in this thread is that it _may_ _be_ possible to
> achieve the same goal in a different way.  If I don't see anything more serious
> than that, I will take the patchset and push it to Linus (patches [1-6/8] from
> version 7 to be precise, as soon as the changelogs are improved as
> requested).

Well, the other concerns that *might* be considered technical are the
requirement for driver modifications to take wakelocks (personally I'm
fairly OK with that - it's not especially pretty but they seem trivial
enough so meh) and the userspace ABI that's being created to manage
suspend blocking (which I've not even looked at).

Like I say, I don't personally object to merging the code at this point - I
mostly wanted to provide a broader view on the approaches people are using
here.
