From: Archit Taneja <a0393947@ti.com>
Subject: Re: OMAP34xx
Date: Thu, 5 Apr 2012 14:40:03 +0530
Message-ID: <4F7D616B.9030608@ti.com>
References: <20120204185453.GB17309@n2100.arm.linux.org.uk> <20120204190109.GL20333@atomide.com> <20120204203453.GD17309@n2100.arm.linux.org.uk> <20120205125626.GA11372@n2100.arm.linux.org.uk> <20120205143824.GA12577@n2100.arm.linux.org.uk> <4F336D3A.2060302@ti.com> <20120209223400.GE19159@n2100.arm.linux.org.uk> <4F34B89F.1050904@ti.com> <20120405082442.GA25053@n2100.arm.linux.org.uk> <4F7D5921.2050401@ti.com> <20120405084932.GB25053@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44032 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752875Ab2DEJKl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Apr 2012 05:10:41 -0400
In-Reply-To: <20120405084932.GB25053@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, Benoit Cousson <b-cousson@ti.com>

On Thursday 05 April 2012 02:19 PM, Russell King - ARM Linux wrote:
> On Thu, Apr 05, 2012 at 02:04:41PM +0530, Archit Taneja wrote:
>> We figured out the culprit patch, reverting this prevents the issue:
>>
>> commit 46f8c3c7e95c0d30d95911e7975ddc4f93b3e237
>> Author: Archit Taneja<archit@ti.com>
>> Date:   Fri Oct 7 03:08:44 2011 -0600
>>
>>      ARM: OMAP: ctrl: Fix CONTROL_DSIPHY register fields
>>
>>      Fix the shift and mask macros for DSIx_PPID fields in
>> CONTROL_DSIPHY. The
>>      OMAP4430 Public TRM vV has these fields mentioned correctly.
>>
>>      Signed-off-by: Archit Taneja<archit@ti.com>
>>      Acked-by: Benoit Cousson<b-cousson@ti.com>
>>      Acked-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
>>      Signed-off-by: Paul Walmsley<paul@pwsan.com>
>>
>>
>> This was added to be in sync with the register definitions in newer
>> OMAP4 TRMs. But it turns out that the newer TRMs might be actually
>> messing up the register fields in question.
>
> Okay, I've just tried reverting this commit, and the errors have gone.
> However, I still see nothing on either display at boot time - not even
> the backlight seems to be on.  Should I see anything on the displays?

Backlight support isn't there yet because the TWL soultion to use it is 
hacky. However, you should be able to see penguins if you have built-in 
DSS2 in the kernel and enabled the following configs:

CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FONTS=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y

Tomi, Benoit,

I tried to probe the DSI1 lines on a board which we get the errors. The 
register fields DSI1_PPID and DSI2_PPID are definitely swapped in the 
newer OMAP TRMs. I get around 950mV on DSI1's D1+ lane, and if I set the 
corresponding D1+ bit in the DSI2_PPID, the voltage becomes 1.28V, the 
DSI spec says that we need 1.2V when opearting in DSI LP mode.

I'll post a patch which reverts this commit.

Archit

