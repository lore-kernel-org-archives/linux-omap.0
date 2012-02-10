From: Archit Taneja <a0393947@ti.com>
Subject: Re: OMAP34xx
Date: Fri, 10 Feb 2012 11:56:39 +0530
Message-ID: <4F34B89F.1050904@ti.com>
References: <20120204185453.GB17309@n2100.arm.linux.org.uk> <20120204190109.GL20333@atomide.com> <20120204203453.GD17309@n2100.arm.linux.org.uk> <20120205125626.GA11372@n2100.arm.linux.org.uk> <20120205143824.GA12577@n2100.arm.linux.org.uk> <4F336D3A.2060302@ti.com> <20120209223400.GE19159@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40007 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751452Ab2BJG04 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Feb 2012 01:26:56 -0500
In-Reply-To: <20120209223400.GE19159@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

On Friday 10 February 2012 04:04 AM, Russell King - ARM Linux wrote:
> On Thu, Feb 09, 2012 at 12:22:42PM +0530, Archit Taneja wrote:
>> Hi,
>>
>> On Sunday 05 February 2012 08:08 PM, Russell King - ARM Linux wrote:
>>> Okay, so this requires backlight support, and TAAL selected, so that sorts
>>> that error, but causes others:
>>>
>>> taal display0: taal panel revision e3.83.7d
>>> omapdss DSI error: DSI CIO error, cio irqstatus 200000
>>> DSI CIO IRQ 0x200000: ERRCONTENTIONLP1_1
>>> omapdss DSI error: DSI CIO error, cio irqstatus 200000
>>> DSI CIO IRQ 0x200000: ERRCONTENTIONLP1_1
>>> omapdss DSI error: DSI CIO error, cio irqstatus 200000
>>> DSI CIO IRQ 0x200000: ERRCONTENTIONLP1_1
>>> omapdss DSI error: DSI CIO error, cio irqstatus 200000
>>> DSI CIO IRQ 0x200000: ERRCONTENTIONLP1_1
>>> omapdss DSI error: DSI CIO error, cio irqstatus 200000
>>> DSI CIO IRQ 0x200000: ERRCONTENTIONLP1_1
>>> omapdss DSI error: DSI CIO error, cio irqstatus 200000
>>> DSI CIO IRQ 0x200000: ERRCONTENTIONLP1_1
>>
>> This happens when the flex cable connected to the display is faulty or
>> loose.
>
> Well, I don't know - it works with ES1 and an old kernel just fine.
>

Okay, I'll look into this more.

Thanks,
Archit

