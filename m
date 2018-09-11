From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] gpio: omap: Add level wakeup handling for omap4 based SoCs
Date: Tue, 11 Sep 2018 11:24:19 -0700
Message-ID: <20180911182419.GC5662@atomide.com>
References: <20180910200624.4494-1-tony@atomide.com>
 <444bae18-9737-8e13-2a0f-c08863ae1336@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <444bae18-9737-8e13-2a0f-c08863ae1336@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, Keerthy <j-keerthy@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Tero Kristo <t-kristo@ti.com>, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Grygorii Strashko <grygorii.strashko@ti.com> [180911 17:02]:
> I agree with patch in general as it seems will not break anything and
>  change localized for omap4 only.

OK cool. I'll be posting a related patch to get rid of
the custom PM functions too.

> But I'd be very appreciated if you can provide more information about issue
> which helps better understand it, so could you, if possible, collect dump of:
> - GPIO bank regs right before entering WFI state in Idle (or as close as possible)
>   I'm interesting in sysc/s, ctrl, irq's regs (+wakupen) and GPIO_DEBOUNCEN first of all
> - GPIO bank CLKCTRL registers (is it "in transition" state).
> in non working case.

The thing is there is nothing special in the GPIO registers in the
non-working vs working case. The GPIO_DEBOUNCEN was my first suspect
too, but that's not enabled.

The only difference is that the related CLKSTCTRL CLKACTIVITY bit
for the 32K_GFCLK clock stays stuck showing busy after a level interrupt
and wkup_en set. The 32K_GFCLK bit will only clear after reset of the
GPIO module in question until a new level interrupt is seen.

So with this patch we go from the following dump on omap4 gpio
bank1 running before idle:

GPIO_IRQSTATUS_RAW      0x4a310024 = 0000000000
GPIO_IRQSTATUS_RAW2     0x4a310028 = 0000000000
GPIO_IRQSTATUS_0        0x4a31002c = 0000000000
GPIO_IRQSTATUS_1        0x4a310030 = 0000000000
GPIO_IRQSTATUS_SET_0    0x4a310034 = 0x00000080
GPIO_IRQSTATUS_CLR_0    0x4a31003c = 0x00000080
GPIO_IRQWAKEN_0         0x4a310044 = 0x00000080 <- set
GPIO_LEVELDETECT0       0x4a310140 = 0000000000
GPIO_LEVELDETECT1       0x4a310144 = 0x00000080
GPIO_RISINGDETECT       0x4a310148 = 0000000000
GPIO_FALLINGDETECT      0x4a31014c = 0000000000
GPIO_DEBOUNCENABLE      0x4a310150 = 0000000000
GPIO_DEBOUNCINGTIME     0x4a310154 = 0000000000

to the following dump where GPIO_IRQWAKEN_0 is not set until
for idle:

GPIO_IRQSTATUS_RAW      0x4a310024 = 0000000000
GPIO_IRQSTATUS_RAW2     0x4a310028 = 0000000000
GPIO_IRQSTATUS_0        0x4a31002c = 0000000000
GPIO_IRQSTATUS_1        0x4a310030 = 0000000000
GPIO_IRQSTATUS_SET_0    0x4a310034 = 0x00000080
GPIO_IRQSTATUS_CLR_0    0x4a31003c = 0x00000080
GPIO_IRQWAKEN_0         0x4a310044 = 0000000000 <- cleared
GPIO_LEVELDETECT0       0x4a310140 = 0000000000
GPIO_LEVELDETECT1       0x4a310144 = 0x00000080
GPIO_RISINGDETECT       0x4a310148 = 0000000000
GPIO_FALLINGDETECT      0x4a31014c = 0000000000
GPIO_DEBOUNCENABLE      0x4a310150 = 0000000000
GPIO_DEBOUNCINGTIME     0x4a310154 = 0000000000

Regards,

Tony
