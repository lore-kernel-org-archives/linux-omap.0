From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Fri, 28 May 2010 04:35:34 -0700
Message-ID: <AANLkTikumixQTaKvlyaxjZgfCZNZXFM9LySJ2YZ4OVZf@mail.gmail.com>
References: <Pine.LNX.4.44L0.1005271253240.3239-100000@iolanthe.rowland.org>
	<alpine.LFD.2.00.1005271915540.3032@localhost.localdomain>
	<20100527173118.GE2468@srcf.ucam.org>
	<alpine.LFD.2.00.1005271959450.3032@localhost.localdomain>
	<20100528104415.1403541a@schatten.dmk.lab>
	<AANLkTikXtk-f41-z8gXfXLNLqgGVa0z4d-qgIvwljbR-@mail.gmail.com>
	<20100528122521.3698a62e@schatten.dmk.lab>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100528122521.3698a62e@schatten.dmk.lab>
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Mickler <florian@mickler.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Matthew Garrett <mjg59@srcf.ucam.org>, Alan Stern <stern@rowland.harvard.edu>, Peter Zijlstra <peterz@infradead.org>, Paul@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-omap@vger.kernel.org

2010/5/28 Florian Mickler <florian@mickler.org>:
> On Fri, 28 May 2010 02:18:06 -0700
> Arve Hj=F8nnev=E5g <arve@android.com> wrote:
>
>> > IMO, the whole concept is defining 2 modes of operation:
>> >
>> > 1. user interacts with the device (at least one suspend block acti=
ve)
>> > 2. user doesn't interact with the device (zero suspend block activ=
e)
>>
>> That is a somewhat odd way of looking at it. Yes we have two modes o=
f
>> operation, but an active suspend blocker does not mean that the user
>> is interacting with the device. The way we use it, the "main" suspen=
d
>> blocker is active when the user interacts with the device (controlle=
d
>> by writing to /sys/power/state). All other suspend blockers are used
>> to prevent suspend when user space has decided that the user is not
>> interacting with the device. This includes blocking suspend in the
>> kernel on key events which means the user actually is interacting wi=
th
>> the device, even if user-space has not realized it yet. For other
>> events, like an incoming phone call, we block suspend and make some
>> noise with the hope that the user will start interacting with the
>> device.
>
> Damn. I just want to put some abstract notion around this approach to
> power saving.
>
> But one could say instead of "direct" interaction, that every time a
> suspend blocker is taken it is "on behalf of the user"?
>
> So if a suspend blocker is taken, because a download is in progress,
> it is on behalf of (direct, or indirect) user interaction.
>
> If a suspend blocker is taken, because a key-press has to trickle up =
to
> userspace, it is because of the user.
>
> If a call comes in, a suspend blocker is taken, because the user want=
s
> to receive incomming calls.
>
> So suspend blockers are always a hint to the kernel, that the action =
is
> "on behalf of the user" and it is therefore ok to not suspend the
> device?
>

We also use suspend blockers for work that is not visible to the user.
The battery driver on the Nexus One wakes up periodically while
charging to monitor the battery temperature and turn down the charge
current if it gets too hot.

>>
>> >
>> > In case 1. the device wants _everything_ sheduled as normal (and s=
ave
>> > maximum possible power, i.e. runtime pm with every technology avai=
lable
>> > now).
>> >
>> > In case 2. we want nothing sheduled (and save maximum possible pow=
er,
>> > i.e. suspend)
>> >
>> OK.
>
> Good. I got this right at least.
>
>>
>> > And now, every application and every kernel driver annotates (on b=
ehalve
>> > of the user) if it (possibly) interacts with the user.
>> >
>>
>> Applications that interact with the user do not normally need to blo=
ck
>> suspend. The user interacting with the device blocks suspend (just
>> like with your desktop screen saver). Not every kernel driver needs =
to
>> be annotated either, only potential wakeup events need to be
>> annotated.
>
> The applications interacting with the user rely on other parts of
> the system to block suspend then.
>
> So it is (in general) not the application which determines if the use=
r
> interacts, but other sources (like input-drivers) and possible a
> timeout?
>

The user-space framework decides if the device is in an interactive
mode or not (on Android phones the screen is off when it is not
interactive). Input driver need to block suspend so the user-space
framework gets the event when it is not already in interactive mode.

>>
>> > (Is this really the problematic bit, that userspace is giving
>> > the kernel hints? Or is it that the hints are called "blocker"?)
>> >
>> > We can only enter mode 2, if _nothing_ (claims) to interact with t=
he
>> > user.
>> >
>>
>> If nothing blocks suspend. The reason to block suspend does not have
>> to be direct user interaction.
>
> But couldn't you say, that the suspend blockers are always due to the
> user? Or is this too narrow? =A0I mean we talk about a device here. A=
nd
> the device's purpose is it to serve the user. So it might be better t=
o
> say: suspend blockers annotate if a task is needed to fullfill the
> devices purpose?
>
I think it is more useful to say that suspend blockers annotate that
some event needs to be processed even if the device is currently not
in an interactive mode.

> It is an easy to understand concept if one says, the device suspends =
if
> it has nothing to do to further the cause.
>
>
> I really want to get to a well expressed definition. suspend blockers
> block suspend. Shure. Buy why?
>
>>
>> > To integrate this with the current way of doing things, i gathered=
 it
>> > needs to be implemented as an idle-state that does the suspend()-c=
all?
>> >
>>
>> I think it is better no not confuse this with idle. Since initiating
>> suspend will cause the system to become not-idle, I don't think is i=
s
>> beneficial to initiate suspend from idle.
>
> I'm not shure. But then again, i'm not too familiar with the kernel. =
It
> sounds like it could save some duplication of effort to integrate
> suspend into the idle-framework. "Purpose-fulness" could be just
> another measure of "idle".
>

To me idle means that no threads are ready to run and no interrupts are=
 pending.

>
>>
>> > Attributes of the idle states could be smth like this:
>> >
>> > c3
>> > =A0 =A0 =A0 =A0cost-to-transition-to-this-state: X
>> > =A0 =A0 =A0 =A0powersavings-per-time: Y
>> > =A0 =A0 =A0 =A0expected time we stay in this state: relative short=
, there is a
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0timer sheduled
>> > =A0 =A0 =A0 =A0suspend-blockers: ignored
>> >
>> > suspend
>> > =A0 =A0 =A0 =A0cost-to-transition-to-this-state: depends, how much=
 drivers to
>> > =A0 =A0 =A0 =A0suspend, how much processes to freeze, how much sta=
te to save
>> > =A0 =A0 =A0 =A0powersavings-per-time: Y
>> > =A0 =A0 =A0 =A0expected time we stay in this state: long, independ=
ent of
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sheduled timers
>> > =A0 =A0 =A0 =A0suspend-blockers: must not be activated
>> >
>> >
>> > Now all transitions and opportunistic suspend could be handled by =
the
>> > same algorithms.
>> >
>> > Would this work?
>> >
>>
>> I'm not sure what you mean.
>
> Yeah. It's a "little bit" handwavy.
>
> But the concept I have in mind:
>
> =A0 =A0 =A0 =A0int what_good_would_it_be_to_go_into_this_state( state=
 )
> =A0 =A0 =A0 =A0{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cur_state =3D get_current_state();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0benefit =3D ( get_power_per_time(cur_s=
tate)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0- get_power_per_time(s=
tate) ) *
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0get_expected_time_we_s=
tay_there( state );
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cost =3D get_transition_cost(cur_state=
,state);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return benefit-cost;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> =A0 =A0 =A0 =A0}
>
> and a constraint function:
>
> =A0 =A0 =A0 =A0bool is_this_state_possible( state )
> =A0 =A0 =A0 =A0{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D true;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cur_latency_requirement =3D get_cur_la=
tency_req();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret &=3D (cur_latency_requirement >=3D=
state_latency_guaranty( state ) );
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret &=3D (some other QOS thingy);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ret;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> =A0 =A0 =A0 =A0}
>
> And now, a loop would enter the state which has the biggest score and
> is possible at the time.
>
> Afaik this is already implemented for c-states in the cpu_idle driver=
s?
>

I don't think we can plug suspend in as a cpu idle state. 1. we want
to suspend even the cpu is not idle. 2. starting suspend will cause
the cpu to not be idle.

--=20
Arve Hj=F8nnev=E5g
