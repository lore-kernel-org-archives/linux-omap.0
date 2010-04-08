From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: OMAP4 keypad driver
Date: Thu, 8 Apr 2010 11:26:10 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C4D0F387@dbde02.ent.ti.com>
References: <27F9C60D11D683428E133F85D2BB4A53043CB21399@dlee03.ent.ti.com>
 <20100408044223.GB6228@nokia.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C4D0F36C@dbde02.ent.ti.com>
 <20100408055019.GA23541@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33473 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751803Ab0DHF4S convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Apr 2010 01:56:18 -0400
In-Reply-To: <20100408055019.GA23541@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>
Cc: "Arce, Abraham" <x0066660@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Felipe Balbi [mailto:felipe.balbi@nokia.com]
> Sent: Thursday, April 08, 2010 11:20 AM
> To: Shilimkar, Santosh
> Cc: Balbi Felipe (Nokia-D/Helsinki); Arce, Abraham; linux-omap@vger.kernel.org
> Subject: Re: OMAP4 keypad driver
> 
> On Thu, Apr 08, 2010 at 07:43:44AM +0200, ext Shilimkar, Santosh wrote:
> >> -----Original Message-----
> >> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of
> Felipe
> >> Balbi
> >> Sent: Thursday, April 08, 2010 10:12 AM
> >> To: Arce, Abraham
> >> Cc: linux-omap@vger.kernel.org
> >> Subject: Re: OMAP4 keypad driver
> >>
> >> On Thu, Apr 08, 2010 at 03:16:08AM +0200, ext Arce, Abraham wrote:
> >> >Hi,
> >> >
> >> >I need some help to figure out the best way to incorporate omap4 keypad in linux omap.
> >> >
> >> >First approach, I have a patch that creates a new file, omap4-keypad.c with the following
> >> implementations:
> >> >
> >> > - Based on matrix keypac logic
> >> > - Using hwmod framework
> >> > - Using threaded irq
> >> >
> >> >Second approach, to change existing omap-keypad.c to matrix keypad
> >> >
> >> >Not clear on the path to follow... Thanks for your comments.
> >>
> >> isn't that part of the twl6030 pmic ? If so you need a better name for
> >> it, something like twl6030-keypad.c
> >>
> >It's not. OMAP4 has it's own keyboard controller embedded.
> 
> then why do you use threaded_irq ? If omap4 has its own keypad
> controller, then sure it's memory-mapped, no ? Well, please send the
> driver and we can comment further :-p
Probably that's better :)

I think Abraham initial driver has top half (ISR) and bottom
half (tasklet). Threaded IRQ is used to get rid-of tasklet and handle
the bottom half in thread context. IIRC this was on of the intention of this
new API.

Regards,
Santosh

