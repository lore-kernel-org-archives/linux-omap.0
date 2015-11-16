From: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH] arm, am335x: add support for the bosch shc board
Date: Mon, 16 Nov 2015 15:11:54 +0100
Message-ID: <5649E42A.9090703@denx.de>
References: <1447661758-5095-1-git-send-email-hs@denx.de>
 <CAOCHtYjBPxQBCy6LUnj9ZWpJLXQngLZYn0z+=VMsL38QwFrDpA@mail.gmail.com>
Reply-To: hs@denx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOCHtYjBPxQBCy6LUnj9ZWpJLXQngLZYn0z+=VMsL38QwFrDpA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Nelson <robertcnelson@gmail.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, devicetree <devicetree@vger.kernel.org>, Dave Gerlach <d-gerlach@ti.com>, Georg.Soffel@bosch-si.com, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

Hello Robert,

Am 16.11.2015 um 14:23 schrieb Robert Nelson:
>> +
>> +       cpsw_default: cpsw_default {
>> +               pinctrl-single,pins = <
>> +                       /* Slave 1 */
>> +                       0x110 (PIN_INPUT_PULLDOWN | MUX_MODE0)
>> +                       0x114 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)
>> +                       0x118 (PIN_INPUT_PULLDOWN | MUX_MODE0)
>> +                       0x11c (PIN_OUTPUT_PULLDOWN | MUX_MODE0)
>> +                       0x120 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)
>> +                       0x124 (PIN_INPUT_PULLDOWN | MUX_MODE0)
>> +                       0x128 (PIN_INPUT_PULLDOWN | MUX_MODE0)
>> +                       0x12c (PIN_INPUT_PULLUP | MUX_MODE0)
>> +                       0x130 (PIN_INPUT_PULLDOWN | MUX_MODE0)
>> +                       0x134 (PIN_INPUT_PULLDOWN | MUX_MODE0)
>> +                       0x138 (PIN_INPUT_PULLDOWN | MUX_MODE0)
>> +                       0x13c (PIN_INPUT_PULLDOWN | MUX_MODE0)
>> +                       0x140 (PIN_INPUT_PULLDOWN | MUX_MODE0)
>
> Please use the AM33XX_IOPAD pinmux macro:
>
> All boards have recently be converted:
>
> https://www.mail-archive.com/linux-omap@vger.kernel.org/msg121329.html

Uh.. missed this, changed. Wait for more comments before posting v2.

Thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
