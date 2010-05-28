From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 17:45:25 -0700
Message-ID: <AANLkTimqvMuMpB5E3tj58OtlRc-7mVaec-9EHAegywg7@mail.gmail.com>
References: <Pine.LNX.4.44L0.1005271344040.3239-100000@iolanthe.rowland.org>
	<20100527181433.GG3543@srcf.ucam.org>
	<20100527200313.5c532f2f@lxorguk.ukuu.org.uk>
	<201005280110.17075.rjw@sisk.pl>
	<20100528005045.6ea5feba@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100528005045.6ea5feba@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <mjg59@srcf.ucam.org>, Peter Zijlstra <peterz@infradead.org>, Alan Stern <stern@rowland.harvard.edu>, Thomas Gleixner <tglx@linutronix.de>, Paul@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

On Thu, May 27, 2010 at 4:50 PM, Alan Cox <alan@lxorguk.ukuu.org.uk> wr=
ote:
>> That's correct, but to me the Arve's goal is simply to maximize batt=
ery life
>> and he found experimentally that the longest battery life is achieve=
d if
>> system suspend is used whenever the system doesn't need to be active=
 (from its
>> user's perspective). =A0This actually is different from "when the sy=
stem is
>> idle", because the system isn't idle, for example, when updatedb is =
running.
>> However, from the user's perspective the updatedb process doesn't re=
ally need
>> to run at this particular time, it can very well do it's job in para=
llel with
>> the user typing or reading news. =A0So, the system may very well be =
suspended
>> when updatedb is running.
>
> This is where the original questions around QoS came in
>
>> Since I think we've now rejected the feature, do we have a clear pic=
ture about
>> what the Android people should do _instead_ and yet keep the battery=
 life they
>> want? =A0Because I don't think telling "let them do what they want, =
who cares"
>> is right.
>
> Today "idle" means "no task running"
>
> If you are prepared to rephrase that as "no task that matters is runn=
ing"
> what would need to answer ?
>
> - How do we define who matters: QoS ?
>

This is a much harder question to answer that what we need to use
opportunistic suspend. The question we ask is more like this: "Is all
important work complete?". In the simplest case these can be the same,
but on Android they are not. Some wakeup events require work to be
performed in many processes. A thread that needs to respond to a
wakeup event may currently be busy doing unimportant work. This could
possibly be solved by saying all important work must be above priority
N, but you would need full priority inheritance support and we are not
there today.

> - Can you describe "idle" in terms of QoS without then breaking the
> =A0reliable wakeup for an event (and do you need to ?)
>
> =A0 =A0 =A0 =A0Could this for example look like
>
> =A0 =A0 =A0 =A0Set QoS of 'user apps' to QS_NONE
> =A0 =A0 =A0 =A0Button pushed
> =A0 =A0 =A0 =A0Button driver sets QoS of app it wakes to QS_ABOVESUSP=
END
>

What happens if the user presses the button right before you set QoS
of 'user apps' to  QS_NONE?
To me it looks like this solution would result in this sequence which
may ignore the button press:
 =A0 =A0 =A0 =A0Button pushed
 =A0 =A0 =A0 =A0Button driver sets QoS of app it wakes to QS_ABOVESUSPE=
ND
 =A0 =A0 =A0 =A0Set QoS of 'user apps' to QS_NONE


> =A0 =A0 =A0 =A0That would I think solve the reliable wakeup case alth=
ough
> =A0 =A0 =A0 =A0drivers raising a QoS parameter is a bit unusual in th=
e kernel.
> =A0 =A0 =A0 =A0That would at least however be specific to a few Andro=
id drivers
> =A0 =A0 =A0 =A0and maybe a tiny amount of shared driver stuff so prob=
ably not
> =A0 =A0 =A0 =A0unacceptable. (wake_up_pri(&queue, priority); isn't go=
ing to
> =A0 =A0 =A0 =A0kill anyone is it - especially if it usually ignores t=
he
> =A0 =A0 =A0 =A0priority argument)

Why is "wake_up_pri(&queue, priority)" more acceptable than "suspend_bl=
ock(..."?

>
> =A0 =A0 =A0 =A0I am curious Thomas how that would tie in with PI in t=
he RT
> =A0 =A0 =A0 =A0world, it's effectively inheriting priority from the u=
sers finger.
>
> - Would a model where the UI side behaviour looked like
>
> =A0 =A0 =A0 =A0Timeout
> =A0 =A0 =A0 =A0Screen Off
> =A0 =A0 =A0 =A0Set QoS of 'user apps' to QS_NONE
>
> =A0 =A0 =A0 =A0Event
> =A0 =A0 =A0 =A0[Some chain of activity]
> =A0 =A0 =A0 =A0Screen On
> =A0 =A0 =A0 =A0Set QoS of 'user apps' to QS_ABOVESUSPEND
>
> =A0do the job combined with the ability to see who is stopping us dro=
pping
> =A0to suspend so user space can take action. This could be a data tab=
le
> =A0from the Android cpu manager provided to Android specific policy i=
n
> =A0whoever owns the display.
>
>
> If so how do we fix the UI policy code doing
>
> =A0 =A0 =A0 =A0Screen Off
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0Button Press
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0task to QS_ABOVESUSPEND
> =A0 =A0 =A0 =A0task to QS_NONE
>
> without touching the app userspace code
>
>
> Perhaps
>

What happens if the button press happend before this line:
> =A0 =A0 =A0 =A0count2 =3D tasks to QS_NONE | QS_NOTCHANGED
> =A0 =A0 =A0 =A0Screen off
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0Button Press
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0task to QS_ABOVESUSPEND
> =A0 =A0 =A0 =A0count =3D tasks that are QS_NOTCHANGED to QS_NONE
>
> =A0 =A0 =A0 =A0if (count !=3D count2) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Stuff happened ... rethink
> =A0 =A0 =A0 =A0}
>
> That is still a bit weird and wonderful but all the logic is in the r=
ight
> places. The special magic remains in the Android policy code and in t=
he
> kernel specifics for Android.
>
> Thoughts ?

I don't think it works. Also, it does not seem much less invasive than
suspend blockers.

--=20
Arve Hj=F8nnev=E5g
