From: Bryan Wu <bryan.wu@canonical.com>
Subject: Re: [PATCH 0/4] Hacks to allow booting ARM SMP kernel on UP ARMv7
Date: Fri, 3 Sep 2010 12:20:26 +0800
Message-ID: <AANLkTinfACvokr6vGZYdhE_RgNPHSA+k3Q7PHm1QvA+X@mail.gmail.com>
References: <20100817135205.GC20325@n2100.arm.linux.org.uk>
	<20100817141210.GJ12184@atomide.com>
	<20100817154035.GD20325@n2100.arm.linux.org.uk>
	<20100819073810.GR12184@atomide.com>
	<4C6CFBAF.6020407@canonical.com>
	<20100819095705.GU12184@atomide.com>
	<20100819102025.GA32151@n2100.arm.linux.org.uk>
	<20100820120622.GL25742@atomide.com>
	<20100830225527.GC11597@atomide.com>
	<20100902133637.GJ26319@n2100.arm.linux.org.uk>
	<20100902161659.GJ11597@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:46757 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748Ab0ICEUb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Sep 2010 00:20:31 -0400
Received: by vws3 with SMTP id 3so1005186vws.19
        for <linux-omap@vger.kernel.org>; Thu, 02 Sep 2010 21:20:30 -0700 (PDT)
In-Reply-To: <20100902161659.GJ11597@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>

On Fri, Sep 3, 2010 at 12:16 AM, Tony Lindgren <tony@atomide.com> wrote=
:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [100902 06:29]:
>> On Mon, Aug 30, 2010 at 03:55:27PM -0700, Tony Lindgren wrote:
>> > * Tony Lindgren <tony@atomide.com> [100820 04:59]:
>> > > * Russell King - ARM Linux <linux@arm.linux.org.uk> [100819 13:1=
3]:
>> > > > On Thu, Aug 19, 2010 at 12:57:06PM +0300, Tony Lindgren wrote:
>> > > > > Looks like something is not quite right with smp_on_up part =
of __fixup_smp,
>> > > > > returning early before smp_on_up does not produce that.
>> > > >
>> > > > It's probably overwriting some register it shouldn't be. =A0I =
might be
>> > > > able to look at this sometime during the coming week... assumi=
ng that
>> > > > the weather is as bad as they forecast and I have 'net connect=
ivity.
>> >
>> > This seems to fix it.
>>
>> Thanks, merged that into my original patch - so here it is again wit=
h
>> everything updated.
>
> Your patch sure makes things simpler! The problem still is the
> V6 vs V7 SMP code though.
>
> Will post my six patches that apply on top of your patch as a reply t=
o
> this mail. With those, everything seems to work, at least after testi=
ng
> on omap3630 (Cortex-A8 UP) and omap4430 (Cortex-A9 SMP).

Awesome, where can get those finalize the patches for testing? After
that I can test our Ubuntu kernel on both boards.

Thanks,
-Bryan
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
