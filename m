From: Florian Mickler <florian@mickler.org>
Subject: Re: [linux-pm] suspend blockers & Android integration
Date: Tue, 8 Jun 2010 12:19:54 +0200
Message-ID: <20100608121954.7e190dd2@schatten.dmk.lab>
References: <AANLkTikRSV5dFX10apUntFi4eJkRt645Iod91qrPk9gI@mail.gmail.com>
	<Pine.LNX.4.44L0.1006072153030.27878-100000@netrider.rowland.org>
	<AANLkTimcDzHBmgqPkCHB6pW2RZivFhmb_zk68T0I3NJY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTimcDzHBmgqPkCHB6pW2RZivFhmb_zk68T0I3NJY@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arve =?ISO-8859-15?Q?Hj=F8nnev=E5g?= <arve@android.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, tytso@mit.edu, Alan Cox <alan@lxorguk.ukuu.org.uk>, Peter Zijlstra <peterz@infradead.org>, Brian Swetland <swetland@google.com>, "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>, Neil Brown <neilb@suse.de>, James Bottomley <James.Bottomley@suse.de>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Felipe Balbi <felipe.balbi@nokia.com>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-omap@vger.kernel.org

On Mon, 7 Jun 2010 20:05:56 -0700
Arve Hj=F8nnev=E5g <arve@android.com> wrote:
Hi,

>=20
> If you read an event that occurred after you blocked the task
> freezing, then tasks will never get frozen again (until more events
> occur). I think my original description was less confusing, but it
> seems you got completely distracted by my use of block and unblock
> suspend when referring to the user space api.

Here is how I understood Alan's approach:=20

Userspace manager (UM) does:

<...continuation of function A>
5) unblock from reading a wakeup from wakeupevents-fd
6) thaw userspace
7) return
</function A>

[userspace sees there is an event; blocks suspend at UM; processes
event; consume wakeupevent at UM; unblock suspend at UM;]=20

Unblocking the last suspend-blocker at the UM starts function A:

<function A>
1) non-blocking read of wakeup-events-fd (refills wakeupevents)
2) if all wakeupevents are consumed:=20
	3a) freeze userspace=09
   else
	3b) /* wait for userspace to unblock
	suspend again... this should take care of the races? */ return;
4) blocking read of wakeupevents-fd
<...for continuation see above>

You mitigate the race by freezing and unfreezing userspace. If there
occur wakeups between 3a) and 4) you will have frozen userspace in
vain.=20

So I think the feasibility of this solution depends on the performance
of freezing/thawing userspace. I can't judge that.

Also I _think_ this is racefree as long as you have the UM properly
serialized. Or did I overlook something?


Cheers,
=46lo
