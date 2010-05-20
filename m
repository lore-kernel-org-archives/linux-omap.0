From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v2] omap4: Fix multi-omap boot with reset un-used clocks
Date: Wed, 19 May 2010 20:49:17 -0500
Message-ID: <4BF4951D.8010300@ti.com>
References: <1274287087-4049-1-git-send-email-santosh.shilimkar@ti.com> <4BF44384.40901@ti.com> <20100520010046.GL5818@atomide.com> <4BF48A4E.7040208@ti.com> <20100520010622.GM5818@atomide.com> <4BF48BAC.6080904@ti.com> <20100520012425.GN5818@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52913 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752846Ab0ETBtU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 May 2010 21:49:20 -0400
In-Reply-To: <20100520012425.GN5818@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>

Tony Lindgren had written, on 05/19/2010 08:24 PM, the following:
> * Nishanth Menon <nm@ti.com> [100519 18:03]:
>> Tony Lindgren had written, on 05/19/2010 08:06 PM, the following:
>>> * Nishanth Menon <nm@ti.com> [100519 17:58]:
>>>> Tony Lindgren had written, on 05/19/2010 08:00 PM, the following:
>>>>> * Nishanth Menon <nm@ti.com> [100519 12:56]:
>>>>>> looks like network is still not functional on SDP4430. different issue
>>>>> Oh so Ethernet does not work either? What's wrong with that?
>>>> I was told offline that the driver is somewhere in the net ML on the
>>>> way I believe in parallel.. I dont have collaborative links though
>>>> :(
>>>>
>>>> Santosh,
>>>> Can you point out the status?
>>> I thought I have those in omap-testing and merged into the master
>>> branch in linux-omap:
>>>
>>> ks8851: Add caching of CCR register
>>> ks8851: Low level functions for read/write to companion eeprom
>>> ks8851: companion eeprom access through ethtool
>> Okay then it makes this an operator error - I have been playing with
>> vanilla linus 2.6.34 tree and adding just the basic patches I need..
>> I can give the omap-testing a whirl..
> 
> OK, cool.
tried with omap_testing i pulled a few mins back, omap3_defconfig with 
CONFIG_EARLY_PRINTK enabled
Good news:
need as pointed out by Santosh -
a) http://www.mail-archive.com/linux-omap@vger.kernel.org/msg27363.html
b) this patch for NFS even to try.

Bad news: Same results I got as in linus tree - NAK for NFS booting :(
full log: http://pastebin.mozilla.org/725960
from the log, I dont see the driver probe even starting up or any 
reports as you posted above (which I guess is from Blaze)..

-- 
Regards,
Nishanth Menon
