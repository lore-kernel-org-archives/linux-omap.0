From: "Robert Lukassen" <Robert.Lukassen@tomtom.com>
Subject: RE: Overo serial problems after resume, vs. Beagleboard
Date: Tue, 22 Jun 2010 09:34:51 +0200
Message-ID: <D6DB9C7EDECDA944B870F62B587008622C89CF@NL-EXC-06.intra.local>
References: <4C1F9B80.9010708@gmail.com> <874ogw1dy2.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mxvs2.esa.t-systems.com ([81.7.202.143]:47662 "EHLO
	mxvs2.esa.t-systems.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752807Ab0FVHex convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Jun 2010 03:34:53 -0400
Content-class: urn:content-classes:message
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I've reported this issue earlier this month, unfortunately I have no clue what is happening.
When you telnet (or ssh) to the board via Ethernet-LAN you can see that the board is suspending
and resuming. Output to the serial console works fine. If you do:

> echo Hello > /dev/console

from the ssh/telnet session, you'll see the message being printed to the serial console.

Also, if you have configured the serial console as a wakeup source:

> echo enabled > /sys/devices/platform/serial8250.2/tty/ttyS2/wakeup

then sending a character over the (USB) console link does resume the Overo.

Any character send over the (USB) console link *after* the Overo has resumed will lock up the system in one of two ways:

1) immediate

   The system is locked completely, and the parallel telnet/ssh session cannot make any progress

2) gradual failure

   The system becomes sluggish, especially noticable in the parallel telnet/ssh session that makes progress
   but only slowly. That situation gets worse progressively until there is no noticable progress anymore.

The fact that the serial console does produce output should be proof that there is no problem with the UART clocks. In case (2), 
'top' running in the parallel telnet/ssh session shows virtually no system load, so the lockup/worsening performance seem to have a kernel origin. 

I haven't found an effective way to debug this on the Overo.

Cheers,

Robert  

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Kevin Hilman
> Sent: Monday, June 21, 2010 7:41 PM
> To: Peter Tseng
> Cc: linux-omap@vger.kernel.org; Han Wang
> Subject: Re: Overo serial problems after resume, vs. Beagleboard
> 
> Peter Tseng <tsenpet09@gmail.com> writes:
> 
> > I am seeing some discrepancies between the Overo (I believe I have a
> > Water) and the Beagleboard (I have a Rev. B5) when resuming after a 
> > suspend to RAM.
> 
> Not that it is much comfort, but I have the same problem on 
> Overo but don't see it on any other OMAP3 board.
> 
> I have yet to debug this particular issue further.
> 
> Kevin
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
> http://vger.kernel.org/majordomo-info.html
> 
