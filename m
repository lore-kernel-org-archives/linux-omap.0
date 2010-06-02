From: "Gross, Mark" <mark.gross@intel.com>
Subject: RE: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Wed, 2 Jun 2010 16:15:05 -0700
Message-ID: <CA1BBBBC9359F04AA639128AC0D5D1E9692ABC92@orsmsx502.amr.corp.intel.com>
References: <20100527232357.6d14fdb2@lxorguk.ukuu.org.uk>
	<20100601135102.GA8098@srcf.ucam.org>
	<1275426085.21962.967.camel@mulgrave.site>	<201006020024.14220.rjw@sisk.pl>
	<1275431816.21962.1108.camel@mulgrave.site>
	<AANLkTikObnAZbyOxeYAhXcEbimO3XTTO-HlC9CD_HH6t@mail.gmail.com>
	<1275451342.21962.1777.camel@mulgrave.site>
	<AANLkTilRcFZyYa-0HlaM-6IEZSyar3S9S_cCWSFax2Zo@mail.gmail.com>
	<1275491111.2799.110.camel@mulgrave.site>
	<20100602214748.7742e3ae@schatten.dmk.lab>
	<1275511271.2799.516.camel@mulgrave.site>
 <20100603010607.5baf82a6@schatten.dmk.lab>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100603010607.5baf82a6@schatten.dmk.lab>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Mickler <florian@mickler.org>, James Bottomley <James.Bottomley@suse.de>
Cc: =?iso-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>, Neil Brown <neilb@suse.de>, "tytso@mit.edu" <tytso@mit.edu>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>
List-Id: linux-omap@vger.kernel.org



>-----Original Message-----
>From: Florian Mickler [mailto:florian@mickler.org]
>Sent: Wednesday, June 02, 2010 4:06 PM
>To: James Bottomley
>Cc: Arve Hj=F8nnev=E5g; Neil Brown; tytso@mit.edu; Peter Zijlstra; LKM=
L; Alan
>Cox; Gross, Mark; Thomas Gleixner; Linux OMAP Mailing List; Linux PM;
>felipe.balbi@nokia.com
>Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
>
>On Wed, 02 Jun 2010 15:41:11 -0500
>James Bottomley <James.Bottomley@suse.de> wrote:
>
>> On Wed, 2010-06-02 at 21:47 +0200, Florian Mickler wrote:
>> > On Wed, 02 Jun 2010 10:05:11 -0500
>> > James Bottomley <James.Bottomley@suse.de> wrote:
>> >
>> > > On Tue, 2010-06-01 at 21:41 -0700, Arve Hj=F8nnev=E5g wrote:
>> > > > No, they have to be two separate constraints, otherwise a
>constraint
>> > > > to block suspend would override a constraint to block a low po=
wer
>idle
>> > > > mode or the other way around.
>> > >
>> > > Depends.  If you block the system from going into low power idle=
,
>does
>> > > that mean you still want it to be fully suspended?
>> > >
>> > > If yes, then we do have independent constraints.  If not, they h=
ave a
>> > > hierarchy:
>> > >
>> > >       * Fully Interactive (no low power idle or suspend)
>> > >       * Partially Interactive (may go into low power idle but no=
t
>> > >         suspend)
>> > >       * None (may go into low power idle or suspend)
>> > >
>> > > Which is expressable as a ternary constraint.
>> > >
>> > > James
>> > >
>> >
>> > But unblocking suspend at the moment is independent to getting idl=
e.
>> > If you have the requirement to stay in the highest-idle level (i.e=
=2E
>> > best latency you can get) that does not (currently) mean, that you=
 can
>> > not suspend.
>>
>> I don't understand that as a reason.  If we looks at this a qos
>> constraints, you're saying that the system may not drop into certain=
 low
>> power states because it might turn something off that's currently be=
ing
>> used by a driver or a process.  Suspend is certainly the lowest stat=
e of
>> that because it turns everything off, why would it be legal to drop =
into
>> that?
>>
>> I also couldn't find this notion of separation of idleness power fro=
m
>> suspend blocking in the original suspend block patch set ... if you =
can
>> either tell me where it is, or give me an example of the separated u=
se
>> cases, I'd understand better.
>>
>> > To preserve that explicit fall-through while still having working
>> > run-time-powermanagement I think the qos-constraints need to be
>> > separated.
>>
>> OK, as above, why?  or better yet, just give an example.
>
>Hm. Maybe it is me who doesn't understand.
>
>With proposed patchset:
>1. As soon as we unblock suspend we go down.  (i.e. suspending)
>2. While suspend is blocked, the idle-loop does it's things. (i.e.
>runtime power managment -> can give same power-result as suspend)
>
>possible cases:
>1:
>   - qos-latency-constraints: 1ms,  [here: forbids anything other than
>     C1 idle state.]
>   - suspend is blocked
>
>2: - qos latency-constraints: as in 1
>   - suspend unblocked
>
>3: - qos latency-constraints: infinity, cpu in lowest power state.
>   - suspend is blocked
>
>4: - qos latency-constraints: infinity, cpu in lowest power state.
>   - suspend unblocked
>
>
>in case 2 and 4 we would suspend, regardeless of the qos-latency.
>
>in case 1 and 3 we would stay awake, regardeless of the qos-latency
>constraint.
>
>
>If only one constraint, then case 2 (or 3) wouldn't be possible. But i=
t
>is possible now.
>
>A possible use case as an example?
>(hmm... i'm trying my imagination hard now):
>	Your sound needs low latency, so that could be a cause for the
>	qos-latency constraint.
>
>	And unblocking suspend could nonetheless happen:
>	For example... you have an firefox open and don't want to
>	prevent suspend for that case when the display is turned off
>
>
[mtg: ] This has been a pain point for the PM_QOS implementation.  They=
 change the constrain back and forth at the transaction level of the i2=
c driver.  The pm_qos code really wasn't made to deal with such hot pat=
h use, as each such change triggers a re-computation of what the aggreg=
ate qos request is.

We've had a number of attempts at fixing this, but I think the proper f=
ix is to bolt a "disable C-states > x" interface into cpu_idle that byp=
ases pm_qos altogether.  Or, perhaps add a new pm_qos API that does the=
 equivalent operation, overriding whatever constraint is active.

--mgross
