From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Fri, 28 May 2010 18:11:22 -0700
Message-ID: <AANLkTimM7O_k8KVSfMgsB8b_EKQEz0vpYu6pxjedsTcJ@mail.gmail.com>
References: <Pine.LNX.4.44L0.1005271253240.3239-100000@iolanthe.rowland.org>
	<20100528104415.1403541a@schatten.dmk.lab>
	<AANLkTikXtk-f41-z8gXfXLNLqgGVa0z4d-qgIvwljbR-@mail.gmail.com>
	<201005290024.22915.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:49194 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756079Ab0E2BLW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 May 2010 21:11:22 -0400
In-Reply-To: <201005290024.22915.rjw@sisk.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Florian Mickler <florian@mickler.org>, Thomas Gleixner <tglx@linutronix.de>, Matthew Garrett <mjg59@srcf.ucam.org>, Alan Stern <stern@rowland.harvard.edu>, Peter Zijlstra <peterz@infradead.org>, Paul@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

2010/5/28 Rafael J. Wysocki <rjw@sisk.pl>:
> On Friday 28 May 2010, Arve Hj=F8nnev=E5g wrote:
>> On Fri, May 28, 2010 at 1:44 AM, Florian Mickler <florian@mickler.or=
g> wrote:
>> > On Thu, 27 May 2010 20:05:39 +0200 (CEST)
>> > Thomas Gleixner <tglx@linutronix.de> wrote:
> ...
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
> It is, if the following two conditions hold simultaneously:
>
> (a) Doing full system suspend is ultimately going to bring you more e=
nergy
> =A0 =A0savings than the (presumably lowest) idle state you're current=
ly in.
>
> (b) You anticipate that the system will stay idle for a considerably =
long time
> =A0 =A0such that it's worth suspending.
>

I still don't think this matters. If you are waiting for in interrupt
that cannot wake you up from suspend, then idle is not an indicator
that it is safe to enter suspend. I also don't think you can avoid any
user-space suspend blockers by delaying suspend until the system goes
idle since any page fault could cause it to go idle. Therefore I don't
see a benefit in delaying suspend until idle when the last suspend
blocker is released (it would only mask possible race conditions).

--=20
Arve Hj=F8nnev=E5g
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
