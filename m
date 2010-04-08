From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: OMAP4 keypad driver
Date: Thu, 8 Apr 2010 08:50:19 +0300
Message-ID: <20100408055019.GA23541@nokia.com>
References: <27F9C60D11D683428E133F85D2BB4A53043CB21399@dlee03.ent.ti.com>
 <20100408044223.GB6228@nokia.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C4D0F36C@dbde02.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:24819 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022Ab0DHFui (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Apr 2010 01:50:38 -0400
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C4D0F36C@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, "Arce, Abraham" <x0066660@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Apr 08, 2010 at 07:43:44AM +0200, ext Shilimkar, Santosh wrote:
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Felipe
>> Balbi
>> Sent: Thursday, April 08, 2010 10:12 AM
>> To: Arce, Abraham
>> Cc: linux-omap@vger.kernel.org
>> Subject: Re: OMAP4 keypad driver
>>
>> On Thu, Apr 08, 2010 at 03:16:08AM +0200, ext Arce, Abraham wrote:
>> >Hi,
>> >
>> >I need some help to figure out the best way to incorporate omap4 keypad in linux omap.
>> >
>> >First approach, I have a patch that creates a new file, omap4-keypad.c with the following
>> implementations:
>> >
>> > - Based on matrix keypac logic
>> > - Using hwmod framework
>> > - Using threaded irq
>> >
>> >Second approach, to change existing omap-keypad.c to matrix keypad
>> >
>> >Not clear on the path to follow... Thanks for your comments.
>>
>> isn't that part of the twl6030 pmic ? If so you need a better name for
>> it, something like twl6030-keypad.c
>>
>It's not. OMAP4 has it's own keyboard controller embedded.

then why do you use threaded_irq ? If omap4 has its own keypad 
controller, then sure it's memory-mapped, no ? Well, please send the 
driver and we can comment further :-p

-- 
balbi
