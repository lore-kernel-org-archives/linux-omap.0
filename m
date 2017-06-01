From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH v5 00/20] eeprom: at24: Add OF device ID table
Date: Thu, 1 Jun 2017 10:07:19 +0200
Message-ID: <CABxcv=kC0Bfxsm73x9AY6OiQCEZOafidMT+kv=qUqpqnaMAMaA@mail.gmail.com>
References: <20170523133448.4794-1-javier@dowhile0.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170523133448.4794-1-javier@dowhile0.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, Masahiro Yamada <yamada.masahiro@socionext.com>, Paul Mackerras <paulus@samba.org>, Linux I2C <linux-i2c@vger.kernel.org>, Hongtao Jia <hongtao.jia@nxp.com>, David Lechner <david@lechnology.com>, Rob Herring <robh@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>, Michael Ellerman <mpe@ellerman.id.au>, Magnus Damm <magnus.damm@gmail.com>, Michal Simek <michal.simek@xilinx.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Javier Martinez Canillas <javier@dowhile0.org>, Jas
List-Id: linux-omap@vger.kernel.org

Hello Wolfram,

On Tue, May 23, 2017 at 3:34 PM, Javier Martinez Canillas
<javier@dowhile0.org> wrote:
>
> This series is a follow-up to patch [0] that added an OF device ID table
> to the at24 EEPROM driver. As you suggested [1], this version instead of
> adding entries for every used <vendor,device> tuple, only adds a single
> entry for each chip type using the "atmel" vendor as a generic fallback.
>
> The first patch documents in the DT binding what's the correct vendor to
> use and what are the ones that are being deprecated. The second one adds
> the OF device ID table for the at24 driver and the next patches use this
> vendor in the compatible string to each DTS that defines a compatible I2C
> EEPROM device node.
>
> Patches can be applied independently since the DTS changes without driver
> changes are no-op and the OF table won't be used without the DTS changes.
>
> [0]: https://lkml.org/lkml/2017/3/14/589
> [1]: https://lkml.org/lkml/2017/3/15/99
>

Any comments on this series?

Best regards,
Javier
