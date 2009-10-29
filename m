From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: [PATCH] OMAP35xx: Added SDIO IRQ support
Date: Thu, 29 Oct 2009 08:00:33 +0100
Message-ID: <4AE93D91.4020300@googlemail.com>
References: <54d94f230910280618l1b770505lfc88af7592777763@mail.gmail.com> <000001ca57e8$e4108ec0$544ff780@am.dhcp.ti.com> <4AE89FEC.9000309@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:45233 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756526AbZJ2HAi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Oct 2009 03:00:38 -0400
Received: by fg-out-1718.google.com with SMTP id 16so856398fgg.1
        for <linux-omap@vger.kernel.org>; Thu, 29 Oct 2009 00:00:41 -0700 (PDT)
In-Reply-To: <4AE89FEC.9000309@googlemail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Madhusudhan <madhu.cr@ti.com>, 'Phaneendra Kumar Alapati' <phani@embwise.com>
Cc: linux-omap@vger.kernel.org, Steve Sakoman <sakoman@gmail.com>

Dirk Behme wrote:
> Madhusudhan wrote:
>>
>>> -----Original Message-----
>>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>>> owner@vger.kernel.org] On Behalf Of Phaneendra Kumar Alapati
>>> Sent: Wednesday, October 28, 2009 8:19 AM
>>> To: linux-omap@vger.kernel.org
>>> Subject: [PATCH] OMAP35xx: Added SDIO IRQ support
>>>
>>> This patch adds SDIO IRQ support for omap hsmmc driver.
>>>
>>> Signed-off-by: Phaneendra Kumar Alapati <phani@embwise.com>
>>> ---
>>>  drivers/mmc/host/omap_hsmmc.c |    62 ++--
>>>  1 files changed, 55 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/omap_hsmmc.c 
>>> b/drivers/mmc/host/omap_hsmmc.c
>>> index 1cf9cfb..a540626 100644
>>> --- a/drivers/mmc/host/omap_hsmmc.c
>>> +++ b/drivers/mmc/host/omap_hsmmc.c
>>> @@ -92,6 +92,10 @@
>>>  #define DUAL_VOLT_OCR_BIT    7
>>>  #define SRC            (1 << 25)
>>>  #define SRD            (1 << 26)
>>> +#define OMAP_HSMMC_CARD_INT    BIT(8)
>>> +#define SDIO_INT_EN        BIT(8)
>> Why multiple defines of the same? One of them should be enough.
> 
> What I think meant here is
> 
> #define CIRQ            (1 << 8)
> #define CIRQ_ENABLE        (1 << 8)
> 
> One is for the status register, the other is for the interrupt enable 
> registers. To be compatible with the TRM, I would use both in this way.
> 
>>> +#define CTPL            BIT(11)
>>> +#define CLKEXTFREE        BIT(16)
>> Can we define them in the same way as other defines to maintain 
>> uniformity?
> 
> Yes, ack.
> 
>>>  /*
>>>   * FIXME: Most likely all the data using these _DEVID defines should 
>>> come
>>> @@ -149,6 +153,7 @@ struct mmc_omap_host {
>>>      int            slot_id;
>>>      int            dbclk_enabled;
>>>      int            response_busy;
>>> +    int            sdio_int;
>>
>> What purpose does this serve? IMHO, this is not needed.
> 
> Hmm. This is set to != 0 in omap_hsmmc_enable_sdio_irq() when IRQs are 
> enabled. Then in mmc_omap_start_command() these interrupts are enabled 
> again if sdio_int is != 0. Yes, looks unneeded, indeed. But maybe there 
> is some trick ;)
> 
>>>      struct    omap_mmc_platform_data    *pdata;
>>>  };
>>>
>>> @@ -240,8 +245,13 @@ mmc_omap_start_command(struct mmc_omap_host
>>> *host, struct mmc_command *cmd,
> 
> Patch is line wrapped by mailer.
> 
>>>       * Clear status bits and enable interrupts
>>>       */
>>>      OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
>>> -    OMAP_HSMMC_WRITE(host->base, ISE, INT_EN_MASK);
>>> -    OMAP_HSMMC_WRITE(host->base, IE, INT_EN_MASK);
>>> +    if (host->sdio_int) {
>>> +        OMAP_HSMMC_WRITE(host->base, ISE, (INT_EN_MASK |
>>> SDIO_INT_EN));
>>> +        OMAP_HSMMC_WRITE(host->base, IE, (INT_EN_MASK |
>> SDIO_INT_EN));
>> Why? It is being taken care in "enable_sdio_irq".
> 
> Yes, why?
> 
>>> +    } else {
>>> +        OMAP_HSMMC_WRITE(host->base, ISE, INT_EN_MASK);
>>> +        OMAP_HSMMC_WRITE(host->base, IE, INT_EN_MASK);
>>> +    }
>>>
>>>      host->response_busy = 0;
>>>      if (cmd->flags & MMC_RSP_PRESENT) {
>>> @@ -430,17 +440,27 @@ static irqreturn_t mmc_omap_irq(int irq, void
>>> *dev_id)
>>>      struct mmc_data *data;
>>>      int end_cmd = 0, end_trans = 0, status;
>>>
>>> +    data = host->data;
>>> +    status = OMAP_HSMMC_READ(host->base, STAT);
>>> +    dev_dbg(mmc_dev(host->mmc), "IRQ Status is %x\n", status);
>> Why are these moved up?
> 
> Yes, why? Why not move the block below down instead?
> 
>>> +
>>> +    if (host->mmc->caps & MMC_CAP_SDIO_IRQ) {
>>> +        if (status & OMAP_HSMMC_CARD_INT) {
>>> +            dev_dbg(mmc_dev(host->mmc),
>>> +                    " SDIO CARD interrupt status %x\n",
>>> +                    status);
>>> +            mmc_signal_sdio_irq(host->mmc);
>>> +        }
>>> +    }
> 
> - It makes no sense to print status in dev_dbg here again, as it is 
> already printed some lines above. Something like
> 
> dev_dbg(mmc_dev(host->mmc), "SDIO interrupt\n");
> 
> would be sufficient here.
> 
> - Why isn't IRQ acknowledged here? I.e. why not doing something like
> 
> OMAP_HSMMC_WRITE(host->base, IE, OMAP_HSMMC_READ(host->base, IE) & 
> ~(CIRQ_ENABLE));
> 
> here?
> 
> - No return IRQ_HANDLED; here? Mmm, maybe this makes sense.
> 
>>>      if (host->mrq == NULL) {
>>>          OMAP_HSMMC_WRITE(host->base, STAT,
>>> -            OMAP_HSMMC_READ(host->base, STAT));
>>> +                OMAP_HSMMC_READ(host->base, STAT));
>> This just adds a tab space. Not needed.
> 
> Ack.
> 
>>>          /* Flush posted write */
>>>          OMAP_HSMMC_READ(host->base, STAT);
>>>          return IRQ_HANDLED;
>>>      }
>>>
>>> -    data = host->data;
>>> -    status = OMAP_HSMMC_READ(host->base, STAT);
>>> -    dev_dbg(mmc_dev(host->mmc), "IRQ Status is %x\n", status);
>> Check my comment above.
> 
> Yes, from theory it looks better to move the new code below this, instead.
> 
>>>      if (status & ERR) {
>>>  #ifdef CONFIG_MMC_DEBUG
>>> @@ -932,6 +952,29 @@ static int omap_hsmmc_get_ro(struct mmc_host *mmc)
>>>      return pdata->slots[0].get_ro(host->dev, 0);
>>>  }
>>>
>>> +static void omap_hsmmc_enable_sdio_irq(struct mmc_host *mmc, int 
>>> enable)
>>> +{
>>> +    struct mmc_omap_host *host = mmc_priv(mmc);
>>> +
>>> +    host->sdio_int = enable;
>>> +    if (enable) {
>>> +        OMAP_HSMMC_WRITE(host->base, ISE,
>>> +                (OMAP_HSMMC_READ(host->base, ISE) |
>>> +                 OMAP_HSMMC_CARD_INT));
>>> +        OMAP_HSMMC_WRITE(host->base, IE,
>>> +                (OMAP_HSMMC_READ(host->base, IE) |
>>> +                 OMAP_HSMMC_CARD_INT));
>>> +    } else {
>>> +        OMAP_HSMMC_WRITE(host->base, IE,
>>> +                (OMAP_HSMMC_READ(host->base, IE) &
>>> +                 (~OMAP_HSMMC_CARD_INT)));
>>> +        OMAP_HSMMC_WRITE(host->base, ISE,
>>> +                (OMAP_HSMMC_READ(host->base, ISE) &
>>> +                 (~OMAP_HSMMC_CARD_INT)));
>>> +    }
>>> +
>>> +}
>>> +
>>>  static void omap_hsmmc_init(struct mmc_omap_host *host)
>>>  {
>>>      u32 hctl, capa, value;
>>> @@ -964,7 +1007,7 @@ static struct mmc_host_ops mmc_omap_ops = {
>>>      .set_ios = omap_mmc_set_ios,
>>>      .get_cd = omap_hsmmc_get_cd,
>>>      .get_ro = omap_hsmmc_get_ro,
>>> -    /* NYET -- enable_sdio_irq */
>>> +    .enable_sdio_irq = omap_hsmmc_enable_sdio_irq,
>>>  };
>>>
>>>  static int __init omap_mmc_probe(struct platform_device *pdev)
>>> @@ -1011,6 +1054,7 @@ static int __init omap_mmc_probe(struct
>>> platform_device *pdev)
> 
> Greetings from the mailer again.
> 
>>>      host->irq    = irq;
>>>      host->id    = pdev->id;
>>>      host->slot_id    = 0;
>>> +    host->sdio_int     = 0;
>> Not needed.
>>
>>>      host->mapbase    = res->start;
>>>      host->base    = ioremap(host->mapbase, SZ_4K);
>>>
>>> @@ -1080,6 +1124,10 @@ static int __init omap_mmc_probe(struct
>>> platform_device *pdev)
>>>      else if (pdata->slots[host->slot_id].wires >= 4)
>>>          mmc->caps |= MMC_CAP_4_BIT_DATA;
>>>
>>> +    mmc->caps |= MMC_CAP_SDIO_IRQ;
>>> +    OMAP_HSMMC_WRITE(host->base, CON,
>>> +            OMAP_HSMMC_READ(host->base, CON) | (CTPL |
>> CLKEXTFREE));
>> How about moving this to "enable_sdio_irq" so that these are done for 
>> SDIO
>> alone? Also can be disabled in the same fn.
> 
> Ack. But I think that mmc->caps |= MMC_CAP_SDIO_IRQ has to stay here. 
> Else "enable_sdio_irq" will never be called (?)
> 
> All in all, I wonder why IBG bit isn't used in this patch. Is this 
> tested with 1 or 4 bit (wire) SDIO?
> 
> Just for reference the slightly modified version of this patch for 
> testing in attachment (based on pure theory ;) ). I will come back with 
> testing results.

I promised to come back with test results. As mentioned in this thread 
already, I can't test on my own yet, instead Steve (many, many 
thanks!) tests it on Overo air. Overo air uses Marvell's 88W8686 
connected to MMC port 2 in 4 bit configuration.

First, my 'revised' version of Phani's patch doesn't work at all. 
There seem to be some tricks in Phani's original patch we (I?) missed 
in above review. I tried to incorporate all review comments, result is 
a non working patch.

Second, Steve tested Phani's original patch, too (with manually fixed 
wrapped lines). Let me copy his comments:

-- cut --
this is looking better!

libertas_sdio: Libertas SDIO driver
libertas_sdio: Copyright Pierre Ossman
libertas_sdio mmc1:0001:1: firmware: requesting sd8686_helper.bin
libertas_sdio mmc1:0001:1: firmware: requesting sd8686.bin
libertas: 00:19:88:20:fa:23, fw 9.70.3p24, cap 0x00000303
libertas: eth1: Marvell WLAN 802.11 adapter
udev: renamed network interface eth1 to wlan0

(with the other patches we always had timeouts and errors)

But performance is really bad (and flakey!)

When it does work, I get 5.88K/s as compared to 120K/s with the 
unpatched code.  It also dies fairly quickly.

No error messages, so I am really not sure what is going on!
-- cut --

Any ideas?

Thanks to Phani and Steve, best regards

Dirk
