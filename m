From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Fri, 28 May 2010 04:05:51 -0700
Message-ID: <AANLkTim3CnUbovWTnN2OET76eLPMAeIVrEtEjkH_r1uL@mail.gmail.com>
References: <Pine.LNX.4.44L0.1005271344040.3239-100000@iolanthe.rowland.org>
	<20100527181433.GG3543@srcf.ucam.org>
	<20100527200313.5c532f2f@lxorguk.ukuu.org.uk>
	<201005280110.17075.rjw@sisk.pl>
	<20100528005045.6ea5feba@lxorguk.ukuu.org.uk>
	<AANLkTimqvMuMpB5E3tj58OtlRc-7mVaec-9EHAegywg7@mail.gmail.com>
	<20100528120445.245c7075@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100528120445.245c7075@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <mjg59@srcf.ucam.org>, Peter Zijlstra <peterz@infradead.org>, Alan Stern <stern@rowland.harvard.edu>, Thomas Gleixner <tglx@linutronix.de>, Paul@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

2010/5/28 Alan Cox <alan@lxorguk.ukuu.org.uk>:
>> This is a much harder question to answer that what we need to use
>> opportunistic suspend. The question we ask is more like this: "Is al=
l
>> important work complete?". In the simplest case these can be the sam=
e,
>
> I don't believe you can answer that question without telepathy and a
> crystal ball.
>
But we have answered this question.

> The application doesn't know because it has no idea how to balance
> conflicting resource demands or to infer the users requirements and
> wishes. Most apps will misbehave anyway.
>
> The OS doesn't know because it cannot tell what the app wants
>
> So at best you have a heuristic.
>
>> What happens if the user presses the button right before you set QoS
>> of 'user apps' to =A0QS_NONE?
>
> Read down a paragraph.
>
>> To me it looks like this solution would result in this sequence whic=
h
>> may ignore the button press:
>> =A0=A0 =A0 =A0 =A0Button pushed
>> =A0=A0 =A0 =A0 =A0Button driver sets QoS of app it wakes to QS_ABOVE=
SUSPEND
>> =A0=A0 =A0 =A0 =A0Set QoS of 'user apps' to QS_NONE
>>
>>
>> > =A0 =A0 =A0 =A0That would I think solve the reliable wakeup case a=
lthough
>> > =A0 =A0 =A0 =A0drivers raising a QoS parameter is a bit unusual in=
 the kernel.
>> > =A0 =A0 =A0 =A0That would at least however be specific to a few An=
droid drivers
>> > =A0 =A0 =A0 =A0and maybe a tiny amount of shared driver stuff so p=
robably not
>> > =A0 =A0 =A0 =A0unacceptable. (wake_up_pri(&queue, priority); isn't=
 going to
>> > =A0 =A0 =A0 =A0kill anyone is it - especially if it usually ignore=
s the
>> > =A0 =A0 =A0 =A0priority argument)
>>
>> Why is "wake_up_pri(&queue, priority)" more acceptable than "suspend=
_block(..."?
>
> We keep it kernel side
> It expresses policy and wishes rather than enforcing a behaviour.
>
> What for example does "suspend_block" mean on a virtual machine ?
>
> I would prefer "priority" was some kind of resource constraint model
> instead but I'm just trying to think how to be absolutely minimally
> invasible at this point.
>
>> What happens if the button press happend before this line:
>> > =A0 =A0 =A0 =A0count2 =3D tasks to QS_NONE | QS_NOTCHANGED
>> > =A0 =A0 =A0 =A0Screen off
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0Button Press
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0task to QS_ABOVESUSPEND
>> > =A0 =A0 =A0 =A0count =3D tasks that are QS_NOTCHANGED to QS_NONE
>> >
>> > =A0 =A0 =A0 =A0if (count !=3D count2) {
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Stuff happened ... rethink
>> > =A0 =A0 =A0 =A0}
>> >
>> > That is still a bit weird and wonderful but all the logic is in th=
e right
>> > places. The special magic remains in the Android policy code and i=
n the
>> > kernel specifics for Android.
>> >
>> > Thoughts ?
>>
>> I don't think it works. Also, it does not seem much less invasive th=
an
>> suspend blockers.
>
> "I don't think it works" isn't that helpful. I don't think it works
> because .. would help me a lot more.

Did you miss this:
>> What happens if the button press happend before this line:
>> > =A0 =A0 =A0 =A0count2 =3D tasks to QS_NONE | QS_NOTCHANGED

As far as I can tell this is the same race I described where you just
told me to read down a paragraph.

--=20
Arve Hj=F8nnev=E5g
