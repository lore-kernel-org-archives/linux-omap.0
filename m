From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH 0/5] irqchip: kill the GIC routable domain
Date: Tue, 09 Dec 2014 09:53:42 +0000
Message-ID: <5486C6A6.8060702@arm.com>
References: <1417873576-10463-1-git-send-email-marc.zyngier@arm.com> <20141207171646.GA12049@kahuna> <20141207180322.GA15688@kahuna> <54856B21.6070104@arm.com> <20141208224116.GA2538@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:46767 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754092AbaLIJxv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Dec 2014 04:53:51 -0500
In-Reply-To: <20141208224116.GA2538@kahuna>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <ssantosh@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Stefan Agner <stefan@agner.ch>, Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 08/12/14 22:41, Nishanth Menon wrote:

> Anyways.. The following diff[1] on top of your branch makes DRA7 work - I
> assume you will squash as needed and repost with linux-omap mailing list
> in CC.

Brilliant. I'll squash that into my tree and repost at some point.

> I increased the scope of testing knowing that WUGEN is present in many
> A9 based TI platforms as well.. and at least OMAP4 showed flakiness in
> my testing.. Also a few notes:
> 
> Stuff like: am437x is a bit questionable (interrupt-parent probably should be wugen?)
> 175:          0       GIC  39  tps65218 
> 
> OMAP5: (should be wugen?)
> 308:       4323          0       GIC 106  OMAP UART2
> 411:          0          0       GIC 151  twl6040
> 405:          1          0       GIC  39  palmas

Well, I can't really tell. Someone with access to the documentation
should be able to find out.

> OMAP4 serial port is flaky -> not sure if it is due to routing of GIC to UART2 and not via WUGEN
> IRQ branch: with my fix applied:
> ---------------------------------

[...]

> 18: pandaboard-es:  Boot FAIL: http://slexy.org/raw/s20ty0Z6i5 (not expected)
> 19: pandaboard-vanilla:  Boot FAIL: http://slexy.org/raw/s20BYfaMd2 (not expected)

If I read the log correctly, the serial port stops responding after a while?

[...]

> I suggest skipping 3.19 if possible and giving it a more detailed time
> in linux-next with omap4 etc being more thoroughly being tested before
> letting it through, if possible.

None of that code is for 3.19 (that ship has sailed a long time ago). My
plan is to hit 3.20, so it should be in -next by -rc4 or so.

> [1] ------------- diff ------------
>  arch/arm/boot/dts/dra7-evm.dts |    2 +-
>  arch/arm/boot/dts/dra7.dtsi    |   23 +++++++++++++----------
>  drivers/irqchip/irq-crossbar.c |    4 ++--
>  3 files changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
> index c6ce625..d024429 100644
> --- a/arch/arm/boot/dts/dra7-evm.dts
> +++ b/arch/arm/boot/dts/dra7-evm.dts
> @@ -323,7 +323,7 @@
>  	status = "okay";
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&uart1_pins>;
> -	interrupts-extended = <&gic GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
> +	interrupts-extended = <&crossbar_mpu GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
>  			      <&dra7_pmx_core 0x3e0>;
>  };

Ah, I obviously missed quite a few of these...

[...]

> diff --git a/drivers/irqchip/irq-crossbar.c b/drivers/irqchip/irq-crossbar.c
> index b44915a..f7daff0 100644
> --- a/drivers/irqchip/irq-crossbar.c
> +++ b/drivers/irqchip/irq-crossbar.c
> @@ -99,7 +99,7 @@ static int allocate_gic_irq(struct irq_domain *domain, unsigned virq,
>  	if (err)
>  		cb->irq_map[i] = IRQ_FREE;
>  	else
> -		cb->write(hwirq, i);
> +		cb->write(i, hwirq);
>  
>  	return err;
>  }
> @@ -353,4 +353,4 @@ static int __init irqcrossbar_init(struct device_node *node,
>  	return 0;
>  }
>  
> -IRQCHIP_DECLARE(ti_irqcrossbar, "ti,irqcrossbar", irqcrossbar_init);
> +IRQCHIP_DECLARE(ti_irqcrossbar, "ti,irq-crossbar", irqcrossbar_init);

Ah, nice catch. Thanks a lot for the testing and the fixes. I'll try to
get a panda up and running (I'm sure I have one collecting dust
somewhere), and see if I can get it to behave.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
