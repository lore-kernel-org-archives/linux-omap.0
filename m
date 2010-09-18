From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH 03/11] OMAP: UART: omap_device converions, remove implicit
 8520 assumptions
Date: Sat, 18 Sep 2010 14:48:35 +0530
Message-ID: <AANLkTiniFVGzH-f6k9wn7Pk08R2EuWoDahC-Txo8-xcu@mail.gmail.com>
References: <14049.10.24.255.18.1284739601.squirrel@dbdmail.itg.ti.com>
	<87ocbwrl5w.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58651 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755225Ab0IRJSg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 18 Sep 2010 05:18:36 -0400
In-Reply-To: <87ocbwrl5w.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Sat, Sep 18, 2010 at 5:13 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
>> From: Kevin Hilman <khilman@ti.com>
>>
>> Major rework of OMAP UART init for omap_device conversion as well as
>> use with either 8250 driver or new omap-serial driver.
>>
>> In preparation for a new omap-serial driver, remove 8250 assumptions
>> and dependencies from the serial core.
>>
>> Convert UART core and PM support to use omap_device layer. Also add
>> support for both console on 8250 or omap-serial driver.
>>
>> omap_device conversion:
>> - Convert clock API calls to omap_device calls
>> - Remove all static platform_data setup and configuration. =A0This i=
s
>> =A0 all done by the omap_device build phase.
>>
>> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>> Signed-off-by: Kevin Hilman <khilman@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/serial.c | =A0528 +++++++++++++++++++++------=
---------------
>> =A01 files changed, 259 insertions(+), 269 deletions(-)
>>
>
> [...]
>
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Need to block sleep long enough for interrupt driven
>> + =A0 =A0 =A0* driver to start. =A0Console driver is in polling mode
>> + =A0 =A0 =A0* so device needs to be kept enabled while polling driv=
er
>> + =A0 =A0 =A0* is in use.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 uart->timeout =3D (30 * HZ);
>
> My fault, but there's a bug here. =A0This long timeout is only needed
> when the init-time timout is non-zero, so should be:
>
> =A0 =A0 =A0 =A0if (uart->timeout)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0uart->timeout =3D (30 * HZ);
>
> Without this, even though the default timeout is zero (meaning, UARTs
> should not timeout and go idle), a timer will fire 30 seconds after b=
oot
> and cause the UARTs to go idle.
>
> I discovered this when seeing the UARTs go idle, even though the
> timeouts were all set to zero.
>
> Can you fold this into your the next version?


Thanks for this update and review.

Will incorporate this change.

Thanks,
Govindraj.R


>
> Thanks,
>
> Kevin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-seria=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
---
Regards,
Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
