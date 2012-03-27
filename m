From: Kevin Hilman <khilman@ti.com>
Subject: Re: Suspend broken on 3.3?
Date: Tue, 27 Mar 2012 14:28:47 -0700
Message-ID: <87pqbxn374.fsf@ti.com>
References: <WC20120322110946.6413AA@terrafix.co.uk> <87r4wka6bf.fsf@ti.com>
	<WC20120326134115.9815DF@terrafix.co.uk> <87haxaq3ua.fsf@ti.com>
	<WC20120327143912.161659@terrafix.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog130.obsmtp.com ([74.125.149.143]:55767 "EHLO
	na3sys009amx259.postini.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755989Ab2C0V2t (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Mar 2012 17:28:49 -0400
Received: by mail-gy0-f180.google.com with SMTP id z12so516497ghb.39
        for <linux-omap@vger.kernel.org>; Tue, 27 Mar 2012 14:28:48 -0700 (PDT)
In-Reply-To: <WC20120327143912.161659@terrafix.co.uk> (Joe Woodward's message
	of "Tue, 27 Mar 2012 15:39:12 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joe Woodward <jw@terrafix.co.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, govindraj.raja@ti.com, Felipe Balbi <balbi@ti.com>

"Joe Woodward" <jw@terrafix.co.uk> writes:

> ...snip...
>
>> Just to confirm: did the above work for you before v3.3?
>> 
>
> I've checked and v3.2 works correctly:
>
> echo "enabled" > /sys/devices/platform/omap/omap_uart.2/power/wakeup => device wakes from console presses
> echo "disabled" > /sys/devices/platform/omap/omap_uart.2/power/wakeup => device does not wake from console presses

OK, that's what I suspected.  Thanks for confirming.

Kevin
