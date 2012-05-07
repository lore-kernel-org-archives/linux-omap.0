From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH] ARM: OMAP: USB: fix warning on EHCI PHY reset path
Date: Mon, 07 May 2012 17:27:50 +0300
Message-ID: <4FA7DBE6.3060809@compulab.co.il>
References: <Pine.LNX.4.44L0.1205071003240.1602-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:42548
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756676Ab2EGO17 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 May 2012 10:27:59 -0400
In-Reply-To: <Pine.LNX.4.44L0.1205071003240.1602-100000@iolanthe.rowland.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: balbi@ti.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Keshava Munegowda <Keshava_mgowda@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>

On 05/07/12 17:04, Alan Stern wrote:
> On Sun, 6 May 2012, Igor Grinberg wrote:
> 
>> Hi Alan,
> 
> ...
> 
>> Sorry, for being jumpy...
>> Samuel has not answered yet (it has been more then two weeks already)
>> and I'd like this to go into 3.5.
>> Also, the dependency patch is already in Linus' tree. It has been merged with
>> fixes (I thought it will happen only during the merge window...).
>>
>> Can you, please take this one?
> 
> No, I can't, sorry.  It has to be accepted by Greg KH.

Hmm... I don't mind it be that way, but I'd like to understand:

# scripts/get_maintainer.pl -f drivers/usb/host/ehci-omap.c
Alan Stern <stern@rowland.harvard.edu> (maintainer:USB EHCI DRIVER)
Felipe Balbi <balbi@ti.com> (maintainer:OMAP USB SUPPORT)
Greg Kroah-Hartman <gregkh@suse.de> (supporter:USB SUBSYSTEM)
linux-usb@vger.kernel.org (open list:USB EHCI DRIVER)
linux-omap@vger.kernel.org (open list:OMAP USB SUPPORT)
linux-kernel@vger.kernel.org (open list)

This makes you the USB EHCI maintainer, right?
I just want to understand...
Do you need also ack from Greg to take something to your tree
for being applied in the next merge window?


-- 
Regards,
Igor.
