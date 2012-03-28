From: Kevin Hilman <khilman@ti.com>
Subject: Re: Suspend broken on 3.3?
Date: Wed, 28 Mar 2012 10:46:23 -0700
Message-ID: <87vcloipow.fsf@ti.com>
References: <WC20120322110946.6413AA@terrafix.co.uk> <87r4wka6bf.fsf@ti.com>
	<WC20120326134115.9815DF@terrafix.co.uk> <87haxaq3ua.fsf@ti.com>
	<CAMrsUd++maNjaK87bcRUqVHtz5zySujQXZK1YaMH9vnHVWCDag@mail.gmail.com>
	<878viln2t5.fsf@ti.com>
	<CAMrsUdKXZL4nT0MW=BcD53PsQFE+W1inij3XWe0e5+BjJF3odg@mail.gmail.com>
	<WC20120328153855.621724@terrafix.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:60043 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932259Ab2C1RqW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Mar 2012 13:46:22 -0400
Received: by mail-pb0-f43.google.com with SMTP id wz12so2244418pbc.30
        for <linux-omap@vger.kernel.org>; Wed, 28 Mar 2012 10:46:22 -0700 (PDT)
In-Reply-To: <WC20120328153855.621724@terrafix.co.uk> (Joe Woodward's message
	of "Wed, 28 Mar 2012 16:38:55 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joe Woodward <jw@terrafix.co.uk>
Cc: "Raja, Govindraj" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Paul Walmsley <paul@pwsan.com>, neilb@suse.de

+Paul, NeilBrown who both have worked on/around recent UART breakage
 since v3.2

"Joe Woodward" <jw@terrafix.co.uk> writes:

[...]

> This patch fixes the suspend problem for me, but there is another UART issue...
>
> Basically I've got a fairly high speed data source (in UART terms,
> >900KBaud) pumping data to the OMAP (such as GPS positions).
>
> I don't want this to wake me when suspended (which this patch fixes).
>
> However, it seems on 3.3 that I get a lot of corruption/lost
> characters, which I'm assuming is because the UART is implementing
> runtime-PM.
>
> So my next question is: How do I disable runtime-PM/force-always-on
> for a given UART? Can this be done via the sysfs?

Yes, but the boot-time default for this is that the UARTs have runtime
PM disabled since the default autosuspend timeout is set to -1.

You must be setting an autosuspend timeout >0 if you're seeing runtime
PM kick in.

That being said, even with an autosuspend timeout enabled, you can
disable runtime PM by setting the /sys/devices/.../power/control knob to
'on' (instead of auto, which means it's controle by runtime PM):

  echo on > /sys/devices/platform/omap/omap_uart.2/power/control

That will disable runtime PM and leave the UARTs always clocked.

> Or where are the runtime-PM constraints set for the UART? 

Look for this in the driver:

	/* calculate wakeup latency constraint */
	up->calc_latency = (USEC_PER_SEC * up->port.fifosize) / (baud / 8);

> I'm guessing they'll work for 115200Baud, but my high speed UART fowls
> these?

The constraint calculations take into account baud rate, but are known
to be somewhat broken currently.

You might want to experiment with Paul's work on fixing up the QoS
contstraint calculation[1] to see if it helps as well.  That is available here

Kevin

[1] git://git.pwsan.com/linux-2.6 omap_serial_fix_pm_qos_formula_devel_3.4
