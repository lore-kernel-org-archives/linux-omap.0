From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [linux-pm] suspend blockers & Android integration
Date: Mon, 7 Jun 2010 17:57:19 -0700
Message-ID: <AANLkTimf_nVcOZGi0x6nDtaO-FMVSLPrxDtOzQwKTB5P@mail.gmail.com>
References: <20100606152946.GA11351@srcf.ucam.org>
	<Pine.LNX.4.44L0.1006061956510.4894-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:62959 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751324Ab0FHA5U convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Jun 2010 20:57:20 -0400
In-Reply-To: <Pine.LNX.4.44L0.1006061956510.4894-100000@netrider.rowland.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Vitaly Wool <vitalywool@gmail.com>, Neil Brown <neilb@suse.de>, tytso@mit.edu, Peter Zijlstra <peterz@infradead.org>, Brian Swetland <swetland@google.com>, Felipe Balbi <felipe.balbi@nokia.com>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, James Bottomley <James.Bottomley@suse.de>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Linux PM <linux-pm@lists.linux-foundation.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arjan van de Ven <arjan@infradead.org>

On Sun, Jun 6, 2010 at 5:01 PM, Alan Stern <stern@rowland.harvard.edu> =
wrote:
> On Sun, 6 Jun 2010, Matthew Garrett wrote:
>
>> The difference between idle-based suspend and opportunistic suspend =
is
>> that the former will continue to wake up for timers and will never b=
e
>> entered if something is using CPU, whereas the latter will be entere=
d
>> whenever no suspend blocks are held. The problem with opportunistic
>> suspend is that you might make the decision to suspend simultaneusly
>> with a wakeup event being received. Suspend blocks facilitate
>> synchronisation between the kernel and userspace to ensure that all =
such
>> events have been consumed and handld appropriately.
>
> Remember that suspend takes place in several phases, the first of whi=
ch
> is to freeze tasks. =A0The phases can be controlled individually by t=
he
> process carrying out a suspend, and there's nothing to prevent you fr=
om
> stopping after the freezer phase. =A0Devices won't get powered down, =
but
> Android uses aggressive runtime power management for its devices
> anyway.
>
> If you do this then the synchronization can be carried out entirely
> from userspace, with no need for kernel modifications such as suspend
> blockers. And since Android can reach essentially the same low-power
> state from idle as from suspend, it appears that they really don't ne=
ed
> any kernel changes at all.
>

I don't think this is true. If you stop after the freezer phase you
still need all the suspend blockers that are held until user-space
consumes an event, otherwise it never gets consumed since user-space
is frozen.

--=20
Arve Hj=F8nnev=E5g
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
