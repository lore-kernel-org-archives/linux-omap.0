From: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH v2] arm, am335x: add support for the bosch shc board
Date: Wed, 18 Nov 2015 09:24:48 +0100
Message-ID: <564C35D0.8060609@denx.de>
References: <1447748655-2088-1-git-send-email-hs@denx.de>
 <564B9C3D.7070303@ti.com>
Reply-To: hs@denx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <564B9C3D.7070303@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: linux-kernel@vger.kernel.org, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Robert Nelson <robertcnelson@gmail.com>, devicetree@vger.kernel.org, Georg.Soffel@bosch-si.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

Hello Dave,

Am 17.11.2015 um 22:29 schrieb Dave Gerlach:
> Hi,
> On 11/17/2015 02:24 AM, Heiko Schocher wrote:
>> add support for the am335x based shc board.
>>
>> UART: 0-2 and 4
>> DRAM: 512 MiB
>> MMC:  OMAP SD/MMC: 0 @ 26 MHz
>>        OMAP SD/MMC: 1 @ 26 MHz
>> I2C:  at24 eeprom, pcf8563
>> USB:  USB1 (host)
>>
>> Signed-off-by: Heiko Schocher <hs@denx.de>
>> ---
>> The following patches are needed to get all working
>> for the shc board:
>> - disable clkout on pcf8563
>>    accepted.
>>    http://www.spinics.net/lists/devicetree/msg98542.html
>>
>> - leds: leds-gpio: add shutdown function
>>    accepted.
>>    https://lkml.org/lkml/2015/10/13/169
>>
>> - net: phy: smsc: disable energy detect mode
>>    accepted
>>    [PATCH v2 2/2] net: phy: smsc: disable energy detect mode
>>    https://lkml.org/lkml/2015/10/17/2
>>    [PATCH v2 1/2] drivers: net: cpsw: add phy-handle parsing
>>    https://lkml.org/lkml/2015/10/17/4
>>
>> - ARM: OMAP2+: omap_hwmod: Introduce ti,no-init dt property
>>    http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/328204.html
>>    @Dave: What is the current state of this patch?
>>    I have the same problem here on this am335x based board
>>
>
> A different approach is being taken for resolving the issue of rtc hwmod on am43x epos evm [1],
> which is what I was attempting to solve with the patch you have linked. We decided to avoid changing
> omap_hwmod code and I haven't been pursuing the ti,no-init flag anymore.

Maybe I overlook something, but I cannot see, how [1] solves the RTC
hwmod problem on am335x SoC based boards. Not all boards have this problem,
so the RTC hwmod cannot be disabled for all am335x boards ...

It must be somehow configurable for boards ... I have am335x boards
which use the rtc from the SoC

> Regards,
> Dave
>
> [1] http://www.spinics.net/lists/linux-omap/msg121987.html

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
