From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 1/1] mfd: omap-usb-host: Fix USB device detection problems
 on OMAP4 Panda
Date: Mon, 2 Dec 2013 17:12:43 +0200
Message-ID: <529CA36B.2000900@ti.com>
References: <1385730118-26402-1-git-send-email-rogerq@ti.com>	<1385730118-26402-2-git-send-email-rogerq@ti.com> <CAOf5uwmEkzFd=e3j8m8=qdTCAMkk_-DPw0fTm=7Vzy0PbE2oDQ@mail.gmail.com> <529C55DF.3000808@ti.com> <529C76AF.10106@linutronix.de> <529C7922.5000601@ti.com> <529C854F.3010101@linutronix.de> <529C8CBD.4070003@ti.com> <529C8D74.10007@linutronix.de> <529C8ED0.6060805@ti.com> <529C9343.3010000@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <529C9343.3010000@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Michael Trimarchi <michael@amarulasolutions.com>, Felipe Balbi <balbi@ti.com>, lee.jones@linaro.org, sameo@linux.intel.com, tomi.valkeinen@ti.com, Stefan Roese <sr@denx.de>, ljkenny.mailinglists@gmail.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, USB list <linux-usb@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 12/02/2013 04:03 PM, Sebastian Andrzej Siewior wrote:
> On 12/02/2013 02:44 PM, Roger Quadros wrote:
>> "Errata id: i660
>> DESCRIPTION
>> In the following configuration :
>> =95 USBHOST module is set to smart-idle mode
>> =95 PRCM asserts idle_req to the USBHOST module. (This typically hap=
pens when the system is going to
>> a low power mode : all ports have been suspended, the master part of=
 the USBHOST module has
>> entered the standby state, and SW has cut the functional clocks.)
>> =95 an USBHOST interrupt occurs before the module is able to answer =
idle_ack, typically a remote wakeup
>> IRQ.
>> Then the USB HOST module will enter a deadlock situation where it is=
 no more accessible nor functional.
>> The only way to recover will be to perform a software reset of the m=
odule.
>>
>> WORKAROUND
>> The best workaround consists in switching the module to force idle m=
ode right before cutting the
>> module's FCLK.
>> =95 the bus has reached the suspend state.
>> =95 write SYSCONFIG:Idlemode=3D ForceIdle and read it back to ensure=
 the write has been taken into
>> account in case of posted writes.
>> =95 cut the FCLK
>> =95 Idle_req will be asserted and idle_ack answered within one L3 cl=
ock cycle.
>> Upon resume or remote wakeup, switch back the module to smart-idle.
>> This workaround reduces the failure window to only one L3 clock cycl=
e. The probability for an interrupt to
>> fire at this exact time is considered extremely low, and the case ha=
s never been hit on board."
>>
>> Based on this, I don't see anything wrong in Resetting the module at=
 probe or at boot.
>=20
> If u-boot configured USB into something not smart-idle and the reset
> would bring it back then the reset should remain.
> If you could tell hwmod not use smart-idle nor smart-standby and you
> make sure that the suspend code manually puts the device into suspend
> via forceidle then I think could get rid of the "do-not-reset-thingy"=
=2E
>=20

We are already telling hwmod to not use smart-idle or smart-standby.
So the device is always put in no-idle,no-standby during resume and for=
ce-idle,force-standby
during suspend.

I'll send a new patch to remove "do-not-reset" flag from hwmod data and=
 then we
don't need this patch.

cheers,
-roger
