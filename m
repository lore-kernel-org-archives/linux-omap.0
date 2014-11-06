From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] tty: serial: 8250: omap: Add pinctrl support for suspend
Date: Thu, 6 Nov 2014 13:57:53 -0600
Message-ID: <CAGo_u6qTqp1Wpo8E26gLpStu_EiRw32gstkCiXw+EWNDWSnHbw@mail.gmail.com>
References: <1415300850-21452-1-git-send-email-bigeasy@linutronix.de>
	<545BC8C1.4070503@ti.com>
	<545BCF3F.8020705@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:44399 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750877AbaKFT5y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Nov 2014 14:57:54 -0500
In-Reply-To: <545BCF3F.8020705@linutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Tony Lindgren <tony@atomide.com>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-omap <linux-omap@vger.kernel.org>, Dave Gerlach <d-gerlach@ti.com>

On Thu, Nov 6, 2014 at 1:42 PM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> On 11/06/2014 08:15 PM, Nishanth Menon wrote:
>> sounds good to me *IF* omap8250_enable_wakeup (wakeirq handling) is
>> the way we want to continue doing things for daisychain? -> Tony, can
>> you comment?
>> http://marc.info/?l=linux-omap&m=141222144402707&w=2
>>
>> I wonder if wakeirq explicit handling is valid anymore and something
>> given the potential race and alternate approach proposed?
>
> The wakeirq logic is already in the driver. So if we go for the
> alternate approach, the pinctrl patch is obsolete? Or does it mean we
> get rid of the map8250_enable_wakeup() including the second irq we have
> now (and keep the pinctl change)?
based on Thomas's feedback we should probably not carry forward
wakeirq as a seperate irq with it's own request_irq instead it psuedo
triggers uart's interrupt irq -> I am not clear about the direction
Tony wants drivers to take in the approach in the thread above - all I
wondered was if it had any conflict of pin_sleep -> if the generic
handler retriggers the irq before the suspend_handler, then
configuring sleep is gonna break daisychain support. not sure if there
is any specific direction drivers should take.

Again, Tony is the right guy to comment about this.

-- 
---
Regards,
Nishanth Menon
