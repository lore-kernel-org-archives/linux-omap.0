From: Kevin Hilman <khilman@ti.com>
Subject: Re: DSS2/PM on 3.2 broken?
Date: Thu, 19 Jan 2012 16:22:37 -0800
Message-ID: <87ty3rql2q.fsf@ti.com>
References: <20120113222045.37f9b4ec@notabene.brown>
	<1326870839.1954.23.camel@deskari>
	<20120118221538.342b4782@notabene.brown>
	<1326886940.1999.5.camel@lappy>
	<20120119073032.74cc0992@notabene.brown>
	<WC20120119101721.07072A@terrafix.co.uk>
	<1326969658.1935.24.camel@deskari>
	<WC20120119112911.670749@terrafix.co.uk>
	<1326973019.7926.7.camel@lappy>
	<WC20120119122128.020787@terrafix.co.uk> <87y5t3trek.fsf@ti.com>
	<20120120080508.0dc0c758@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:52678 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756222Ab2ATAWl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Jan 2012 19:22:41 -0500
Received: by ggki1 with SMTP id i1so11260ggk.41
        for <linux-omap@vger.kernel.org>; Thu, 19 Jan 2012 16:22:40 -0800 (PST)
In-Reply-To: <20120120080508.0dc0c758@notabene.brown> (NeilBrown's message of
	"Fri, 20 Jan 2012 08:05:08 +1100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Joe Woodward <jw@terrafix.co.uk>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Paul Walmsley <paul@pwsan.com>, t-kristo@ti.com, govindraj.r@ti.com, linux-omap@vger.kernel.org

NeilBrown <neilb@suse.de> writes:

> On Thu, 19 Jan 2012 11:37:39 -0800 Kevin Hilman <khilman@ti.com> wrote:
>
>> "Joe Woodward" <jw@terrafix.co.uk> writes:
>> 
>> [...]
>> 
>> > If I do (either from the console or via a button press on the screen)
>> > then I never get a SYNC_LOST.
>> >
>> >   echo 0 > /sys/devices/omapdss/display0/enabled
>> >   echo 1 > /sys/devices/omapdss/display0/enabled
>> >
>> > Just trying to think of some ideas that may be affecting the DSS...
>> >   - Could it to be to do with the GPIO being used as a wake source (i.e. does the GPIO driver do runtime_pm properly?)?
>> >   - Could it to be to do with the UART as it seems to fix itself whenever a character is pressed?
>> >   - Could it to be to do with the ordering in which drivers are resumed?
>> 
>> Here's my guess/hunch as to why the UART wakeup helps and GPIO doesn't.
>> 
>> The UART's are idled using timeouts, so after any activity (including a
>> wakeup) the UART timeout will not alow the UARTs to idle (and thus the
>> system to hit low power states) for a given timeout period.
>
> While I agree with that, I'm wondering if there might be something else odd
> relating to the UARTs that we haven't spotted yet.

I suspect the problem for both is constraints that aren't stated
explicitly.

> I'm chasing done the different problem of HDQ not coping with CPUIDLE but I
> think it is very likely to have a similar root cause, as HDQ goes wrong at
> the same time that DSS goes wrong, and is a vaguely similar way.
>
> I just tried compiling omap_hwmod.c with "#define DEBUG" and got some strange
> results.

Strange indeed.

I assume you are you using the runtime PM converted driver from Paul?  I
tried that branch on my 3530/Overo (console on UART3) and didn't see any
nul's on my UART3 console.  

[...]

> The other thing I discovered is that when I set the uart 'sleep_timeout' to 5
> (all uarts) so that CPUIDLE can let CORE enter the lower power states, I get
> a fairly steady stream of:
>
> [ 1168.490478] omap_hwmod: uart1: enabling
> [ 1168.490509] omap_hwmod: uart1: enabling clocks
> [ 1168.490539] omap_hwmod: uart2: enabling
> [ 1168.490539] omap_hwmod: uart2: enabling clocks
> [ 1168.490631] omap_hwmod: uart3: enabling
> [ 1168.490661] omap_hwmod: uart3: enabling clocks
> [ 1168.490661] omap_hwmod: uart4: enabling
> [ 1168.490692] omap_hwmod: uart4: enabling clocks
> [ 1168.578796] omap_hwmod: uart3: idling
> [ 1168.578796] omap_hwmod: uart3: disabling clocks
> [ 1168.578826] omap_hwmod: uart4: idling
> [ 1168.578826] omap_hwmod: uart4: disabling clocks
> [ 1168.578857] omap_hwmod: uart1: idling
> [ 1168.578857] omap_hwmod: uart1: disabling clocks
> [ 1168.578887] omap_hwmod: uart2: idling
> [ 1168.578887] omap_hwmod: uart2: disabling clocks
> [ 1168.714263] omap_hwmod: uart1: enabling
> [ 1168.714294] omap_hwmod: uart1: enabling clocks
> [ 1168.714324] omap_hwmod: uart2: enabling
> [ 1168.714324] omap_hwmod: uart2: enabling clocks
> [ 1168.714416] omap_hwmod: uart3: enabling
> [ 1168.714447] omap_hwmod: uart3: enabling clocks
> [ 1168.714447] omap_hwmod: uart4: enabling
> [ 1168.714477] omap_hwmod: uart4: enabling clocks
> [ 1168.803344] omap_hwmod: uart3: idling
> [ 1168.803344] omap_hwmod: uart3: disabling clocks
> [ 1168.803375] omap_hwmod: uart4: idling
> [ 1168.803375] omap_hwmod: uart4: disabling clocks
> [ 1168.851257] omap_hwmod: uart3: enabling
> [ 1168.851287] omap_hwmod: uart3: enabling clocks
> [ 1168.851318] omap_hwmod: uart4: enabling
> [ 1168.851318] omap_hwmod: uart4: enabling clocks
> [ 1168.885955] omap_hwmod: uart3: idling
> [ 1168.885986] omap_hwmod: uart3: disabling clocks
> [ 1168.885986] omap_hwmod: uart4: idling
> [ 1168.886016] omap_hwmod: uart4: disabling clocks
> [ 1168.886383] omap_hwmod: uart3: enabling
> [ 1168.886383] omap_hwmod: uart3: enabling clocks
> [ 1168.886383] omap_hwmod: uart4: enabling
> [ 1168.886413] omap_hwmod: uart4: enabling clocks
> [ 1168.944885] omap_hwmod: uart3: idling
> [ 1168.944915] omap_hwmod: uart3: disabling clocks

At least this part is expected.  

In the kernel you're using the UART clocks are enabled/disabled during
the idle path depending on the low-power state being targetted, so would
expect to see lots of UART clock gating going on.

Kevin

> It seems to mostly be uart3 and uart4.
> If there is any interaction between the uart clock and the hdq clock, this
> could explain why the HDQ gets confused when all this is happening.
>
> And if there is a connection there, then there could also be a connection
> with a DSS clock which could be confusing it.
>
> I admit this is largely surmise and hypothesis - but there is definitely
> something odd here!
>
> Thanks,
> NeilBrown
