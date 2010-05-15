From: Brian Swetland <swetland@google.com>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 6)
Date: Fri, 14 May 2010 20:40:08 -0700
Message-ID: <AANLkTinwJdPneNSlAeTml5fHW2LFy53Dz3DRf95y1Bcl@mail.gmail.com>
References: <AANLkTil-Ky5L84JF7xn6su8VMtglBpZwCNIh7VgBiHgL@mail.gmail.com>
	 <Pine.LNX.4.44L0.1005142256070.11498-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1005142256070.11498-100000@netrider.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Tony Lindgren <tony@atomide.com>, Matthew Garrett <mjg@redhat.com>, Paul Walmsley <paul@pwsan.com>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Kernel development list <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>, magnus.damm@gmail.com, Theodore Ts'o <tytso@mit.edu>, mark gross <mgross@linux.intel.com>, Arjan van de Ven <arjan@infradead.org>, Geoff Smith <geoffx.smith@intel.com>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <b-cousson@ti.com>, linux-omap@vger.kernel.org, Vitaly Wool <vitalywool@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: linux-omap@vger.kernel.org

On Fri, May 14, 2010 at 7:58 PM, Alan Stern <stern@rowland.harvard.edu>=
 wrote:
> On Fri, 14 May 2010, Brian Swetland wrote:
>
>> It provides useful functionality -- you apparently disagree, but the
>> wakelock/suspendblock model is in use, shipping, and solving problem=
s
>> for quite a lot of android devices that have been shipping for a whi=
le
>> now. =C2=A0We actively go to lowest power state in idle (on omap, ms=
m,
>> etc), and use drivers that aggressively declock and depower modules
>> (similar to runtime pm), but we have found that using the
>> opportunistic suspend model combined with wakelocks allows us to
>> attain even lower average power consumption in always-connected,
>> actively-syncing devices.
>
> Can you explain this in more detail? =C2=A0Are you saying that some d=
evices
> go on generating interrupts and causing timers to be scheduled, even
> though what they're doing isn't important enough to prevent the syste=
m
> from powering down?

In tickless mode, the time until next timer is a signed int, so the
longest the kernel will ever sleep is ~2 seconds at a go.  In
practice, userspace entities often have polling behavior that can
trigger more often than that, and I've observed some kernel periodic
timers (haven't cataloged them recently) that happen more often than
once a second.

When we go to full suspend, we know that only specific wakeup sources
(keyboard gpios, baseband voice/ip events, rtc alarms, etc) are going
to wake us up.

Brian
