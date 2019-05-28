From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: omap2plus_defconfig broken on ARMv6
Date: Tue, 28 May 2019 07:03:36 +0200
Message-ID: <56990EA4-E280-4C78-9536-E8AE1964725E@goldelico.com>
References: <20190524220731.GB4597@t60.musicnaut.iki.fi>
 <20190527055746.GH5447@atomide.com>
 <20190527204135.GA24195@darkstar.musicnaut.iki.fi>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190527204135.GA24195@darkstar.musicnaut.iki.fi>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


> Am 27.05.2019 um 22:41 schrieb Aaro Koskinen <aaro.koskinen@iki.fi>:
> 
> Hi,
> 
> On Sun, May 26, 2019 at 10:57:46PM -0700, Tony Lindgren wrote:
>> * Aaro Koskinen <aaro.koskinen@iki.fi> [190524 22:07]:
>>> Noticed today that booting omap2plus_defconfig on N8x0 crashes
>>> early. Disabling CONFIG_SMP makes it work.
>> 
>> OK. It sure used to work when I last tested but that's been quite
>> a while now. Any ideas which commit caused the ldrexd regression?
> 
> No idea, I tried even 3.16 and even that seems to have the same issue
> if multi v6/v7 and SMP is selected.

Could it be an unknown compiler issue?

I just had the effect that v5.2-rc1 started to try to build gcc-plugins
(something I had never heard of before) because some Kconfig defaults
were changed. And my cross-compiler setup is not capable of doing that.

I have grepped a little into the code and the offending assembler statements
seem to come from __cmpxchg64() which is indeed very old [1]. But the question
may be why this 64 bit code is compiled for a 32 bit ARMv6.

Other code seems to be guarded by #ifndef CONFIG_CPU_V6	/* min ARCH >= ARMv6K */

[1]: https://elixir.bootlin.com/linux/v5.2-rc2/source/arch/arm/include/asm/cmpxchg.h#L244
     https://elixir.bootlin.com/linux/v3.16.68/source/arch/arm/include/asm/cmpxchg.h#L230
