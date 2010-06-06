From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: suspend blockers & Android integration
Date: Sat, 5 Jun 2010 18:24:43 -0700
Message-ID: <AANLkTin5iXbnkqQnrkGRiOUvqcRAZJMNV4VoOUmZ6lZh@mail.gmail.com>
References: <20100603193045.GA7188@elte.hu>
	<20100603232302.GA16184@elte.hu>
	<1275644619.27810.39462.camel@twins>
	<201006050138.30859.rjw@sisk.pl>
	<alpine.LFD.2.00.1006050148080.2933@localhost.localdomain>
	<AANLkTikGDSzaENwg_0BAtsYf3ulGd_6sGPR30WsvUxMi@mail.gmail.com>
	<alpine.LFD.2.00.1006050246350.2933@localhost.localdomain>
	<AANLkTikU21xF49Z-_Lnrq7U7buNmqw_gyEEST8LuN24z@mail.gmail.com>
	<alpine.LFD.2.00.1006051736040.2933@localhost.localdomain>
	<AANLkTinD39rI47innPbGz1Gi8PsXV5HqkmaQuJ70oQ63@mail.gmail.com>
	<alpine.LFD.2.00.1006052348200.2933@localhost.localdomain>
	<AANLkTikmWDHYJ8wWF2cZapbkHHjV09R39I37yvQXFmor@mail.gmail.com>
	<alpine.LFD.2.00.1006060208320.2933@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.00.1006060208320.2933@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, tytso@mit.edu, Brian Swetland <swetland@google.com>, Neil Brown <neilb@suse.de>, Alan Stern <stern@rowland.harvard.edu>, Felipe Balbi <felipe.balbi@nokia.com>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, James Bottomley <James.Bottomley@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, Kevin Hilman <khilman@deeprootsystems.com>, "H. Peter Anvin" <hpa@zytor.com>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-omap@vger.kernel.org

2010/6/5 Thomas Gleixner <tglx@linutronix.de>:
> On Sat, 5 Jun 2010, Arve Hj=F8nnev=E5g wrote:
>> 2010/6/5 Thomas Gleixner <tglx@linutronix.de>:
>> >> > Well, that's simply an application bug which sucks battery with=
 or
>> >> > without suspend blockers. So it's unrelated to the freezing of
>> >> > untrusted apps while a trusted app still works in the backgroun=
d
>> >> > before allowing the machine to suspend.
>> >> >
>> >>
>> >> It is not unrelated if the trusted app has stopped working but st=
ill
>> >> blocks suspend. The battery drains when you combine them.
>> >
>> > What you are describing is a problem which is not solvable either =
way.
>> > If you take the lock and do not release it you're not going to
>> > suspend. I never claimed that any other mechanism resolves this.
>> >
>> Whether you claimed it or not, this is the only case where using
>> cgroups would have a significant power saving over what we get with
>> suspend. The trusted app is idle and the untrusted app is frozen, so
>> we enter a low power mode from idle.
>
> Nothing else was what I said and depending on the usage pattern this
> can be significant. Just you converted a perfectly sensible technical
> argument into a quibble about BUGs in applicatins which are not
> confinable by defintion.
>
>> > But this is not related to the fact that freezing crap while runni=
ng a
>> > sane background task is going to save you power vs. an approach wh=
ere
>> > running a sane background task allows crap to consume power unconf=
ined
>> > until it is done.
>> >
>> If the task that is blocking suspend is using the cpu anyway, then t=
he
>> bad app does not increase the power consumption nearly as much as if
>> the task that blocked suspend is idle.
>
> That's utter bullshit. If the app missed to release the supsend
> blocker then your crappy "while(1);" app is killing you in no time,
> while the same frozen crappy "while(1);" does no harm at all.
>
This is the bug I described above. If the app that blocked suspend did
not release the suspend blocker and went idle, then another while(1)
app will drain the battery. If the app that blocked suspend only
blocked suspend while it needs to run (which is the typical reason to
block suspend) then the system is not idle anyway and the impact of
the while(1) app is much less severe.

--=20
Arve Hj=F8nnev=E5g
