From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH] serial: 8250: Make ISA ports optional
Date: Fri, 09 Jan 2015 00:13:28 -0500
Message-ID: <54AF6378.6030202@hurleysoftware.com>
References: <1420513785-23660-1-git-send-email-peter@hurleysoftware.com> <20150108131008.16c9a31c@lxorguk.ukuu.org.uk> <54AEAC47.1040403@hurleysoftware.com> <1896224.oMI8M6J5T7@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:56875 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751110AbbAIFNf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Jan 2015 00:13:35 -0500
Received: by mail-qc0-f172.google.com with SMTP id m20so6721539qcx.3
        for <linux-omap@vger.kernel.org>; Thu, 08 Jan 2015 21:13:34 -0800 (PST)
In-Reply-To: <1896224.oMI8M6J5T7@wuerfel>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@linaro.org>

On 01/08/2015 05:05 PM, Arnd Bergmann wrote:
> On Thursday 08 January 2015 11:11:51 Peter Hurley wrote:
>>
>> This interface is just storage and minor allocation, since the
>> port-reuse behavior will be limited to the "universal" driver.
>> From a sub-driver perspective, the shared storage is actually
>> a hindrance, so that reduces the requirement to minor allocation.
>>
>> And that's where I'm stuck at the moment -- how to share ttyS
>> minor allocation. ttyS console is a related problem.
> 
> One idea that has come up in the past but never saw an implementation
> is to make the ttyS namespace and minor numbers completely generic and
> let any serial port driver use it. This would be a major rework, but
> have the added advantage of cleaning up a number of other namespace
> issues as well. There also lots of open question, in particular how
> to maintain compatibility with existing drivers. One could imagine
> that each uart always gets a ttyS device and optionally also gets
> a device node for the same port with a driver specific chardev as
> most of them do today. Or it could be an either/or decision that is
> made at compile time or as a module parameter.

I'm not totally convinced that sharing minor allocation is the right
solution. ISTM that the main goal is for at least one serial driver
to represent ttyS (assuming that it is a suitable work-alike to the
8250 driver) while other ttyS serial drivers must still be able to
load and operate.

So for example, a UART that is ttyS in a typical configuration, might
be ttyX when another driver has been configured as ttyS instead.
Assuming that every uart driver has a unique, alternate base name,
then the problem is reduced to selecting the appropriate driver for
ttyS.

Some use cases would require selecting the ttyS driver at build time.
Others would probably require the notion of a preferred driver.

What got me thinking about this approach instead of sharing minor
allocation was based on the 'first-come, first-served' question
I asked back in Dec. What happens when probe order varies and
console=ttyS0/login prompt doesn't show up where it's supposed to?
I've had this experience with multiple ethernet adapters and it's
not fun.

Regards,
Peter Hurley
