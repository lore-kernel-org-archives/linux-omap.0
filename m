From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: N810 suspend
Date: Fri, 19 Dec 2008 07:47:43 -0800
Message-ID: <87vdtgtbds.fsf@deeprootsystems.com>
References: <20081215210823.GD5334@swansys>
	<20081215211430.GJ10664@atomide.com>
	<20081216092531.c440dc26.jarkko.nikula@nokia.com>
	<20081216162951.GP19551@atomide.com> <20081216165632.GF25056@swansys>
	<20081216172237.GR19551@atomide.com>
	<20081217140911.b30d7194.jarkko.nikula@nokia.com>
	<20081218090147.c6e5c4a0.jarkko.nikula@nokia.com>
	<87ljud88n7.fsf@nokia.com>
	<alpine.DEB.2.00.0812182226510.24916@utopia.booyaka.com>
	<87ljucv4d7.fsf@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.28]:63045 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784AbYLSPrt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Dec 2008 10:47:49 -0500
Received: by yw-out-2324.google.com with SMTP id 9so375949ywe.1
        for <linux-omap@vger.kernel.org>; Fri, 19 Dec 2008 07:47:47 -0800 (PST)
In-Reply-To: <87ljucv4d7.fsf@nokia.com> (Kalle Valo's message of "Fri\, 19 Dec 2008 12\:36\:20 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Valo <kalle.valo@nokia.com>
Cc: ext Paul Walmsley <paul@pwsan.com>, Jarkko Nikula <jarkko.nikula@nokia.com>, ext Tony Lindgren <tony@atomide.com>, Linux-OMAP List <linux-omap@vger.kernel.org>

Kalle Valo <kalle.valo@nokia.com> writes:

> "ext Paul Walmsley" <paul@pwsan.com> writes:
>
>>> > N810 didn't went and think reason is that bootloader enables UART3
>>> > for the GPS chip.
>>> 
>>> I noticed this as well. Any hacks to workaround this? Or do I really
>>> need to start searching for N800? :)
>>
>> hey Kevin,
>>
>> did your serial port idle code ever work out?  I wonder if that would work 
>> for the N810s...
>
> Any patches anywhere? I would gladly test something.
>

The PM branch[1] has a set of UART patches which disable UART clocks
in the idle loop.  The clocks are disabled after an inactivity timer
(default 5 seconds of idle.)

I've tested the UART idle parts on n810 which seem to work, but
hitting retention on n810 seems broken in current linux-omap.  Tony
merged a patch[2] from me last week which was crashing going into
retention, but even with that I'm not able to wakeup from retention.

This could be something as simple as the wakeup event sources are not
configured correctly for n810, but I did not debug further.

Kevin


[1] Branch 'pm' in linux-omap tree
[1] http://marc.info/?l=linux-omap&m=122855013200342&w=2
