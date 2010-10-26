From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] PERF(kernel): Cleanup power events V2
Date: Tue, 26 Oct 2010 13:21:29 +0200
Message-ID: <20101026112129.GB27258@elte.hu>
References: <1287488171-25303-3-git-send-email-trenn@suse.de>
 <1288049630-10947-1-git-send-email-trenn@suse.de>
 <20101026071020.GC13036@elte.hu>
 <AANLkTiknZ5t24j44hhDrbocJSJv1d=9LtvcSrd2QPcq2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:35991 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758990Ab0JZLW3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Oct 2010 07:22:29 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTiknZ5t24j44hhDrbocJSJv1d=9LtvcSrd2QPcq2@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Thomas Renninger <trenn@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Frank Eigler <fche@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Kevin Hilman <khilman@deeprootsystems.com>, Peter Zijlstra <peterz@infradead.org>, linux-omap@vger.kernel.org, rjw@sisk.pl, linux-pm@lists.linux-foundation.org, linux-trace-users@vger.kernel.org, Pierre Tardy <tardyp@gmail.com>, Frederic Weisbecker <fweisbec@gmail.com>, Tejun Heo <tj@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arjan van de Ven <arjan@linux.intel.com>


* Jean Pihet <jean.pihet@newoldbits.com> wrote:

> Ingo,
>=20
> On Tue, Oct 26, 2010 at 9:10 AM, Ingo Molnar <mingo@elte.hu> wrote:
> >
> > * Thomas Renninger <trenn@suse.de> wrote:
> >
> >> Changes in V2:
> >> =A0 - Introduce PWR_EVENT_EXIT instead of 0 to mark non-power stat=
e
> >> =A0 - Use u32 instead of u64 for cpuid, state which is by far enou=
gh
>=20
> ...
>=20
> >>
> >> +#define PWR_EVENT_EXIT 0xFFFFFFFF
> >
> > Shouldnt this be part of the POWER_ enum? (and you can write -1 the=
re)
> >
> >> +#ifndef _TRACE_POWER_ENUM_
> >> +#define _TRACE_POWER_ENUM_
> >> +enum {
> >> + =A0 =A0 POWER_NONE =3D 0,
> >> + =A0 =A0 POWER_CSTATE =3D 1,
> >> + =A0 =A0 POWER_PSTATE =3D 2,
> >> +};
> >> +#endif
> >
> > Since we are cleaning up all these events, those enum definitions d=
ont really look
> > logical. For example, what is 'POWER_NONE'? Can a CPU have 'no powe=
r'?
>
> The enum belongs to the deprecated API so I would rather not touch it=
=2E
> Keeping the deprecated code isolated will make it easier to remove
> later.

So what will replace it? We still have a state field.

Passing in platform specific codes is a step backwards.

> >> +TRACE_EVENT(machine_suspend,
> >> +
> >> + =A0 =A0 TP_PROTO(unsigned int state),
> >> +
> >> + =A0 =A0 TP_ARGS(state),
> >> +
> >> + =A0 =A0 TP_STRUCT__entry(
> >> + =A0 =A0 =A0 =A0 =A0 =A0 __field( =A0 =A0 =A0 =A0u32, =A0 =A0 =A0=
 =A0 =A0 =A0state =A0 =A0 =A0 =A0 =A0 )
> >> + =A0 =A0 ),
> >
> > Hm, this event is not used anywhere in the submitted patches. Where=
 is the patch
> > that adds usage, and what are the possible values for 'state'?
>
> This will come as a separate patch, which fits all platforms. Cf.
> http://marc.info/?l=3Dlinux-omap&m=3D128620575300682&w=3D2.
> The state field is of type suspend_state_t, cf. include/linux/suspend=
=2Eh

Ok, that's at least generic. Needs the review of Rafael, to determine w=
hether this=20
state value is all we want to know when we enter suspend.

Thanks,

	Ingo
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
