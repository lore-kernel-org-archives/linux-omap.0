From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH] gpio: gpio-omap: fix level interrupt idling
Date: Wed, 6 Mar 2019 17:26:01 +0200
Message-ID: <67b445e2-bfbe-f3be-15e2-b47bbb6cf4e7@ti.com>
References: <20190301190252.20615-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190301190252.20615-1-tony@atomide.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Keerthy <j-keerthy@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-gpio@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org



On 01.03.19 21:02, Tony Lindgren wrote:
> From: Russell King <rmk+kernel@armlinux.org.uk>
> 
> Tony notes that the GPIO module does not idle when level interrupts are
> in use, as the wakeup appears to get stuck.
> 
> After extensive investigation, it appears that the wakeup will only be
> cleared if the interrupt status register is cleared while the interrupt
> is enabled. However, we are currently clearing it with the interrupt
> disabled for level-based interrupts.
> 
> It is acknowledged that this observed behaviour conflicts with a
> statement in the TRM:
> 
> CAUTION
>   After servicing the interrupt, the status bit in the interrupt status
>   register (GPIOi.GPIO_IRQSTATUS_0 or GPIOi.GPIO_IRQSTATUS_1) must be
>   reset and the interrupt line released (by setting the corresponding
>   bit of the interrupt status register to 1) before enabling an
>   interrupt for the GPIO channel in the interrupt-enable register
>   (GPIOi.GPIO_IRQSTATUS_SET_0 or GPIOi.GPIO_IRQSTATUS_SET_1) to prevent
>   the occurrence of unexpected interrupts when enabling an interrupt
>   for the GPIO channel.
> 
> However, this does not appear to be a practical problem.
> 
> Further, as reported by Grygorii Strashko <grygorii.strashko@ti.com>,
> the TI Android kernel tree has an earlier similar patch as "GPIO: OMAP:
> Fix the sequence to clear the IRQ status" saying:
> 
>  if the status is cleared after disabling the IRQ then sWAKEUP will not
>  be cleared and gates the module transition
> 
> When we unmask the level interrupt after the interrupt has been handled,
> enable the interrupt and only then clear the interrupt. If the interrupt
> is still pending, the hardware will re-assert the interrupt status.
> 
> Should the caution note in the TRM prove to be a problem, we could
> use a clear-enable-clear sequence instead.
> 
> Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
> Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> Cc: Keerthy <j-keerthy@ti.com>
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> [tony@atomide.com: updated comments based on an earlier TI patch]
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
> 
> Obviously no rush to get this into v5.0-rc cycle, but this should be
> tagged with Cc stable after people have reviewed and tested this.
> 
> ---
>  drivers/gpio/gpio-omap.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 

Thank you.
Acked-by: Grygorii Strashko <grygorii.strashko@ti.com>

-- 
Best regards,
grygorii
