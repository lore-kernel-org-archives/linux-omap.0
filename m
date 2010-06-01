From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Mon, 31 May 2010 21:57:05 -0700
Message-ID: <AANLkTilvOgSFTDFtXbjJobMZWxgfvsC97TqC7_a_NHBX@mail.gmail.com>
References: <Pine.LNX.4.44L0.1005271253240.3239-100000@iolanthe.rowland.org>
	<201005302202.39511.rjw@sisk.pl>
	<AANLkTilUQ2AG76nbK6LwI8_7zw0_yMSoAOr9pmuz7xrt@mail.gmail.com>
	<201005312347.24251.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:42126 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751658Ab0FAE5I convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Jun 2010 00:57:08 -0400
In-Reply-To: <201005312347.24251.rjw@sisk.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Florian Mickler <florian@mickler.org>, Thomas Gleixner <tglx@linutronix.de>, Matthew Garrett <mjg59@srcf.ucam.org>, Alan Stern <stern@rowland.harvard.edu>, Peter Zijlstra <peterz@infradead.org>, Paul@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

2010/5/31 Rafael J. Wysocki <rjw@sisk.pl>:
> On Monday 31 May 2010, Arve Hj=F8nnev=E5g wrote:
>> 2010/5/30 Rafael J. Wysocki <rjw@sisk.pl>:
> ...
>>
>> I think it makes more sense to block suspend while wakeup events are
>> pending than blocking it everywhere timers are used by code that cou=
ld
>> be called while handling wakeup events or other critical work. Also,
>> even if you did block suspend everywhere timers where used you still
>> have the race where a wakeup interrupt happens right after you decid=
ed
>> to suspend. In other words, you still need to block suspend in all t=
he
>> same places as with the current opportunistic suspend code, so what =
is
>> the benefit of delaying suspend until idle?
>
> Assume for a while that you don't use suspend blockers, OK? =A0I real=
ize you
> think that anything else doesn't make sense, but evidently some other=
 people
> have that opinion about suspend blockers.
>

It sounded like you were suggesting that initiating suspend from idle
would somehow avoid the race condition with wakeup events. All I'm
saying is that you would need to block suspend in all the same places.
If you don't care about ignoring wakeup events, then sure you can
initiate suspend from idle.

> Now, under that assumption, I think it _generally_ is reasonable to m=
ake the
> system go into full suspend if everything (ie. CPUs and I/O) has been=
 idle
> for sufficiently long time and there are no QoS requirements that are=
n't
> compatible with full system suspend.
>

--=20
Arve Hj=F8nnev=E5g
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
