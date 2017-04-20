From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 00/21] eeprom: at24: Add OF device ID table
Date: Wed, 19 Apr 2017 19:12:42 -0500
Message-ID: <20170420001242.vl3sga2bd65jlaoi@rob-hp-laptop>
References: <20170414010445.21727-1-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170414010445.21727-1-javier@osg.samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>, Wolfram Sang <wsa@the-dreams.de>, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-i2c@vger.kernel.org, Hongtao Jia <hongtao.jia@nxp.com>, Russell King <linux@armlinux.org.uk>, Mark Jackson <mpfj@newflow.co.uk>, Herbert Xu <herbert@gondor.apana.org.au>, Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>, Michael Ellerman <mpe@ellerman.id.au>, Magnus Damm <magnus.damm@gmail.com>, Michal Simek <michal.simek@xilinx.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, linux-arm-kernel@lists.infradead.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jason Cooper <jason@lakedaemon.net>, Sebastian
List-Id: linux-omap@vger.kernel.org

On Thu, Apr 13, 2017 at 10:04:24PM -0300, Javier Martinez Canillas wrote:
> Hello Wolfram,
> 
> This series is a follow-up to patch [0] that added an OF device ID table
> to the at24 EEPROM driver. As you suggested [1], this version instead of
> adding entries for every used <vendor,device> tuple, only adds a single
> entry for each chip type using the "atmel" vendor as a generic fallback.
> 
> The first patch adds the OF device ID table for the at24 driver and the
> next patches adds a generic fallback compatible string to each DTS that
> defines a compatible I2C EEPROM device node.
> 
> Patches can be applied independently since the DTS change without the
> driver change is a no-op and the OF device table won't be used without
> the DTS changes.
> 
> [0]: https://lkml.org/lkml/2017/3/14/589

I don't have this patch in my inbox, but the i2c core will still match 
on compatibles with no vendor prefix? If not, those need to be added to 
the match table too.

Rob
