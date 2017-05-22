From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH v4 00/20] eeprom: at24: Add OF device ID table
Date: Mon, 22 May 2017 19:15:54 +0200
Message-ID: <CABxcv==8R5_tG8-rsp-9UdS_5N7X8QXkd0OFnN63Ct7L2jFvhA@mail.gmail.com>
References: <20170522140208.24652-1-javier@dowhile0.org>
 <CAMuHMdXbhkGGFC80-39Axzv=BdEXyBNuPuHCSWW3eXWDB=SQ+w@mail.gmail.com>
 <CAL_JsqL2P=C+xRyL-BCC=RtFah4BRf8BHSvWNPZ+6r2ioSk_Yw@mail.gmail.com>
 <CABxcv==xw7UxF1Ey+hDhGb_wzgAcFR9JLm6iuirvYSTTvSxb0A@mail.gmail.com>
 <CAL_JsqKj_f-jY3wi78QyAAov=a9-ReaT9qU=ytwSp+5RL0eutg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAL_JsqKj_f-jY3wi78QyAAov=a9-ReaT9qU=ytwSp+5RL0eutg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>, Wolfram Sang <wsa@the-dreams.de>, Tony Lindgren <tony@atomide.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Will Deacon <will.deacon@arm.com>, Michal Simek <michal.simek@xilinx.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Paul Mackerras <paulus@samba.org>, Linux I2C <linux-i2c@vger.kernel.org>, Hongtao Jia <hongtao.jia@nxp.com>, Mark Jackson <mpfj@newflow.co.uk>, Jason Cooper <jason@lakedaemon.net>, Herbert Xu <herbert@gondor.apana.org.au>, =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>, Michael Ellerman <mpe@ellerman.id.au>, Magnus Damm <magnus.damm@gmail.com>, Russell King <linux@armlinux.org.uk>, Andy Shevchenko <andy.shevchenko@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>, Catalin Marinas <catalin.marin>
List-Id: linux-omap@vger.kernel.org

Hello Rob,

Thanks a lot for your feedback.

On Mon, May 22, 2017 at 6:52 PM, Rob Herring <robh@kernel.org> wrote:
> On Mon, May 22, 2017 at 9:46 AM, Javier Martinez Canillas
> <javier@dowhile0.org> wrote:

[snip]

>>>> | >
>>>> | >     at24@50 {
>>>> | > -           compatible = "at24,24c02";
>>>> | > +           compatible = "at24,24c02", "atmel,24c02";
>>>> |
>>>> | I think you can just drop the at24 compatibles. A new kernel doesn't
>>>> | need it. An old kernel ignores the manufacturer. I checked that u-boot
>>>> | only matches on "atmel,*", so okay there. Don't know about the *BSDs. I
>>>> | couldn't find anything.
>>>>
>>>> I think you misunderstood what Rob means.
>>>>
>>>> In the case above it makes sense to drop the first compatible, as "at24" is
>>>> not a manufacturer, but refers to ATMEL's "AT24" line of i2c FLASH ROMs.
>>>>
>>>> However, in cases where a real vendor/part combo is specified, like on
>>>> r8a7791-koelsch.dts:
>>>>
>>>> -               compatible = "renesas,24c02";
>>>> +               compatible = "atmel,24c02";
>>>>
>>>> you do want to keep the real vendor/part combo, i.e.
>>>>
>>>>      compatible = "renesas,24c02", "atmel,24c02";
>>>
>>> Yes, Geert is correct.
>>>
>>
>> Sorry for misunderstanding your previous comment...
>>
>> How this should be documented in the DT binding? Should I include
>> "renesas" as a valid manufacturer or only list the used
>> <vendor,device> pairs (i.e: "renesas,24c02")?
>
> However you are handling any of the vendors. I'll have to go look.
>

The current DT binding is quite lax when describing this. From
Documentation/devicetree/bindings/eeprom/eeprom.txt:

----------------------------------
EEPROMs (I2C)

Required properties:

  - compatible : should be "<manufacturer>,<type>", like these:

"atmel,24c00", "atmel,24c01", "atmel,24c02", "atmel,24c04",
"atmel,24c08", "atmel,24c16", "atmel,24c32", "atmel,24c64",
"atmel,24c128", "atmel,24c256", "atmel,24c512", "atmel,24c1024"

"catalyst,24c32"

"microchip,24c128"

"ramtron,24c64"

"renesas,r1ex24002"

If there is no specific driver for <manufacturer>, a generic
driver based on <type> is selected. Possible types are:
"24c00", "24c01", "24c02", "24c04", "24c08", "24c16", "24c32", "24c64",
"24c128", "24c256", "24c512", "24c1024", "spd"

  - reg : the I2C address of the EEPROM
----------------------------------

I think though that this is one of the cases where the Linux I2C
subsystem matching logic is leaking into the DT binding doc, since the
manufacturer prefix is ignored by the I2C core (the I2C device ID
table is used to match and to report a MODALIAS).

But I'll keep the description generic as it is now and only mention
the atmel variants (at and at24) as deprecated then.

>> I also wonder why this is really needed if AFAIU "renesas,24c02" is
>> compatible with "atmel,24c02". IOW, the driver doesn't need to
>> differentiate between the two since the devices are the same and will
>> always match using "atmel,24c02".
>
> It is needed, so that when a difference is found, it can be handled
> without updating the DT.
>

Yes, I understand this. What I tried to ask is if there could really
be a difference for the same chip type between different vendors, or
is just that people were using other manufacturers in the compatible
string as a consequence of the DT binding doc and the I2C core
ignoring the vendor prefix.

I don't mind though, I will leave the manufacturers that are different
than the atmel variants in the mainline DTS as you and Geert asked.

> Rob

Best regards,
Javier
