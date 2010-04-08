From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: OMAP4 keypad driver
Date: Thu, 8 Apr 2010 07:42:23 +0300
Message-ID: <20100408044223.GB6228@nokia.com>
References: <27F9C60D11D683428E133F85D2BB4A53043CB21399@dlee03.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:17549 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750829Ab0DHEnn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Apr 2010 00:43:43 -0400
Content-Disposition: inline
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A53043CB21399@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Arce, Abraham" <x0066660@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Apr 08, 2010 at 03:16:08AM +0200, ext Arce, Abraham wrote:
>Hi,
>
>I need some help to figure out the best way to incorporate omap4 keypad in linux omap.
>
>First approach, I have a patch that creates a new file, omap4-keypad.c with the following implementations:
>
> - Based on matrix keypac logic
> - Using hwmod framework
> - Using threaded irq
>
>Second approach, to change existing omap-keypad.c to matrix keypad
>
>Not clear on the path to follow... Thanks for your comments.

isn't that part of the twl6030 pmic ? If so you need a better name for 
it, something like twl6030-keypad.c

In that case I don't know why do you care about hwmod, but I would need 
to see the patch anyways.

Well, if you need example code, look at 
drivers/input/keyboard/twl4030_keypad.c

The driver should be sent to linux-input@vger.kernel.org and 
linux-omap@vger.kernel.org. Be sure that it patches 
scripts/checkpatch.pl --strict and that you're not adding any sparse 
warnings. Double check Documentation/CodingStyle,
Documentation/SubmittingPatches, Documentation/SubmittingDrivers and 
Documentation/SubmitChecklist.

Be sure that the new driver, comes on one patch of its own and the 
arch/arm/*omap* changes should come in a separate patch and a third one 
for defconfig changes.

The rest we can sort out when you send the patch.

-- 
balbi
