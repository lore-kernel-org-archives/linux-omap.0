From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: suspend blockers & Android integration
Date: Mon, 7 Jun 2010 16:34:29 -0700
Message-ID: <AANLkTilKcGdOgi3HdLq_UrqI-VthqC50QnM5WOvCg_rQ@mail.gmail.com>
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
	<alpine.LFD.2.00.1006060148470.2933@localhost.localdomain>
	<AANLkTikdM79nmARagK9gLveMWEiT6rlk44UELes1k8Ch@mail.gmail.com>
	<alpine.LFD.2.00.1006061202351.2933@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.00.1006061202351.2933@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, tytso@mit.edu, Brian Swetland <swetland@google.com>, Neil Brown <neilb@suse.de>, Alan Stern <stern@rowland.harvard.edu>, Felipe Balbi <felipe.balbi@nokia.com>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, James Bottomley <James.Bottomley@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, Kevin Hilman <khilman@deeprootsystems.com>, "H. Peter Anvin" <hpa@zytor.com>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-omap@vger.kernel.org

2010/6/6 Thomas Gleixner <tglx@linutronix.de>:
> On Sat, 5 Jun 2010, Arve Hj=F8nnev=E5g wrote:
>> 2010/6/5 Thomas Gleixner <tglx@linutronix.de>:
>> > On Sat, 5 Jun 2010, Arve Hj=F8nnev=E5g wrote:
>> >> 2010/6/5 Thomas Gleixner <tglx@linutronix.de>:
>> >> > On Sat, 5 Jun 2010, Arve Hj=F8nnev=E5g wrote:
>> >> >> >> > That download might take a minute or two, but that's not =
an
>> >> >> >> > justification for the crapplication to run unconfined and=
 prevent
>> >> >> >> > lower power states.
>> >> >> >> >
>> >> >> >>
>> >> >> >> I agree, but this is not a simple problem to solve.
>> >> >> >
>> >> >> > Not with suspend blockers, but with cgroup confinement of cr=
ap, it's
>> >> >> > straight forward.
>> >> >> >
>> >> >>
>> >> >> I don't think is is straight forward. If the a process in the =
frozen
>> >> >> group holds a resource that a process in the unfrozen group ne=
eds, how
>> >> >> do deal with that?
>> >> >
>> >> > I'm going to fix the framework which puts the group into freeze=
 state
>> >> > w/o making sure that there is no held shared resource. Come on =
it's
>> >> > not rocket science.
>> >> >
>> >>
>> >> I'm not sure which framework you are talking about here, but I do=
n't
>> >> think there is a single framework that knows about all shared
>> >> resources.
>> >
>> > Damn, it's not me talking about "our framework", you are mentionin=
g
>> > when it fits your needs.
>>
>> You said you were going to fix the framework. I did know if you were
>> talking about the cgroup framework, or the android user-space
>> frameworks. I don't think either has knowledge about all shared
>> resources.
>
> The cgroup freezer makes sure that there are no in kernel resources
> blocked. Of course the user space side has to do the same and it's no=
t
> rocket science.
>

It is much easier to make sure there are no kernel resources held than
that there are no resources held in user-space. The kernel threads
have to return to a safe location before they get frozen, where user
threads are just frozen wherever they are.

--=20
Arve Hj=F8nnev=E5g
