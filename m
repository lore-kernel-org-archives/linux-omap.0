From: Brian Swetland <swetland@google.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Wed, 26 May 2010 03:40:01 -0700
Message-ID: <AANLkTimQ_wahC5gnlip3APFzzfuCKab7y6OdlRyh2MWx@mail.gmail.com>
References: <1274482015-30899-1-git-send-email-arve@android.com>
	<201005242049.18920.rjw@sisk.pl>
	<87wrusvrqe.fsf@deeprootsystems.com>
	<201005250138.16293.rjw@sisk.pl>
	<1274863655.5882.4875.camel@twins>
	<AANLkTinN6MKvCEhPkbYQRD2gu-mGXdNW9asRsTuKN3_Y@mail.gmail.com>
	<1274867106.5882.5090.camel@twins>
	<AANLkTiksR3YozbBH0Iv5kNsQkEGKCH1APCvn_s6LkjV9@mail.gmail.com>
	<1274868593.5882.5185.camel@twins>
	<AANLkTinuxCbeBmxIR7b_1OtrqQYJCamiDZJbnNTih1Fb@mail.gmail.com>
	<1274869966.5882.5262.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1274869966.5882.5262.camel@twins>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Kevin Hilman <khilman@deeprootsystems.com>, felipe.balbi@nokia.com, Linux PM <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>
List-Id: linux-omap@vger.kernel.org

On Wed, May 26, 2010 at 3:32 AM, Peter Zijlstra <peterz@infradead.org> =
wrote:
> On Wed, 2010-05-26 at 03:25 -0700, Arve Hj=C3=B8nnev=C3=A5g wrote:
>
>> and on systems where the
>> same power state can be used from idle and suspend, we use suspend s=
o
>> we can stay in the low power state for minutes to hours instead of
>> milliseconds to seconds.
>
> So don't you think working on making it possible for systems to be id=
le
> _that_ long would improve things for everybody? as opposed to this
> auto-suspend which only improves matters for those that (can) use it?

As we've stated a number of times in the several weeks of discussion
(this time around) of this patchset, we are all in favor of improving
runtime pm, finding and resolving issues that prevent idle, and
heading toward ever lower power states in idle -- after all, this
benefits our battery life in the cases when the system is not
suspended as well as moving us closer to a future where the power
savings between actively entering suspend and not doing so approach
zero.  Aggressively entering the lowest possible power state at all
times is our goal here.

At the moment, the power savings from opportunistic suspend do
directly lead to improved battery life, and there are some advantages
to this model in the face of a non-optimal userspace (as we encounter
in a world where there are not restrictions on what applications users
may install and run).

Brian
