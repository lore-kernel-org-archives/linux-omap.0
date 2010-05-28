From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 23:16:17 -0700
Message-ID: <AANLkTilIRYGuxxI9ytsFxCkPtJ4RDoOV6suYI5eFA1Oq@mail.gmail.com>
References: <Pine.LNX.4.44L0.1005271517170.3239-100000@iolanthe.rowland.org>
	<1275023742.27810.7782.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:63588 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752110Ab0E1GQV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 May 2010 02:16:21 -0400
In-Reply-To: <1275023742.27810.7782.camel@twins>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Paul@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux PM <linux-pm@lists.linux-foundation.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, felipe.balbi@nokia.com

On Thu, May 27, 2010 at 10:15 PM, Peter Zijlstra <peterz@infradead.org>=
 wrote:
> On Thu, 2010-05-27 at 15:19 -0400, Alan Stern wrote:
>> On Thu, 27 May 2010, Peter Zijlstra wrote:
>>
>> > I still don't see how blocking applications will cause missed wake=
ups in
>> > anything but a buggy application at worst, and even those will
>> > eventually get the event when they unblock.
>> >
>> > What seems to be the confusion?
>>
>> During forced suspend, applications are block because they are froze=
n.
>>
>> When an event occurs, the application is notified somehow. =A0But it
>> can't respond because it is frozen. =A0Hence the event remains sitti=
ng in
>> a kernel queue and the system goes ahead and suspends anyway. =A0The
>> application doesn't get thawed until the system wakes up at some
>> indefinite time in the future.
>
> If the kernel is awake to put things in queues, we're clearly not
> suspended and userspace is running ?!

Suspend is not an atomic operation. User space is frozen before
freezable kernel threads both of these happen before drivers are
suspended.

--=20
Arve Hj=F8nnev=E5g
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
