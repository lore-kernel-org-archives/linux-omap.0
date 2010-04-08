From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: OMAP4 keypad driver
Date: Thu, 8 Apr 2010 11:13:44 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C4D0F36C@dbde02.ent.ti.com>
References: <27F9C60D11D683428E133F85D2BB4A53043CB21399@dlee03.ent.ti.com>
 <20100408044223.GB6228@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33039 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753655Ab0DHFny convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Apr 2010 01:43:54 -0400
In-Reply-To: <20100408044223.GB6228@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "Arce, Abraham" <x0066660@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Felipe
> Balbi
> Sent: Thursday, April 08, 2010 10:12 AM
> To: Arce, Abraham
> Cc: linux-omap@vger.kernel.org
> Subject: Re: OMAP4 keypad driver
> 
> On Thu, Apr 08, 2010 at 03:16:08AM +0200, ext Arce, Abraham wrote:
> >Hi,
> >
> >I need some help to figure out the best way to incorporate omap4 keypad in linux omap.
> >
> >First approach, I have a patch that creates a new file, omap4-keypad.c with the following
> implementations:
> >
> > - Based on matrix keypac logic
> > - Using hwmod framework
> > - Using threaded irq
> >
> >Second approach, to change existing omap-keypad.c to matrix keypad
> >
> >Not clear on the path to follow... Thanks for your comments.
> 
> isn't that part of the twl6030 pmic ? If so you need a better name for
> it, something like twl6030-keypad.c
> 
It's not. OMAP4 has it's own keyboard controller embedded. 

> In that case I don't know why do you care about hwmod, but I would need
> to see the patch anyways.
> 
> Well, if you need example code, look at
> drivers/input/keyboard/twl4030_keypad.c
> 
> The driver should be sent to linux-input@vger.kernel.org and
> linux-omap@vger.kernel.org. Be sure that it patches
> scripts/checkpatch.pl --strict and that you're not adding any sparse
> warnings. Double check Documentation/CodingStyle,
> Documentation/SubmittingPatches, Documentation/SubmittingDrivers and
> Documentation/SubmitChecklist.
> 
> Be sure that the new driver, comes on one patch of its own and the
> arch/arm/*omap* changes should come in a separate patch and a third one
> for defconfig changes.
> 
> The rest we can sort out when you send the patch.
> 
> --
> balbi
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
