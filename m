From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 03/12] mtd: nand: omap: Move IRQ handling from GPMC to
 NAND driver
Date: Fri, 31 Jul 2015 13:21:17 +0300
Message-ID: <55BB4C1D.5080905@ti.com>
References: <1436531019-18088-1-git-send-email-rogerq@ti.com> <1436531019-18088-4-git-send-email-rogerq@ti.com> <20150713071008.GC26485@atomide.com> <55A38D2E.9010500@ti.com> <20150713124059.GF26485@atomide.com> <55B8C1D5.3090807@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55B8C1D5.3090807-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 29/07/15 15:06, Roger Quadros wrote:
> Tony,
> 
> On 13/07/15 15:40, Tony Lindgren wrote:
>> * Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> [150713 03:07]:
>>> Tony,
>>>
>>> On 13/07/15 10:10, Tony Lindgren wrote:
>>>> * Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> [150710 05:26]:
>>>>> Since the Interrupt Events are used only by the NAND driver,
>>>>> there is no point in managing the Interrupt registers
>>>>> in the GPMC driver and complicating it with irqchip modeling.
>>>>
>>>> I don't think it's a good idea to allow external drivers to
>>>> tinker directly with GPMC registers. How about just set up GPMC
>>>> as an irqchip for the edge detection interrupts?
>>>>
>>>> I think we already have devices with multiple NAND chips. And
>>>> there's nothing stopping other drivers from using the edge
>>>> detection interrupts.
>>>
>>> OK. The GPMC_IRQ registers manage 2 NAND specific interrupts
>>> (terminalcount and fifo) and 'n' WAIT pin edge interrupts.
>>>
>>>  So we can model this as a irqchip with 'n + 2' interrupts.
>>
>> OK
> 
> For the wait pins irqchip is not sufficient and it needs to be gpiochip
> with irqchip. Waitpin status can be read from GPIO_STATUS register.
> 
> Just getting the interrupt is not enough and we want to know if the
> line is high or low. That is how nand->dev_ready works.
> 
> How about having 2 IRQ domains?
> One is irqchip with 2 interrupts (terminalcount and fifo) and second is
> gpiochip + irqchip for the n wait pins.
> 
> The nand driver can then be modified to use GPIO to get Read/Busy
> pin status from the wait pin.

One more observation I've had is that using irqchip modelling for
the 2 NAND events causes a performance impact.

Using mtd_oobtest I see the following on dra7-evm

1) v4.2-rc4 with prefetch-polled (no IRQs used)
mtd_speedtest: eraseblock write speed is 7142 KiB/s
mtd_speedtest: eraseblock read speed is 13721 KiB/s

2) v4.2-rc4 with prefetch-irq (IRQchip model)
eraseblock write speed is 5475 KiB/s
eraseblock read speed is 6420 KiB/s

3) this series (*) with prefetch-irq (no IRQchip model, nand driver
directly accesses irqstatus/irqenable)
eraseblock write speed is 6564 KiB/s
eraseblock read speed is 10850 KiB/s

(*) diff at the end is required on top to fix an issue with this series.

So should we continue IRQchip modelling for the NAND events
or use the GPMC interrupt as shared and add APIs to access
the NAND bits of the IRQSTATUS/ENABLE register.

cheers,
-roger

--

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index fecc054..26ef2bd 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -1832,13 +1832,14 @@ static int omap_get_dt_info(struct device *dev, struct omap_nand_info *info)
 		for (i = 0; i < ARRAY_SIZE(nand_xfer_types); i++) {
 			if (!strcasecmp(s, nand_xfer_types[i])) {
 				info->xfer_type = i;
-				break;
+				goto next;
 			}
 		}
 
 		dev_err(dev, "unrecognized value for ti,nand-xfer-type\n");
 		return -EINVAL;
 	}
+next:
 
 	of_get_nand_on_flash_bbt(child);
 
diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 26ef2bd..e8bdff5 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -670,17 +670,12 @@ static irqreturn_t omap_nand_irq(int this_irq, void *dev)
 			goto done;
 	}
 
-	/* Clear FIFOEVENT STATUS */
-	irqstatus &= ~GPMC_IRQ_FIFOEVENT;
-	writel(irqstatus, info->reg.gpmc_irqstatus);
-
 	return IRQ_HANDLED;
 
 done:
 	complete(&info->comp);
 
-	/* Clear FIFOEVENT and TERMCOUNT STATUS */
-	irqstatus &= ~(GPMC_IRQ_TERMCOUNT | GPMC_IRQ_FIFOEVENT);
+	/* Clear IRQ STATUS */
 	writel(irqstatus, info->reg.gpmc_irqstatus);
 
 	/* Disable Interrupt generation */

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
