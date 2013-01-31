From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: Failure to boot...
Date: Thu, 31 Jan 2013 19:40:51 +0530
Message-ID: <510A7B6B.1080600@ti.com>
References: <20130131014912.GM2637@n2100.arm.linux.org.uk> <20130131030203.GA8374@quad.lixom.net> <alpine.LFD.2.02.1301302312030.6300@xanadu.home> <20130131092024.GN2637@n2100.arm.linux.org.uk> <20130131104044.GO2637@n2100.arm.linux.org.uk> <510A6877.9080307@ti.com> <20130131130437.GP2637@n2100.arm.linux.org.uk> <510A78E1.8010308@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51594 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921Ab3AaOJr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 31 Jan 2013 09:09:47 -0500
In-Reply-To: <510A78E1.8010308@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Nicolas Pitre <nico@fluxnic.net>, Tony Lindgren <tony@atomide.com>, arm@kernel.org, Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thursday 31 January 2013 07:30 PM, Santosh Shilimkar wrote:
> On Thursday 31 January 2013 06:34 PM, Russell King - ARM Linux wrote:
>> On Thu, Jan 31, 2013 at 06:19:59PM +0530, Santosh Shilimkar wrote:
>>> On Thursday 31 January 2013 04:10 PM, Russell King - ARM Linux wrote:
>>>> On Thu, Jan 31, 2013 at 09:20:24AM +0000, Russell King - ARM Linux
>>>> wrote:
>>>>> On Wed, Jan 30, 2013 at 11:19:40PM -0500, Nicolas Pitre wrote:
>>>>>> Better yet (IMHO): just enable the zboot command in U-Boot to let you
>>>>>> boot a zImage binary directly.
>>>>>
>>>>> I wish it were that easy but it isn't.  I've no idea where to get a
>>>>> version of uboot for my boards which supports that; TI have always
>>>>> supplied updates to uboot for me, and with the current state of TI
>>>>> being afaict in chaos.
>>>>>
>>>>> TI have always supplied a replacement X-Loader with each uboot update.
>>>>> I've no idea what X-Loader is or why both get updated together, but...
>>>>>
>>>>> Moreover, I doubt that the 3430LDP, of which there are multiple
>>>>> versions,
>>>>> will ever see a uboot update.  It already suffers from a lack of
>>>>> correct
>>>>> kernel support due to random wiring changes between these versions
>>>>> (the
>>>>> keypad doesn't work correctly) and I've yet to indentify which version
>>>>> it is despite downloading the circuits.  So trying to locate the right
>>>>> uboot will be impossible there.
>>>>>
>>>>> So, I'm _stuck_ with uImages for these platforms.
>>>>
>>>> Right, so I'm now passing LOADADDR= which allows this to work - and the
>>>> latest OMAP4430SDP boot result shows almost the same sad broken story.
>>>>
>>> I just tried latest mainline (commit: 04c2eee5) and default config
>>> just boots fine.
>>
>> Please read the notes at the bottom of the page, specifically:
>>   * Build tree is currently created on an ad-hoc basis from Linus'
>> tip, rmk's
>>     development tip and arm-soc for-next branches.
>>
>> This system does *not* build and boot vanilla mainline kernels.  It is
>> (as the above says):
>>
>> - Linus' tip
>> - My for-next plus a few other bits
>> - arm-soc for-next
>>
>> all merged together.
>>
> Linus' tip(commit: 04c2eee5) + arm-soc for-next boots fine as well.
> The pull request from Tony [1] fixed the multi-platform boot issue
> for OMAP.
>
> Now trying to merge your for-next and test.
>
This is fine as well. I think the issue is the way uImage is created.
'make LOADADDRESS=XXXX uImage' actually doesn't work. Am using below
method to create an uImage.

mkimage -A arm -O linux -T kernel -C none -a 0x80008000 -e 0x80008000 -n 
"Linux" -d zImage uImage

Will you be able to try this out please ?

Regards,
Santosh





