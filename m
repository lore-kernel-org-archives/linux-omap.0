From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: suspend blockers & Android integration
Date: Sat, 5 Jun 2010 18:45:58 -0700
Message-ID: <AANLkTilxr9vsMmE7LLoOcTIlhXLctWolC2VAsVeoLgnW@mail.gmail.com>
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
	<alpine.LFD.2.00.1006060220400.2933@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:63849 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933768Ab0FFBp7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 5 Jun 2010 21:45:59 -0400
In-Reply-To: <alpine.LFD.2.00.1006060220400.2933@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, tytso@mit.edu, Brian Swetland <swetland@google.com>, Neil Brown <neilb@suse.de>, Alan Stern <stern@rowland.harvard.edu>, Felipe Balbi <felipe.balbi@nokia.com>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, James Bottomley <James.Bottomley@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, Kevin Hilman <khilman@deeprootsystems.com>, "H. Peter Anvin" <hpa@zytor.com>, Arjan van de Ven <arjan@infradead.org>

2010/6/5 Thomas Gleixner <tglx@linutronix.de>:
> On Sat, 5 Jun 2010, Arve Hj=F8nnev=E5g wrote:
>> 2010/6/5 Thomas Gleixner <tglx@linutronix.de>:
>> > On Sat, 5 Jun 2010, Arve Hj=F8nnev=E5g wrote:
>> >> 2010/6/5 Thomas Gleixner <tglx@linutronix.de>:
>> >> > B1;2005;0cOn Fri, 4 Jun 2010, Arve Hj=F8nnev=E5g wrote:
>> >> Cross app calls do not go through a central process.
>> >
>> > It's not about a central process, it goes through your framework,
>> > which should be able to deal with it. If not, it's a design failur=
e
>> > which needs to be fixed at the place where the failure happened.
>> >
>> >> >>
>> >> >> How can it be fixed? The user presses the back button, the fra=
mework
>> >> >> determines that app A is in the foreground and send the key to=
 app A,
>> >> >> app A decides that it it does not have anything internal to go=
 back to
>> >> >> and tells the framework to switch back to the previous app. If=
 the
>> >> >> user presses the back key again, the framework does not know w=
hich app
>> >> >> this key should go to until app A has finished processing the =
first
>> >> >> key press.
>> >> >
>> >> > Errm, what has this to do with frozen apps? If your system is
>> >> > handling input events then there are no frozen apps and even if=
 they
>> >> > are frozen your framework can unfreeze them _before_ talking to=
 them.
>> >> >
>> >> > So which unfixable problem are you describing with the above ex=
ample ?
>> >> >
>> >>
>> >> You are claiming that trusted code should not have any dependenci=
es on
>> >> untrusted code. I gave you a visible example of such a dependency=
 and
>> >> want you to tell me how you can avoid this dependency. Since you =
are
>> >> claiming that our user-space framework is fundamentally broken if=
 it
>> >> has to wait for untrusted code, I don't think it is unreasonable =
for
>> >> you to answer this. Or do you think it is valid to communicate wi=
th
>> >> untrusted code when the screen is on but not when it is off.
>> >
>> > It does not matter whether the screen is off or not. If you need t=
o
>> > call into that untrusted app from your trusted app and you know ab=
out
>> > the might be frozen state then you can deal with it.
>> >
>> > So taking your example:
>> >
>> > Event happens and gets delivered to the framework
>> >
>> > =A0 =A0 =A0framework selects A because it is in the foreground
>> >
>> > =A0 =A0 =A0if (A is frozen)
>> > =A0 =A0 =A0 =A0 unfreeze(A)
>> >
>> > =A0 =A0 =A0deliver_event_to(A)
>> >
>> > It's that simple.
>> >
>>
>> That is too simple. You also have to prevent A from being frozen whi=
le
>> it is processing the event or the result would be the same as if it
>> was frozen beforehand.
>
> The framework decides when to freeze the app in the first place (as
> your framework does now when it decides to suspend)
>
> =A0 =A0 So it knows whether the app is frozen or not.
>
> =A0 =A0 So it knows damend well whether it processed the event or not=
=2E
>

Our user-space code is not single-threaded. So just because an app was
not frozen when you checked does not mean it will remain unfrozen. We
can use the same user-space wakelock api we have now to prevent
freezing apps instead of preventing suspend, but we loose any
advantage we get from freezing just a subset of processes this way.

--=20
Arve Hj=F8nnev=E5g
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
