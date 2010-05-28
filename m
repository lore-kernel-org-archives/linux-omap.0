From: Mike Chan <mike@android.com>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 17:49:36 -0700
Message-ID: <AANLkTik-8HtTVOh3toXBZZlXYgDTFtfkm6EDYRw-UPm4@mail.gmail.com>
References: <Pine.LNX.4.44L0.1005271253240.3239-100000@iolanthe.rowland.org>
	<201005280041.43553.rjw@sisk.pl>
	<20100528001514.28e593ef@lxorguk.ukuu.org.uk>
	<201005280205.01561.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201005280205.01561.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Peter Zijlstra <peterz@infradead.org>, Brian Swetland <swetland@google.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Arve@smtp1.linux-foundation.org, Florian Mickler <florian@mickler.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, felipe.balbi@nokia.com
List-Id: linux-omap@vger.kernel.org

On Thu, May 27, 2010 at 5:05 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Friday 28 May 2010, Alan Cox wrote:
>> > The approach with user space power manager suggested by Dmitry and=
 Alan Stern
>> > may work, but it still assumes some kind of suspend blockers to be=
 present in
>> > the kernel. =A0If we reject that too, I wonder what approach Googl=
e is supposed
>> > to use and still get the same battery life they get with suspend b=
lockers.
>>
>> I'm getting less convinced it needs suspend blockers at all for this=
 case,
>> assuming that you are willing to have a policy that is based on
>>
>> - assuming apps play nicely
>> - having the information to user space you need (who woke us, who bl=
ocked
>> =A0 us, events)
>> - dealing with offenders primarily from user space using that inform=
ation
>>
>> I'm fairly happy about the following so far
>>
>> - we should have a common interface for seeing some pm events (like
>> =A0 duh ?) but it does need careful thought so the watcher doesn't c=
hange
>> =A0 the behaviour and break it. (Message "We are suspending", gosh s=
omeone
>> =A0 is running to receive the message, resume being the obvious case=
)
>>
>> - Suspend is (for many platforms) just a cotinuation down the power
>> =A0 chain. Demonstrated and implemented on ARM. Very much the direct=
ion of
>> =A0 S0i1/S0i3 on x86 MID devices. Proved by the fact it has been don=
e and
>> =A0 made to work, and by reading the Moorestown PR.
>>
>> - Given a non forced (that is 'idle down') transition to a suspend l=
evel
>> =A0 we can implement a 'suspend as idle' on many embedded platforms =
in a
>> =A0 manner which is not racy at kernel level. Apparently implemented
>> =A0 already on ARM
>>
>> - Given a non forced transition to such a suspend level and the repo=
rting
>> =A0 of certain events we can do a full user space managed graphical =
UI type
>> =A0 environment policy in a race free fashion
>>
>> - With notification of who caused a resume and maybe a bit of other
>> =A0 general stat gathering it is possible to identify and handle abu=
ses of
>> =A0 power resource. Proved by the fact we can do this with powertop =
but
>> =A0 more elegance in the interfaces would be nice.
>>
>> I am not sure if a pm event is what is needed for this or a sum 'har=
dware
>> triggered wake up' event.
>>
>> I accept that current ACPI based laptops probably couldn't make use =
of
>> such a feature but I don't think this is important at the moment.
>
> No, it's not.
>
>> A resource constraint model might help further in the ACPI case. It'=
s
>> useful for other stuff but it might well be a distraction and
>> implementation detail in terms of the basic question about what is n=
eeded
>> for something like Android.
>>
>> At this point the input of the Android team and the Nokia people wou=
ld
>> be rather more useful to me.
>
> OK, I added Arve and Brian to the CC list.
>

Even if we used the proposed QoS replacement, are there suggestions on
how to keep the cpu idle for longer than 2 seconds in Linux without
using suspend?

On a thread somewhere I had real world power numbers on a Motorola
Droid idling (screen off) with and without suspend blockers.

-- Mike

> Thanks,
> Rafael
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/linux-pm
>
