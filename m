From: Marc Murphy <marcmltd@marcm.co.uk>
Subject: RE: Issues with GPIO and wake from sleep
Date: Thu, 23 Jan 2014 09:45:06 +0000
Message-ID: <F690310232FDDF4AB457E8B3EF90DDE09A5A80E9@MARCM-SBS2011.marcmltd.local>
References: <F690310232FDDF4AB457E8B3EF90DDE09A56D39C@MARCM-SBS2011.marcmltd.local>,<20140117173902.GD7235@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtpout04.bt.lon5.cpcloud.co.uk ([65.20.0.124]:16103 "EHLO
	smtpout04.bt.lon5.cpcloud.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751293AbaAWJpQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Jan 2014 04:45:16 -0500
In-Reply-To: <20140117173902.GD7235@atomide.com>
Content-Language: en-GB
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

I have tried all sorts of configurations now and still cannot get the s=
ystem to wake from GPIO.

The confusing thing is that if I use the power managements tests via de=
bugfs I can make the system sleep and wakeup using the timer, so the su=
spend and wake is configured and working.

Using either method of configuring the GPIO to be an interrupt and wake=
up source OR a GPIO key with wakeup capability results in the system ju=
st sitting there in the suspended state.
I know the GPIO and IRQ is working as I see the count increment in=20
/proc/interrupts

I have tried debugging with JTAG but not having any luck because the co=
re enters a power down state so therefore disconnects the JTAG and the =
debug session hangs.

I have also removed all devices going back to a very basic system think=
ing drivers are causing the suspend resume issue but still it stays in =
the sleep state.

All the references I can find online do not assist in getting a solutio=
n for me.

Is there anyone out there that has managed to successfully get the wake=
 from suspend to memory working via a GPIO on a 3.x kernel ?

i am getting close to running out of options to make this system work.

Help appreciated and may help others out there with a similar issue.

Kind Regards
Marc

________________________________________
=46rom: Tony Lindgren [tony@atomide.com]
Sent: 17 January 2014 17:39
To: Marc Murphy
Cc: linux-omap@vger.kernel.org
Subject: Re: Issues with GPIO and wake from sleep

* Marc Murphy <marcmltd@marcm.co.uk> [140117 04:32]:
> I have resisted contacting the list with regards to an issue I am hav=
ing trying to get what should be a simple part of my system working but=
 I cannot find any documentation or other posts to help.
>
> I am using 3.6 kernel but have tried 3.12 to see if the issue has bee=
n addressed in that but its exactly the same.
>
> I am attempting to get a GPIO to wake my AM3517 system up from a susp=
end to memory.  I have tried with a few different options for GPIO=92s
> I have available GPIO-10, GPIO-28 and GPIO-30.
>
> I started by using GPIO-28 and that would configure nicely and I set =
up the interrupt handler and could see my debug when triggering the inp=
ut (brilliant) but for some reason I cannot use it  to wake the system =
as it is not in the correct group for wakeup.  There is a note in the T=
ech Ref Man -
>
> Only gpio_1, gpio_9, gpio_10, gpio_11, gpio_30, and gpio_31 can be us=
ed to generate a direct wake-up event.
>
> So have to use a different one. GPIO-30 cannot be used as that holds =
the system in reset, so all that is left is GPIO-10.
> All seems to be good for initialisation;

I think you don't need the mux wake-up bits for the first GPIO bank, it=
's
always powered. So just setting gpio10 as an interrupt should keep it
working through suspend. The GPIO driver has it's own idle handling for
the first bank, see _set_gpio_wakeup().

Maybe you just need to do set_irq_wake() in the interrupt number
for gpio10?

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
