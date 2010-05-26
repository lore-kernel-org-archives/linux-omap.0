From: Brian Swetland <swetland@google.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Wed, 26 May 2010 02:49:16 -0700
Message-ID: <AANLkTinyVDKriOrSAVV36vwC8Uy26F5WFoNJBv19va5c@mail.gmail.com>
References: <1274482015-30899-1-git-send-email-arve@android.com>
	<201005242049.18920.rjw@sisk.pl>
	<87wrusvrqe.fsf@deeprootsystems.com>
	<201005250138.16293.rjw@sisk.pl>
	<1274863655.5882.4875.camel@twins>
	<AANLkTinN6MKvCEhPkbYQRD2gu-mGXdNW9asRsTuKN3_Y@mail.gmail.com>
	<1274867106.5882.5090.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1274867106.5882.5090.camel@twins>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Kevin Hilman <khilman@deeprootsystems.com>, felipe.balbi@nokia.com, Linux PM <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>
List-Id: linux-omap@vger.kernel.org

On Wed, May 26, 2010 at 2:45 AM, Peter Zijlstra <peterz@infradead.org> =
wrote:
> On Wed, 2010-05-26 at 02:41 -0700, Arve Hj=C3=B8nnev=C3=A5g wrote:
>> On Wed, May 26, 2010 at 1:47 AM, Peter Zijlstra <peterz@infradead.or=
g> wrote:
>> > On Tue, 2010-05-25 at 01:38 +0200, Rafael J. Wysocki wrote:
>> >> > This of course will lead to a scattering of suspend blockers in=
to any
>> >> > drivers/subsystems considered "useful", which by looking throug=
h current
>> >> > Android kernels is many of them.
>> >>
>> >> That depends on the maintainers of these subsystems, who still ha=
ve the power
>> >> to reject requested changes.
>> >
>> > So as a scheduler maintainer I'm going to merge a patch that does =
a
>> > suspend_blocker when the runqueue's aren't empty... how about that=
?
>> >
>>
>> I don't know if you are serious, since the all the runqueues are nev=
er
>> empty while suspending, this would disable opportunistic suspend
>> altogether.
>
> So why again was this such a great scheme? Go fix your userspace to n=
ot
> not run when not needed.


Thanks for your constructive feedback.

Brian
