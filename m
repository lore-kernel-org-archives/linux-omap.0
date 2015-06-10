From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 09/15] mfd: kill off set_irq_flags usage
Date: Wed, 10 Jun 2015 14:43:54 +0200
Message-ID: <CACRpkdZkDbuAgMmpHaKVSD_cwo1ykV4jFsMUJOb3E=emRrzYXw@mail.gmail.com>
References: <1433874401-27161-1-git-send-email-robh@kernel.org>
	<1433874401-27161-10-git-send-email-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1433874401-27161-10-git-send-email-robh@kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Russell King <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "arm@kernel.org" <arm@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Milo Kim <milo.kim@ti.com>, Kumar Gala <galak@codeaurora.org>, Andy Gross <agross@codeaurora.org>, David Brown <davidb@codeaurora.org>, Tony Lindgren <tony@atomide.com>, patches@opensource.wolfsonmicro.com, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, linux-soc@vger.kernel.org, Linux-OMAP <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Jun 9, 2015 at 8:26 PM, Rob Herring <robh@kernel.org> wrote:

> set_irq_flags is ARM specific with custom flags which have genirq
> equivalents. Convert drivers to use the genirq interfaces directly, so we
> can kill off set_irq_flags. The translation of flags is as follows:
>
> IRQF_VALID -> !IRQ_NOREQUEST
> IRQF_PROBE -> !IRQ_NOPROBE
> IRQF_NOAUTOEN -> IRQ_NOAUTOEN
>
> For IRQs managed by an irqdomain, the irqdomain core code handles clearing
> and setting IRQ_NOREQUEST already, so there is no need to do this in
> .map() functions and we can simply remove the set_irq_flags calls. Some
> users also set IRQ_NOPROBE and this has been maintained although it is not
> clear that is really needed. There appears to be a great deal of blind
> copy and paste of this code.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Milo Kim <milo.kim@ti.com>
> Cc: Kumar Gala <galak@codeaurora.org>
> Cc: Andy Gross <agross@codeaurora.org>
> Cc: David Brown <davidb@codeaurora.org>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: patches@opensource.wolfsonmicro.com
> Cc: linux-arm-msm@vger.kernel.org
> Cc: linux-soc@vger.kernel.org
> Cc: linux-omap@vger.kernel.org

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
