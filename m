From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 1/1] mfd: omap-usb-host: Fix USB device detection problems
 on OMAP4 Panda
Date: Mon, 2 Dec 2013 15:44:48 +0200
Message-ID: <529C8ED0.6060805@ti.com>
References: <1385730118-26402-1-git-send-email-rogerq@ti.com>	<1385730118-26402-2-git-send-email-rogerq@ti.com> <CAOf5uwmEkzFd=e3j8m8=qdTCAMkk_-DPw0fTm=7Vzy0PbE2oDQ@mail.gmail.com> <529C55DF.3000808@ti.com> <529C76AF.10106@linutronix.de> <529C7922.5000601@ti.com> <529C854F.3010101@linutronix.de> <529C8CBD.4070003@ti.com> <529C8D74.10007@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <529C8D74.10007@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Michael Trimarchi <michael@amarulasolutions.com>, Felipe Balbi <balbi@ti.com>, lee.jones@linaro.org, sameo@linux.intel.com, tomi.valkeinen@ti.com, Stefan Roese <sr@denx.de>, ljkenny.mailinglists@gmail.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, USB list <linux-usb@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 12/02/2013 03:39 PM, Sebastian Andrzej Siewior wrote:
> On 12/02/2013 02:35 PM, Roger Quadros wrote:
>>> It refers to "Errata Id:i660" why it is required. Once you figured =
what
>>> why it has been added you could have an idea if it is okay to remov=
e it
>>> and if the reset you do here might lead to it (I dunno).
>>>
>>
>> Keshava no longer works @TI. I have no other means to check why it w=
as added
>> other than doing dome tests and making sure nothing breaks if we rem=
ove it.
>>
>> So far, things are going fine for about 50 or so boots divided betwe=
en OMAP3 and 4
>> platforms. If more people can test and give feedback it'd be great.
>=20
> Hmm. Can't you lookup the errata he revers to?
>=20

Sure, but it was not making sense why RESET was avoided.
It doesn't say anything about not using RESET. In fact it says that RES=
ET _is_ the
recovery procedure.

Pasting the errata description below for easy reference.

"Errata id: i660
DESCRIPTION
In the following configuration :
=95 USBHOST module is set to smart-idle mode
=95 PRCM asserts idle_req to the USBHOST module. (This typically happen=
s when the system is going to
a low power mode : all ports have been suspended, the master part of th=
e USBHOST module has
entered the standby state, and SW has cut the functional clocks.)
=95 an USBHOST interrupt occurs before the module is able to answer idl=
e_ack, typically a remote wakeup
IRQ.
Then the USB HOST module will enter a deadlock situation where it is no=
 more accessible nor functional.
The only way to recover will be to perform a software reset of the modu=
le.

WORKAROUND
The best workaround consists in switching the module to force idle mode=
 right before cutting the
module's FCLK.
=95 the bus has reached the suspend state.
=95 write SYSCONFIG:Idlemode=3D ForceIdle and read it back to ensure th=
e write has been taken into
account in case of posted writes.
=95 cut the FCLK
=95 Idle_req will be asserted and idle_ack answered within one L3 clock=
 cycle.
Upon resume or remote wakeup, switch back the module to smart-idle.
This workaround reduces the failure window to only one L3 clock cycle. =
The probability for an interrupt to
fire at this exact time is considered extremely low, and the case has n=
ever been hit on board."

Based on this, I don't see anything wrong in Resetting the module at pr=
obe or at boot.

cheers,
-roger
