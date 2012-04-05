From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: OMAP34xx
Date: Thu, 5 Apr 2012 09:24:42 +0100
Message-ID: <20120405082442.GA25053@n2100.arm.linux.org.uk>
References: <20120204185453.GB17309@n2100.arm.linux.org.uk> <20120204190109.GL20333@atomide.com> <20120204203453.GD17309@n2100.arm.linux.org.uk> <20120205125626.GA11372@n2100.arm.linux.org.uk> <20120205143824.GA12577@n2100.arm.linux.org.uk> <4F336D3A.2060302@ti.com> <20120209223400.GE19159@n2100.arm.linux.org.uk> <4F34B89F.1050904@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:50214 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751552Ab2DEIY4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Apr 2012 04:24:56 -0400
Content-Disposition: inline
In-Reply-To: <4F34B89F.1050904@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

On Fri, Feb 10, 2012 at 11:56:39AM +0530, Archit Taneja wrote:
> On Friday 10 February 2012 04:04 AM, Russell King - ARM Linux wrote:
>> On Thu, Feb 09, 2012 at 12:22:42PM +0530, Archit Taneja wrote:
>>> Hi,
>>>
>>> On Sunday 05 February 2012 08:08 PM, Russell King - ARM Linux wrote:
>>>> Okay, so this requires backlight support, and TAAL selected, so that sorts
>>>> that error, but causes others:
>>>>
>>>> taal display0: taal panel revision e3.83.7d
>>>> omapdss DSI error: DSI CIO error, cio irqstatus 200000
>>>> DSI CIO IRQ 0x200000: ERRCONTENTIONLP1_1
>>>> omapdss DSI error: DSI CIO error, cio irqstatus 200000
>>>> DSI CIO IRQ 0x200000: ERRCONTENTIONLP1_1
>>>> omapdss DSI error: DSI CIO error, cio irqstatus 200000
>>>> DSI CIO IRQ 0x200000: ERRCONTENTIONLP1_1
>>>> omapdss DSI error: DSI CIO error, cio irqstatus 200000
>>>> DSI CIO IRQ 0x200000: ERRCONTENTIONLP1_1
>>>> omapdss DSI error: DSI CIO error, cio irqstatus 200000
>>>> DSI CIO IRQ 0x200000: ERRCONTENTIONLP1_1
>>>> omapdss DSI error: DSI CIO error, cio irqstatus 200000
>>>> DSI CIO IRQ 0x200000: ERRCONTENTIONLP1_1
>>>
>>> This happens when the flex cable connected to the display is faulty or
>>> loose.
>>
>> Well, I don't know - it works with ES1 and an old kernel just fine.
>>
>
> Okay, I'll look into this more.

Any news on this?  I see no progress on this in mainline kernels:

http://www.arm.linux.org.uk/developer/build/result.php?type=boot&idx=112

Yet I can still boot the kernel with the originally provided kernel
and CPU and it all works fine.

Has anyone else tried to get the LCD panels working on the 4430SDP?
