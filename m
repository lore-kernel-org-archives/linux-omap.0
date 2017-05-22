From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH v4 00/20] eeprom: at24: Add OF device ID table
Date: Mon, 22 May 2017 21:39:02 +0200
Message-ID: <CABxcv=m+WDzzHy182msOW9U5TCk=bRtbsq89V9cerxSrVYNYUQ@mail.gmail.com>
References: <20170522140208.24652-1-javier@dowhile0.org>
 <CAMuHMdXbhkGGFC80-39Axzv=BdEXyBNuPuHCSWW3eXWDB=SQ+w@mail.gmail.com>
 <CAL_JsqL2P=C+xRyL-BCC=RtFah4BRf8BHSvWNPZ+6r2ioSk_Yw@mail.gmail.com>
 <CABxcv==xw7UxF1Ey+hDhGb_wzgAcFR9JLm6iuirvYSTTvSxb0A@mail.gmail.com>
 <CAL_JsqKj_f-jY3wi78QyAAov=a9-ReaT9qU=ytwSp+5RL0eutg@mail.gmail.com>
 <CABxcv==8R5_tG8-rsp-9UdS_5N7X8QXkd0OFnN63Ct7L2jFvhA@mail.gmail.com>
 <CAMuHMdVaY6J04TL=cEBVkCx=qhQuvbprxXt4VCjh_oEedRYnzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAMuHMdVaY6J04TL=cEBVkCx=qhQuvbprxXt4VCjh_oEedRYnzg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>, Wolfram Sang <wsa@the-dreams.de>, Tony Lindgren <tony@atomide.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Will Deacon <will.deacon@arm.com>, Michal Simek <michal.simek@xilinx.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Paul Mackerras <paulus@samba.org>, Linux I2C <linux-i2c@vger.kernel.org>, Hongtao Jia <hongtao.jia@nxp.com>, Mark Jackson <mpfj@newflow.co.uk>, Jason Cooper <jason@lakedaemon.net>, Rob Herring <robh@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>, Michael Ellerman <mpe@ellerman.id.au>, Magnus Damm <magnus.damm@gmail.com>, Russell King <linux@armlinux.org.uk>, Andy Shevchenko <andy.shevchenko@gmail.com>, =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>, Catalin Marinas <catalin.marinas@arm.com>
List-Id: linux-omap@vger.kernel.org

Hello Geert,

On Mon, May 22, 2017 at 9:30 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Javier,
>
> On Mon, May 22, 2017 at 7:15 PM, Javier Martinez Canillas
> <javier@dowhile0.org> wrote:
>>>> I also wonder why this is really needed if AFAIU "renesas,24c02" is
>>>> compatible with "atmel,24c02". IOW, the driver doesn't need to
>>>> differentiate between the two since the devices are the same and will
>>>> always match using "atmel,24c02".
>>>
>>> It is needed, so that when a difference is found, it can be handled
>>> without updating the DT.
>>
>> Yes, I understand this. What I tried to ask is if there could really
>> be a difference for the same chip type between different vendors, or
>> is just that people were using other manufacturers in the compatible
>> string as a consequence of the DT binding doc and the I2C core
>> ignoring the vendor prefix.
>
> The devices from different vendors are not the same. They contain FLASH
> ROM of a specific size, and glue logic to expose an i2c slave
> interface providing
> an AT24-compatible command set.  They should behave similar within
> the limits of the AT24 "spec".  But the actual implementation may be different.
>

I see, really appreciate your explanation. I'm not familiar with these
devices and driver but the patch-series are needed in order to make
sure that no regressions will happen once the I2C core reports a
proper OF modalias.

>> I don't mind though, I will leave the manufacturers that are different
>> than the atmel variants in the mainline DTS as you and Geert asked.
>
> OK, thanks!
>

Thanks a lot for your feedback!

> Gr{oetje,eeting}s,
>
>                         Geert
>
> --

Best regards,
Javier
