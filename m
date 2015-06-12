From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 01/15] ARM: kill off set_irq_flags usage
Date: Fri, 12 Jun 2015 09:35:33 -0500
Message-ID: <CAL_JsqKvLW-0p=A3BHoAYH_+ODCTt4C07OAHc__rUzC0jZ5p5g@mail.gmail.com>
References: <1433874401-27161-1-git-send-email-robh@kernel.org>
 <1433874401-27161-2-git-send-email-robh@kernel.org> <alpine.LNX.2.00.1506121604200.30841@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1506121604200.30841@localhost>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>
Cc: Russell King <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "arm@kernel.org" <arm@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Imre Kaloz <kaloz@openwrt.org>, Krzysztof Halasa <khalasa@piap.pl>, Greg Ungerer <gerg@uclinux.org>, Roland Stigge <stigge@antcom.de>, Tony Lindgren <tony@atomide.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Simtec Linux Team <linux@simtec.co.uk>, Kukjin
List-Id: linux-omap@vger.kernel.org

On Fri, Jun 12, 2015 at 9:05 AM, Hans Ulli Kroll
<ulli.kroll@googlemail.com> wrote:
>
>
> On Tue, 9 Jun 2015, Rob Herring wrote:
>
>> set_irq_flags is ARM specific with custom flags which have genirq
>> equivalents. Convert drivers to use the genirq interfaces directly, so we
>> can kill off set_irq_flags. The translation of flags is as follows:
>>
>> IRQF_VALID -> !IRQ_NOREQUEST
>> IRQF_PROBE -> !IRQ_NOPROBE
>> IRQF_NOAUTOEN -> IRQ_NOAUTOEN
>>
>> For IRQs managed by an irqdomain, the irqdomain core code handles clearing
>> and setting IRQ_NOREQUEST already, so there is no need to do this in
>> .map() functions and we can simply remove the set_irq_flags calls. Some
>> users also set IRQ_NOPROBE and this has been maintained although it is not
>> clear that is really needed. There appears to be a great deal of blind
>> copy and paste of this code.
>>
>
> for mach-gemini
> Signed-off-by: Hans Ulli Kroll <ulli.kroll@googlemail.com>

You mean acked-by, right?

Rob
