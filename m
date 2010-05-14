From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 6)
Date: Fri, 14 May 2010 12:25:26 +0900
Message-ID: <AANLkTilL2mvqpwirTfJRWZFdrFJvSihnaY8-xao4pLpH@mail.gmail.com>
References: <20100513191717.GA3428@atomide.com>
	 <Pine.LNX.4.44L0.1005131729510.1731-100000@iolanthe.rowland.org>
	 <20100513214739.GM3428@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100513214739.GM3428@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Paul Walmsley <paul@pwsan.com>, =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Kernel development list <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Kevin Hilman <khilman@deeprootsystems.com>, Theodore Ts'o <tytso@mit.edu>, mark gross <mgross@linux.intel.com>, Arjan van de Ven <arjan@infradead.org>, Geoff Smith <geoffx.smith@intel.com>, Brian Swetland <swetland@google.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <mjg@redhat.com>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>, linux-omap@vger.kernel.org, Vitaly Wool <vitalywool@gmail.com>, Linus Walleij <linus.walleij@ericsson.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: linux-omap@vger.kernel.org

On Fri, May 14, 2010 at 6:47 AM, Tony Lindgren <tony@atomide.com> wrote=
:
> * Alan Stern <stern@rowland.harvard.edu> [100513 14:32]:
>> On Thu, 13 May 2010, Tony Lindgren wrote:
>>
>> > The difference between echo mem > /sys/power/state and suspend blo=
cks
>> > is that with suspend blocks the system keeps running.
>>
>> Irrelevant. =A0Paul wasn't talking about the suspend blockers; he wa=
s
>> talking about opportunistic suspend. =A0So what's the difference bet=
ween
>> opportunistic suspend and "echo mem >/sys/power/state"? =A0Especiall=
y
>> when suspend blockers aren't being used?
>
> Opportunistic suspend is really trying to do runtime PM, see below.
>
>> > And that's why
>> > it should be handled by runtime power management instead.
>>
>> Runtime PM is not capable of freezing userspace and shutting down CP=
Us.
>> More or less by definition -- if it could then it wouldn't be "runti=
me"
>> any more, since the processor wouldn't be running.
>
> Not true. We are already powering off CPUs and rebooting them for
> at least omaps in every idle loop using cpuidle. The memory stays on.

I agree with you Tony. I thought shutting down CPUs for power
managment purposes could be done without freezing user space. At least
that's what we do today with SH-Mobile.

I don't dislike the idea of freezing a misbehaing user space app, but
I wonder if hardware platforms really need this. I think hardware
requirements and software requirements should be kept separated.

There seem to be some confusion regarding what Runtime PM can and can
not do. For SH-Mobile we use Runtime PM to manage the clocks and power
supply to on-chip I/O devices, and from CPU idle context we check the
state of the Runtime PM devices and decide what level of CPU deep
sleep we can enter. You can call this system CPU deep sleep if you'd
like depending on the dependencies are layed out on your hardware
platform.

=46or CPU deep sleep we more or less always stop the clock so we need t=
o
put the memory in self-refresh to avoid loosing memory contents. In
some cases the deep sleep means that the power to the CPU core will be
cut, so a more advanced context save/restore path needs to be used.

Still not sure how the system wide suspend is different from Runtime
PM and CPUidle from the hardware perspective...

/ magnus
