From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: OMAP35x GP TIMER as a wakeup trigger
Date: Mon, 27 Apr 2009 21:38:13 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301D73E11C9@dbde02.ent.ti.com>
References: <1f11a5490904270849j5130384avdbaa8da21bc2b668@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60103 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754800AbZD0QIU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Apr 2009 12:08:20 -0400
In-Reply-To: <1f11a5490904270849j5130384avdbaa8da21bc2b668@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ashwin Bihari <abihari@gmail.com>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Ashwin Bihari
> Sent: Monday, April 27, 2009 9:20 PM
> To: linux-omap@vger.kernel.org Mailing List
> Subject: OMAP35x GP TIMER as a wakeup trigger
> 
> Greetings,
> 
> I need to implement a timer as a wake up trigger while my custom board
> is in the suspended state. I read in the TRM that all of the GPTIMERs
> have the capability of generating a wake up interrupt. I'm using the
> 2.6.28-rc8 PM Kernel which contains the patch to enable all the
> GPTIMERS as wake up sources.

Are you refering to the "suspend" state coming from:
echo mem > /sys/power/state
OR
One of the idle states C0-C6?

To understand the wakeup sequence from suspend; take a look at:
arch/arm/mach-omap2/serial.c
...esp the IOPAD configuration.

You will have to do something similar.

~sanjeev

> 
> Could someone familiar with this scheme quickly elaborate all the
> steps that I need to go through to get the system to come out of
> suspend purely on the timer? Is it is just enough to setup the timer
> correctly, enable the interrupt in the appropriate register and assume
> that the PM layer will get the interrupt and do the right thing, or is
> there more that I have to do?
> 
> Also, as as additional thing, if the PM layer handles the interrupt
> and begins the wake-up process, if I could know where that
> specifically happens, that'd be great since I need to know that the
> wake-up process is being triggered by the GPTIMER as opposed to the
> other wakeup triggers and deal with that differently.
> 
> Regards
> -- Ashwin
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 