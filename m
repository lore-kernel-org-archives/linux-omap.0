From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v8 4/8] can: c_can: Add syscon/regmap RAMINIT mechanism
Date: Wed, 7 Jan 2015 11:56:04 +0200
Message-ID: <54AD02B4.8030705@ti.com>
References: <1415988591-6032-1-git-send-email-mkl@pengutronix.de> <1415988591-6032-5-git-send-email-mkl@pengutronix.de> <54AA56E1.7030105@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <54AA56E1.7030105@ti.com>
Sender: linux-can-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, wsa@the-dreams.de, linux-omap@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-omap@vger.kernel.org

Tomi,

On 05/01/15 11:18, Tomi Valkeinen wrote:
> Hi Roger,
> 
> On 14/11/14 20:09, Marc Kleine-Budde wrote:
>> From: Roger Quadros <rogerq@ti.com>
>>
>> Some TI SoCs like DRA7 have a RAMINIT register specification
>> different from the other AMxx SoCs and as expected by the
>> existing driver.
>>
>> To add more insanity, this register is shared with other
>> IPs like DSS, PCIe and PWM.
>>
>> Provides a more generic mechanism to specify the RAMINIT
>> register location and START/DONE bit position and use the
>> syscon/regmap framework to access the register.
> 
> This patch updates the syscon regmap using regmap_read + regmap_write.
> That's not a safe way to update the bits, as some other driver may touch
> the register between the read and write. The change has to be made using
> regmap_update_bits.
> 
> We don't have other drivers using the register at the moment, but I
> presume we will sooner or later.

I remember updating this after you pointed it out to me earlier, but it seems I picked up the older version while sending. :(.
Thanks for pointing it again. I'll prepare a fix on top.

cheers,
-roger
