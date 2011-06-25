From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [linux-pm] Runtime PM discussion notes
Date: Sat, 25 Jun 2011 14:33:35 +0900
Message-ID: <BANLkTimopuwk91vP6uS3fR8Lc5tf9VF9gw@mail.gmail.com>
References: <Pine.LNX.4.44L0.1106231113170.2033-100000@iolanthe.rowland.org>
	<201106232234.21930.rjw@sisk.pl>
	<alpine.DEB.2.00.1106241239340.25533@utopia.booyaka.com>
	<BANLkTinaa2W0mTUGCzfLAgBsgC5nP57x9ZXC0PfOvqa7x16kvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:65305 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750877Ab1FYFdh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 25 Jun 2011 01:33:37 -0400
Received: by iyb12 with SMTP id 12so2876182iyb.19
        for <linux-omap@vger.kernel.org>; Fri, 24 Jun 2011 22:33:36 -0700 (PDT)
In-Reply-To: <BANLkTinaa2W0mTUGCzfLAgBsgC5nP57x9ZXC0PfOvqa7x16kvw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Cc: Paul Walmsley <paul@pwsan.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>

2011/6/25 Arve Hj=F8nnev=E5g <arve@android.com>:
> On Fri, Jun 24, 2011 at 12:53 PM, Paul Walmsley <paul@pwsan.com> wrot=
e:
> ...
>>
>> As I understand it, in the original Android implementation, the hard=
ware
>> that they were using didn't have fine-grained power management. =A0S=
o
>> system-wide suspend made more sense in that context. =A0But that sho=
uldn't
>> be confused with the modern rationale for wakelocks:
>>
>> https://lists.linux-foundation.org/pipermail/linux-pm/2010-May/02566=
8.html
>>
>> "On the hardware that shipped we enter the same power state from idl=
e
>> and suspend, so the only power savings we get from suspend that we
>> don't get in idle is from not respecting the scheduler and timers."
>>
>
> This is no longer the case. Both the Nexus-S and Xoom enter lower
> power states from suspend than idle.

Interesting, thanks for pointing that out. So this lower-power-state
in system suspend, is that a hardware limitation, or just a reflection
on effort spent on the CPUIdle portion of the current software
implementation? I suspect it's the latter.

I've recently been working towards implementing software support for
deeper sleep modes on sh7372 in the mainline kernel. With my
experimental patch the system suspend case may be able to sleep deeper
that current CPUIdle, but that's only because I have not yet tied in
enough dependency tracking to make proper decisions from CPUIdle
context.

Getting sleep modes working transparently with CPUIdle is currently a
bit more difficult than simply using system suspend IMO, so I would
not be surprised if some vendors simply skip implementing some deeper
sleep modes in CPUIdle due to the added complexity.

=46rom the hardware perspective nothing is stopping us to use CPUIdle
with the lowest sleep states. This is true for all SH-Mobile SoCs
including sh7372. Also, we don't rely on firmware for control of the
PM states - if anyone is restricted by a firmware interface then
obviously it's going to be difficult to do more fine grained power
management.

Cheers,

/ magnus
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
