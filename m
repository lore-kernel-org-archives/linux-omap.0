From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: OMAP34xx
Date: Thu, 9 Feb 2012 22:34:01 +0000
Message-ID: <20120209223400.GE19159@n2100.arm.linux.org.uk>
References: <20120204185453.GB17309@n2100.arm.linux.org.uk> <20120204190109.GL20333@atomide.com> <20120204203453.GD17309@n2100.arm.linux.org.uk> <20120205125626.GA11372@n2100.arm.linux.org.uk> <20120205143824.GA12577@n2100.arm.linux.org.uk> <4F336D3A.2060302@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:37877 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753372Ab2BIWeP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Feb 2012 17:34:15 -0500
Content-Disposition: inline
In-Reply-To: <4F336D3A.2060302@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

On Thu, Feb 09, 2012 at 12:22:42PM +0530, Archit Taneja wrote:
> Hi,
>
> On Sunday 05 February 2012 08:08 PM, Russell King - ARM Linux wrote:
>> Okay, so this requires backlight support, and TAAL selected, so that sorts
>> that error, but causes others:
>>
>> taal display0: taal panel revision e3.83.7d
>> omapdss DSI error: DSI CIO error, cio irqstatus 200000
>> DSI CIO IRQ 0x200000: ERRCONTENTIONLP1_1
>> omapdss DSI error: DSI CIO error, cio irqstatus 200000
>> DSI CIO IRQ 0x200000: ERRCONTENTIONLP1_1
>> omapdss DSI error: DSI CIO error, cio irqstatus 200000
>> DSI CIO IRQ 0x200000: ERRCONTENTIONLP1_1
>> omapdss DSI error: DSI CIO error, cio irqstatus 200000
>> DSI CIO IRQ 0x200000: ERRCONTENTIONLP1_1
>> omapdss DSI error: DSI CIO error, cio irqstatus 200000
>> DSI CIO IRQ 0x200000: ERRCONTENTIONLP1_1
>> omapdss DSI error: DSI CIO error, cio irqstatus 200000
>> DSI CIO IRQ 0x200000: ERRCONTENTIONLP1_1
>
> This happens when the flex cable connected to the display is faulty or  
> loose.

Well, I don't know - it works with ES1 and an old kernel just fine.
