From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Wed, 26 May 2010 13:12:37 +0200
Message-ID: <1274872357.27810.16.camel@twins>
References: <1274482015-30899-1-git-send-email-arve@android.com>
	 <1274863655.5882.4875.camel@twins>
	 <AANLkTinN6MKvCEhPkbYQRD2gu-mGXdNW9asRsTuKN3_Y@mail.gmail.com>
	 <1274867106.5882.5090.camel@twins>
	 <AANLkTiksR3YozbBH0Iv5kNsQkEGKCH1APCvn_s6LkjV9@mail.gmail.com>
	 <1274868593.5882.5185.camel@twins>
	 <AANLkTinuxCbeBmxIR7b_1OtrqQYJCamiDZJbnNTih1Fb@mail.gmail.com>
	 <1274869966.5882.5262.camel@twins>
	 <AANLkTikRMBkoFxgaKsxMJ2lOMomTXpiHJDk3rVt0EtwM@mail.gmail.com>
	 <1274870970.5882.5311.camel@twins>
	 <AANLkTinlxsokwralwRAL9_YRQ7-SZUSvrGHTlRISA9bC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTinlxsokwralwRAL9_YRQ7-SZUSvrGHTlRISA9bC@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arve =?ISO-8859-1?Q?Hj=F8nnev=E5g?= <arve@android.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Kevin Hilman <khilman@deeprootsystems.com>, felipe.balbi@nokia.com, Linux PM <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>
List-Id: linux-omap@vger.kernel.org

On Wed, 2010-05-26 at 03:53 -0700, Arve Hj=C3=B8nnev=C3=A5g wrote:=20
> 2010/5/26 Peter Zijlstra <peterz@infradead.org>:
> > On Wed, 2010-05-26 at 03:40 -0700, Arve Hj=C3=B8nnev=C3=A5g wrote:
> >> 2010/5/26 Peter Zijlstra <peterz@infradead.org>:
> >> > On Wed, 2010-05-26 at 03:25 -0700, Arve Hj=C3=B8nnev=C3=A5g wrot=
e:
> >> >
> >> >> and on systems where the
> >> >> same power state can be used from idle and suspend, we use susp=
end so
> >> >> we can stay in the low power state for minutes to hours instead=
 of
> >> >> milliseconds to seconds.
> >> >
> >> > So don't you think working on making it possible for systems to =
be idle
> >> > _that_ long would improve things for everybody? as opposed to th=
is
> >> > auto-suspend which only improves matters for those that (can) us=
e it?
> >>
> >> I'm not preventing anyone from working on improving this. Currentl=
y
> >> both the kernel and our user-space code polls way too much. I don'=
t
> >> think it is reasonable to demand that no one should run any user-s=
pace
> >> code with periodic timers when we have not even fixed the kernel t=
o
> >> not do this.
> >
> > All I'm saying is that merging a stop-gap measure will decrease the
> > urgency and thus the time spend fixing the actual issues while addi=
ng
> > the burden of maintaining this stop-gap measure.
> >
>=20
> Fixing the actually issue means fixing all user-space code, and
> replacing most x86 hardware. I don't think keeping this feature out o=
f
> the kernel will significantly accelerate this.

I don't think x86 is relevant anyway, it doesn't suspend/resume anywher=
e
near fast enough for this to be usable.

My laptop still takes several seconds to suspend (Lenovo T500), and
resume (aside from some userspace bustage) takes the same amount of
time. That is quick enough for manual suspend, but I'd hate it to try
and auto-suspend.

Getting longer idle periods however is something that everybody benefit=
s
from. On x86 we're nowhere close to hitting the max idle time of the
platform, you get _tons_ of wakeups on current 'desktop' software.

But x86 being a PITA shouldn't stop people from working on this, there'=
s
plenty other architectures out there, I remember fixing a NO_HZ bug wit=
h
davem on sparc64 because his niagra had cores idling for very long time=
s
indeed.=20

So yes, I do think merging this will delay the effort in fixing
userspace, simply because all the mobile/embedded folks don't care abou=
t
it anymore.
