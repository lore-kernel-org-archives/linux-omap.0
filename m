From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Fri, 14 May 2010 15:37:12 -0700
Message-ID: <AANLkTilsAC--0TGYgeJpNVPzBCFL5uQmeBTjb3SgtjKY@mail.gmail.com>
References: <1272667021-21312-1-git-send-email-arve@android.com>
	<87wrvl5479.fsf@deeprootsystems.com>
	<20100503215028.GB18910@srcf.ucam.org>
	<alpine.DEB.2.00.1005141408260.3348@utopia.booyaka.com>
	<20100514203202.GA12409@srcf.ucam.org>
	<87aas2azc5.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@infradead.org>, Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Oleg Nesterov <oleg@redhat.com>, Liam Girdwood <lrg@slimlogic.co.uk>, linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@stericsson.com>, Daniel Walker <dwalker@codeaurora.org>, Theodore Ts'o <tytso@mit.edu>, Brian Swetland <swetland@google.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Geoff Smith <geoffx.smith@intel.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>
List-Id: linux-omap@vger.kernel.org

On Fri, May 14, 2010 at 3:32 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Matthew Garrett <mjg@redhat.com> writes:
>
>> On Fri, May 14, 2010 at 02:20:43PM -0600, Paul Walmsley wrote:
>>> Hello,
>>>
>>> On Mon, 3 May 2010, Matthew Garrett wrote:
>>>
>>> > I agree that the runtime scenario is a far more appealing one from an
>>> > aesthetic standpoint, but so far we don't have a very compelling
>>> > argument for dealing with the starting and stopping of userspace.
>>>
>>> The problem of how to start and stop (some) userspace is not specifical=
ly
>>> system power management-related, nor top-down, /sys/power/state-suspend
>>> related. =A0PM is just one potential user.
>>>
>>> It's hard to see how the Android opportunistic suspend approach would be
>>> useful for the other use-cases (e.g., checkpoint/restart). =A0On the ot=
her
>>> hand, it's easier to see how something like freezer cgroups could be
>>> useful for system power management and checkpoint/restart.
>>
>> And difficult to see how to implement something using freezer cgroups
>> that actually works in this case. Look, I don't want to sound like I
>> have a one-track mind or anything, but all of these arguments would be
>> significantly more compelling if someone would actually provide a
>> concrete implementation proposal that deals with the set of use-cases
>> that Google's implementation does and which doesn't make anyone cry.
>
> That might be possible if this "set of use-cases" was available
> someplace. =A0At least I haven't seen it, and would expect it to be in
> the docs included with patch 1.
>
> Another likely reason that that there hasn't been an alternate
> proposal (at least from some of us that are raising concerns) is
> because we already have a working solution to dynamic, system-wide PM
> that is 1) already in mainline and 2) shipping on consumer devices
> with very strict power budgets (as already pointed out in detail by
> Paul[2].)
>
> Yes, "excruciatingly bad" apps can kill PM on these systems since
> anyone can write apps, but the same is true on an opporunistic-suspend
> based system since any app could hold a suspend blocker whenever it
> wants.
>

No, apps need permission to block suspend.

-- =

Arve Hj=F8nnev=E5g
