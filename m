From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: [PATCH] OMAP35xx: Added SDIO IRQ support
Date: Thu, 29 Oct 2009 22:08:16 +0100
Message-ID: <4AEA0440.9020607@googlemail.com>
References: <54d94f230910280618l1b770505lfc88af7592777763@mail.gmail.com> 	<000001ca57e8$e4108ec0$544ff780@am.dhcp.ti.com> <4AE89FEC.9000309@googlemail.com> 	<002d01ca5810$96534100$544ff780@am.dhcp.ti.com> <54d94f230910290227o6c56e921rb91558bdac462d65@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:54311 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753079AbZJ2VIT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Oct 2009 17:08:19 -0400
Received: by bwz27 with SMTP id 27so2808612bwz.21
        for <linux-omap@vger.kernel.org>; Thu, 29 Oct 2009 14:08:22 -0700 (PDT)
In-Reply-To: <54d94f230910290227o6c56e921rb91558bdac462d65@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Phaneendra Kumar Alapati <phani@embwise.com>
Cc: Madhusudhan <madhu.cr@ti.com>, linux-omap@vger.kernel.org


Comments below...

Phaneendra Kumar Alapati wrote:
> Dirk and Madhu, Thanks for the review/comments. I have explained below
> the reasons behind certain changes i made esp the interrupt enabling
> and irq routine changes.
> 
> On Thu, Oct 29, 2009 at 2:22 AM, Madhusudhan <madhu.cr@ti.com> wrote:
>>
>>> -----Original Message-----
>>> From: Dirk Behme [mailto:dirk.behme@googlemail.com]
>>> Sent: Wednesday, October 28, 2009 2:48 PM
>>> To: Madhusudhan; 'Phaneendra Kumar Alapati'
>>> Cc: linux-omap@vger.kernel.org
>>> Subject: Re: [PATCH] OMAP35xx: Added SDIO IRQ support
>>>
>>> Madhusudhan wrote:
>>>>> -----Original Message-----
>>>>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>>>>> owner@vger.kernel.org] On Behalf Of Phaneendra Kumar Alapati
>>>>> Sent: Wednesday, October 28, 2009 8:19 AM
>>>>> To: linux-omap@vger.kernel.org
>>>>> Subject: [PATCH] OMAP35xx: Added SDIO IRQ support
>>>>>
>>>>> This patch adds SDIO IRQ support for omap hsmmc driver.
>>>>>
>>>>> Signed-off-by: Phaneendra Kumar Alapati <phani@embwise.com>
>>>>> ---
>>>>>  drivers/mmc/host/omap_hsmmc.c |    62 ++--
>>>>>  1 files changed, 55 insertions(+), 7 deletions(-)
>>>>>
>>>>> diff --git a/drivers/mmc/host/omap_hsmmc.c
>>> b/drivers/mmc/host/omap_hsmmc.c
>>>>> index 1cf9cfb..a540626 100644
>>>>> --- a/drivers/mmc/host/omap_hsmmc.c
>>>>> +++ b/drivers/mmc/host/omap_hsmmc.c
>>>>> @@ -92,6 +92,10 @@
>>>>>  #define DUAL_VOLT_OCR_BIT 7
>>>>>  #define SRC                       (1 << 25)
>>>>>  #define SRD                       (1 << 26)
>>>>> +#define OMAP_HSMMC_CARD_INT       BIT(8)
>>>>> +#define SDIO_INT_EN               BIT(8)
>>>> Why multiple defines of the same? One of them should be enough.
>>> What I think meant here is
>>>
>>> #define CIRQ                  (1 << 8)
>>> #define CIRQ_ENABLE           (1 << 8)
>>>
>>> One is for the status register, the other is for the interrupt enable
>>> registers. To be compatible with the TRM, I would use both in this way.
>>>
>>>>> +#define CTPL                      BIT(11)
>>>>> +#define CLKEXTFREE                BIT(16)
>>>> Can we define them in the same way as other defines to maintain
>>> uniformity?
>>>
>>> Yes, ack.
>>>
> 
> I have kept separate macros in reference to the TRM as they are for
> different registers. To keep the code simpler they can be merged
> 
>>>>>  /*
>>>>>   * FIXME: Most likely all the data using these _DEVID defines should
>>> come
>>>>> @@ -149,6 +153,7 @@ struct mmc_omap_host {
>>>>>    int                     slot_id;
>>>>>    int                     dbclk_enabled;
>>>>>    int                     response_busy;
>>>>> +  int                     sdio_int;
>>>> What purpose does this serve? IMHO, this is not needed.
>>> Hmm. This is set to != 0 in omap_hsmmc_enable_sdio_irq() when IRQs are
>>> enabled. Then in mmc_omap_start_command() these interrupts are enabled
>>> again if sdio_int is != 0. Yes, looks unneeded, indeed. But maybe
>>> there is some trick ;)
>>>
>>>>>    struct  omap_mmc_platform_data  *pdata;
>>>>>  };
>>>>>
>>>>> @@ -240,8 +245,13 @@ mmc_omap_start_command(struct mmc_omap_host
>>>>> *host, struct mmc_command *cmd,
>>> Patch is line wrapped by mailer.
>>>
>>>>>     * Clear status bits and enable interrupts
>>>>>     */
>>>>>    OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
>>>>> -  OMAP_HSMMC_WRITE(host->base, ISE, INT_EN_MASK);
>>>>> -  OMAP_HSMMC_WRITE(host->base, IE, INT_EN_MASK);
>>>>> +  if (host->sdio_int) {
>>>>> +          OMAP_HSMMC_WRITE(host->base, ISE, (INT_EN_MASK |
>>>>> SDIO_INT_EN));
>>>>> +          OMAP_HSMMC_WRITE(host->base, IE, (INT_EN_MASK |
>>>> SDIO_INT_EN));
>>>> Why? It is being taken care in "enable_sdio_irq".
>>> Yes, why?
>>>
> 
> Once sdio interrupts are enabled through enable_sdio_irq, commands
> which are sent further disable the sdio interrupts by directly over
> writing to the IE and ISE without preserving currently enabled
> interrupts.
> 
> Best option is to read+modify+write the IE and ISE register as i did
> in enable_sdio_irq. But the IE and ISE register seem to be modified in
> other places too, so i made use of sdio_int flag to keep track of sdio
> interrupt enabling/disabling.
> 
>>>>> +  } else {
>>>>> +          OMAP_HSMMC_WRITE(host->base, ISE, INT_EN_MASK);
>>>>> +          OMAP_HSMMC_WRITE(host->base, IE, INT_EN_MASK);
>>>>> +  }
>>>>>
>>>>>    host->response_busy = 0;
>>>>>    if (cmd->flags & MMC_RSP_PRESENT) {
>>>>> @@ -430,17 +440,27 @@ static irqreturn_t mmc_omap_irq(int irq, void
>>>>> *dev_id)
>>>>>    struct mmc_data *data;
>>>>>    int end_cmd = 0, end_trans = 0, status;
>>>>>
>>>>> +  data = host->data;
>>>>> +  status = OMAP_HSMMC_READ(host->base, STAT);
>>>>> +  dev_dbg(mmc_dev(host->mmc), "IRQ Status is %x\n", status);
>>>> Why are these moved up?
>>> Yes, why? Why not move the block below down instead?
>>>
>>>>> +
>>>>> +  if (host->mmc->caps & MMC_CAP_SDIO_IRQ) {
>>>>> +          if (status & OMAP_HSMMC_CARD_INT) {
>>>>> +                  dev_dbg(mmc_dev(host->mmc),
>>>>> +                                  " SDIO CARD interrupt status %x\n",
>>>>> +                                  status);
>>>>> +                  mmc_signal_sdio_irq(host->mmc);
>>>>> +          }
>>>>> +  }
>>> - It makes no sense to print status in dev_dbg here again, as it is
>>> already printed some lines above. Something like
>>>
>>> dev_dbg(mmc_dev(host->mmc), "SDIO interrupt\n");
>>>
>>> would be sufficient here.
>>>
>>> - Why isn't IRQ acknowledged here? I.e. why not doing something like
>>>
>>> OMAP_HSMMC_WRITE(host->base, IE, OMAP_HSMMC_READ(host->base, IE) &
>>> ~(CIRQ_ENABLE));
>>>
>>> here?
>>>
> 
> SDIO interrupts are generated asynchronously from the sdio card even
> though when there are no mmc requests<mrq>. With out the changes in
> the patch we will be returning from the interrupt routine in case of
> mmc requests being NULL, there by SDIO interrupts will not be handled.
> 
> Hence i have moved status register read and sdio interrupt checking
> code up in the irq routine to handle the sdio interrupts properly.
> 
> There is always scope for getting SDIO as well as controller
> interrupts at the same instance. Hence i check for controller
> interrupts after handling SDIO interrupts without returning from irq
> handler.
> 
> Yeah.. as said by Dirk, the dev_dbg need not print the status.
> 
> 
>> That is not needed because of the below implementation:
>>
>> static inline void mmc_signal_sdio_irq(struct mmc_host *host)
>> {
>>        host->ops->enable_sdio_irq(host, 0);
>>        wake_up_process(host->sdio_irq_thread);
>> }
>>
>> The host is asked to disable the irq inherently.
>>
>> Regards,
>> Madhu
>>
>>> - No return IRQ_HANDLED; here? Mmm, maybe this makes sense.
>>>
>>>>>    if (host->mrq == NULL) {
>>>>>            OMAP_HSMMC_WRITE(host->base, STAT,
>>>>> -                  OMAP_HSMMC_READ(host->base, STAT));
>>>>> +                          OMAP_HSMMC_READ(host->base, STAT));
>>>> This just adds a tab space. Not needed.
>>> Ack.
>>>
>>>>>            /* Flush posted write */
>>>>>            OMAP_HSMMC_READ(host->base, STAT);
>>>>>            return IRQ_HANDLED;
>>>>>    }
>>>>>
>>>>> -  data = host->data;
>>>>> -  status = OMAP_HSMMC_READ(host->base, STAT);
>>>>> -  dev_dbg(mmc_dev(host->mmc), "IRQ Status is %x\n", status);
>>>> Check my comment above.
>>> Yes, from theory it looks better to move the new code below this, instead.
>>>
>>>>>    if (status & ERR) {
>>>>>  #ifdef CONFIG_MMC_DEBUG
>>>>> @@ -932,6 +952,29 @@ static int omap_hsmmc_get_ro(struct mmc_host *mmc)
>>>>>    return pdata->slots[0].get_ro(host->dev, 0);
>>>>>  }
>>>>>
>>>>> +static void omap_hsmmc_enable_sdio_irq(struct mmc_host *mmc, int
>>> enable)
>>>>> +{
>>>>> +  struct mmc_omap_host *host = mmc_priv(mmc);
>>>>> +
>>>>> +  host->sdio_int = enable;
>>>>> +  if (enable) {
>>>>> +          OMAP_HSMMC_WRITE(host->base, ISE,
>>>>> +                          (OMAP_HSMMC_READ(host->base, ISE) |
>>>>> +                           OMAP_HSMMC_CARD_INT));
>>>>> +          OMAP_HSMMC_WRITE(host->base, IE,
>>>>> +                          (OMAP_HSMMC_READ(host->base, IE) |
>>>>> +                           OMAP_HSMMC_CARD_INT));
>>>>> +  } else {
>>>>> +          OMAP_HSMMC_WRITE(host->base, IE,
>>>>> +                          (OMAP_HSMMC_READ(host->base, IE) &
>>>>> +                           (~OMAP_HSMMC_CARD_INT)));
>>>>> +          OMAP_HSMMC_WRITE(host->base, ISE,
>>>>> +                          (OMAP_HSMMC_READ(host->base, ISE) &
>>>>> +                           (~OMAP_HSMMC_CARD_INT)));
>>>>> +  }
>>>>> +
>>>>> +}
>>>>> +
>>>>>  static void omap_hsmmc_init(struct mmc_omap_host *host)
>>>>>  {
>>>>>    u32 hctl, capa, value;
>>>>> @@ -964,7 +1007,7 @@ static struct mmc_host_ops mmc_omap_ops = {
>>>>>    .set_ios = omap_mmc_set_ios,
>>>>>    .get_cd = omap_hsmmc_get_cd,
>>>>>    .get_ro = omap_hsmmc_get_ro,
>>>>> -  /* NYET -- enable_sdio_irq */
>>>>> +  .enable_sdio_irq = omap_hsmmc_enable_sdio_irq,
>>>>>  };
>>>>>
>>>>>  static int __init omap_mmc_probe(struct platform_device *pdev)
>>>>> @@ -1011,6 +1054,7 @@ static int __init omap_mmc_probe(struct
>>>>> platform_device *pdev)
>>> Greetings from the mailer again.
>>>
>>>>>    host->irq       = irq;
>>>>>    host->id        = pdev->id;
>>>>>    host->slot_id   = 0;
>>>>> +  host->sdio_int  = 0;
>>>> Not needed.
>>>>
>>>>>    host->mapbase   = res->start;
>>>>>    host->base      = ioremap(host->mapbase, SZ_4K);
>>>>>
>>>>> @@ -1080,6 +1124,10 @@ static int __init omap_mmc_probe(struct
>>>>> platform_device *pdev)
>>>>>    else if (pdata->slots[host->slot_id].wires >= 4)
>>>>>            mmc->caps |= MMC_CAP_4_BIT_DATA;
>>>>>
>>>>> +  mmc->caps |= MMC_CAP_SDIO_IRQ;
>>>>> +  OMAP_HSMMC_WRITE(host->base, CON,
>>>>> +                  OMAP_HSMMC_READ(host->base, CON) | (CTPL |
>>>> CLKEXTFREE));
>>>> How about moving this to "enable_sdio_irq" so that these are done for
>>> SDIO
>>>> alone? Also can be disabled in the same fn.
>>> Ack. But I think that mmc->caps |= MMC_CAP_SDIO_IRQ has to stay here.
>>> Else "enable_sdio_irq" will never be called (?)
>>>
> 
> As pointed out by Dirk, enable_sdio_irq wont be called if mmc->caps is
> not set with MMC_CAP_SDIO_IRQ. So that should be kept separate.
> 
> I do not see any advantage (Any extra power saving ! ;)) in modifying
> the CON register bits(CTPL and CLKEXTFREE) every time along with SDIO
> interrupts. Also the extra read and write might add some overhead.
> 
>>> All in all, I wonder why IBG bit isn't used in this patch. Is this
>>> tested with 1 or 4 bit (wire) SDIO?
>>>
> 
> I have not yet verified the functionality with 1bit SDIO.

Ok, as Overo uses 4bit, too, we don't need 1bit for testing now.

Do you like to update your patch with

* using

#define CIRQ			(1 << 8)
#define CIRQ_ENABLE		(1 << 8)
#define CTPL			(1 << 11)
#define CLKEXTFREE		(1 << 16)

* using

dev_dbg(mmc_dev(host->mmc), "SDIO interrupt\n");

* Remove the additional tab space from

+                          OMAP_HSMMC_READ(host->base, STAT));

* trying to send it with git send-email to avoid line wrapping?

?

And do you have any comments on IBG bit? Would be nice if you could 
test setting this bit, too (as mentioned, I have not test environment, 
yet).

Many thanks

Dirk

>>> Just for reference the slightly modified version of this patch for
>>> testing in attachment (based on pure theory ;) ). I will come back
>>> with testing results.
>>>
>>> Best regards
>>>
>>> Dirk
>>>
>>>> Regards,
>>>> Madhusudhan
>>>>> +
>>>>>    omap_hsmmc_init(host);
>>>>>
>>>>>    /* Select DMA lines */
>>>>> --
>>>>> 1.6.0.4
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe linux-omap"
>>> in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> 

