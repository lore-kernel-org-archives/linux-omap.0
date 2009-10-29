From: Phaneendra Kumar Alapati <phani@embwise.com>
Subject: Re: [PATCH] OMAP35xx: Added SDIO IRQ support
Date: Thu, 29 Oct 2009 14:57:49 +0530
Message-ID: <54d94f230910290227o6c56e921rb91558bdac462d65@mail.gmail.com>
References: <54d94f230910280618l1b770505lfc88af7592777763@mail.gmail.com>
	<000001ca57e8$e4108ec0$544ff780@am.dhcp.ti.com> <4AE89FEC.9000309@googlemail.com>
	<002d01ca5810$96534100$544ff780@am.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail10.myhsphere.biz ([64.71.235.184]:49478 "EHLO
	mail10.myhsphere.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752229AbZJ2J2L convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Oct 2009 05:28:11 -0400
Received: by pxi9 with SMTP id 9so1066870pxi.4
        for <linux-omap@vger.kernel.org>; Thu, 29 Oct 2009 02:28:09 -0700 (PDT)
In-Reply-To: <002d01ca5810$96534100$544ff780@am.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Madhusudhan <madhu.cr@ti.com>
Cc: Dirk Behme <dirk.behme@googlemail.com>, linux-omap@vger.kernel.org

Dirk and Madhu, Thanks for the review/comments. I have explained below
the reasons behind certain changes i made esp the interrupt enabling
and irq routine changes.

On Thu, Oct 29, 2009 at 2:22 AM, Madhusudhan <madhu.cr@ti.com> wrote:
>
>
>> -----Original Message-----
>> From: Dirk Behme [mailto:dirk.behme@googlemail.com]
>> Sent: Wednesday, October 28, 2009 2:48 PM
>> To: Madhusudhan; 'Phaneendra Kumar Alapati'
>> Cc: linux-omap@vger.kernel.org
>> Subject: Re: [PATCH] OMAP35xx: Added SDIO IRQ support
>>
>> Madhusudhan wrote:
>> >
>> >> -----Original Message-----
>> >> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> >> owner@vger.kernel.org] On Behalf Of Phaneendra Kumar Alapati
>> >> Sent: Wednesday, October 28, 2009 8:19 AM
>> >> To: linux-omap@vger.kernel.org
>> >> Subject: [PATCH] OMAP35xx: Added SDIO IRQ support
>> >>
>> >> This patch adds SDIO IRQ support for omap hsmmc driver.
>> >>
>> >> Signed-off-by: Phaneendra Kumar Alapati <phani@embwise.com>
>> >> ---
>> >> =A0drivers/mmc/host/omap_hsmmc.c | =A0 =A062 ++--
>> >> =A01 files changed, 55 insertions(+), 7 deletions(-)
>> >>
>> >> diff --git a/drivers/mmc/host/omap_hsmmc.c
>> b/drivers/mmc/host/omap_hsmmc.c
>> >> index 1cf9cfb..a540626 100644
>> >> --- a/drivers/mmc/host/omap_hsmmc.c
>> >> +++ b/drivers/mmc/host/omap_hsmmc.c
>> >> @@ -92,6 +92,10 @@
>> >> =A0#define DUAL_VOLT_OCR_BIT 7
>> >> =A0#define SRC =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << =
25)
>> >> =A0#define SRD =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << =
26)
>> >> +#define OMAP_HSMMC_CARD_INT =A0 =A0 =A0 BIT(8)
>> >> +#define SDIO_INT_EN =A0 =A0 =A0 =A0 =A0 =A0 =A0 BIT(8)
>> > Why multiple defines of the same? One of them should be enough.
>>
>> What I think meant here is
>>
>> #define CIRQ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 8)
>> #define CIRQ_ENABLE =A0 =A0 =A0 =A0 =A0 (1 << 8)
>>
>> One is for the status register, the other is for the interrupt enabl=
e
>> registers. To be compatible with the TRM, I would use both in this w=
ay.
>>
>> >> +#define CTPL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT(11)
>> >> +#define CLKEXTFREE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT(16)
>> > Can we define them in the same way as other defines to maintain
>> uniformity?
>>
>> Yes, ack.
>>

I have kept separate macros in reference to the TRM as they are for
different registers. To keep the code simpler they can be merged

>> >> =A0/*
>> >> =A0 * FIXME: Most likely all the data using these _DEVID defines =
should
>> come
>> >> @@ -149,6 +153,7 @@ struct mmc_omap_host {
>> >> =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 slot_id;
>> >> =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dbclk_enabled;
>> >> =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 response_busy;
>> >> + =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdio_int;
>> >
>> > What purpose does this serve? IMHO, this is not needed.
>>
>> Hmm. This is set to !=3D 0 in omap_hsmmc_enable_sdio_irq() when IRQs=
 are
>> enabled. Then in mmc_omap_start_command() these interrupts are enabl=
ed
>> again if sdio_int is !=3D 0. Yes, looks unneeded, indeed. But maybe
>> there is some trick ;)
>>
>> >> =A0 =A0struct =A0omap_mmc_platform_data =A0*pdata;
>> >> =A0};
>> >>
>> >> @@ -240,8 +245,13 @@ mmc_omap_start_command(struct mmc_omap_host
>> >> *host, struct mmc_command *cmd,
>>
>> Patch is line wrapped by mailer.
>>
>> >> =A0 =A0 * Clear status bits and enable interrupts
>> >> =A0 =A0 */
>> >> =A0 =A0OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
>> >> - =A0OMAP_HSMMC_WRITE(host->base, ISE, INT_EN_MASK);
>> >> - =A0OMAP_HSMMC_WRITE(host->base, IE, INT_EN_MASK);
>> >> + =A0if (host->sdio_int) {
>> >> + =A0 =A0 =A0 =A0 =A0OMAP_HSMMC_WRITE(host->base, ISE, (INT_EN_MA=
SK |
>> >> SDIO_INT_EN));
>> >> + =A0 =A0 =A0 =A0 =A0OMAP_HSMMC_WRITE(host->base, IE, (INT_EN_MAS=
K |
>> > SDIO_INT_EN));
>> > Why? It is being taken care in "enable_sdio_irq".
>>
>> Yes, why?
>>

Once sdio interrupts are enabled through enable_sdio_irq, commands
which are sent further disable the sdio interrupts by directly over
writing to the IE and ISE without preserving currently enabled
interrupts.

Best option is to read+modify+write the IE and ISE register as i did
in enable_sdio_irq. But the IE and ISE register seem to be modified in
other places too, so i made use of sdio_int flag to keep track of sdio
interrupt enabling/disabling.

>> >> + =A0} else {
>> >> + =A0 =A0 =A0 =A0 =A0OMAP_HSMMC_WRITE(host->base, ISE, INT_EN_MAS=
K);
>> >> + =A0 =A0 =A0 =A0 =A0OMAP_HSMMC_WRITE(host->base, IE, INT_EN_MASK=
);
>> >> + =A0}
>> >>
>> >> =A0 =A0host->response_busy =3D 0;
>> >> =A0 =A0if (cmd->flags & MMC_RSP_PRESENT) {
>> >> @@ -430,17 +440,27 @@ static irqreturn_t mmc_omap_irq(int irq, vo=
id
>> >> *dev_id)
>> >> =A0 =A0struct mmc_data *data;
>> >> =A0 =A0int end_cmd =3D 0, end_trans =3D 0, status;
>> >>
>> >> + =A0data =3D host->data;
>> >> + =A0status =3D OMAP_HSMMC_READ(host->base, STAT);
>> >> + =A0dev_dbg(mmc_dev(host->mmc), "IRQ Status is %x\n", status);
>> > Why are these moved up?
>>
>> Yes, why? Why not move the block below down instead?
>>
>> >> +
>> >> + =A0if (host->mmc->caps & MMC_CAP_SDIO_IRQ) {
>> >> + =A0 =A0 =A0 =A0 =A0if (status & OMAP_HSMMC_CARD_INT) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_dbg(mmc_dev(host->mmc),
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0" SDIO CARD interrupt status %x\n",
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0status);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_signal_sdio_irq(host->mm=
c);
>> >> + =A0 =A0 =A0 =A0 =A0}
>> >> + =A0}
>>
>> - It makes no sense to print status in dev_dbg here again, as it is
>> already printed some lines above. Something like
>>
>> dev_dbg(mmc_dev(host->mmc), "SDIO interrupt\n");
>>
>> would be sufficient here.
>>
>> - Why isn't IRQ acknowledged here? I.e. why not doing something like
>>
>> OMAP_HSMMC_WRITE(host->base, IE, OMAP_HSMMC_READ(host->base, IE) &
>> ~(CIRQ_ENABLE));
>>
>> here?
>>

SDIO interrupts are generated asynchronously from the sdio card even
though when there are no mmc requests<mrq>. With out the changes in
the patch we will be returning from the interrupt routine in case of
mmc requests being NULL, there by SDIO interrupts will not be handled.

Hence i have moved status register read and sdio interrupt checking
code up in the irq routine to handle the sdio interrupts properly.

There is always scope for getting SDIO as well as controller
interrupts at the same instance. Hence i check for controller
interrupts after handling SDIO interrupts without returning from irq
handler.

Yeah.. as said by Dirk, the dev_dbg need not print the status.


> That is not needed because of the below implementation:
>
> static inline void mmc_signal_sdio_irq(struct mmc_host *host)
> {
> =A0 =A0 =A0 =A0host->ops->enable_sdio_irq(host, 0);
> =A0 =A0 =A0 =A0wake_up_process(host->sdio_irq_thread);
> }
>
> The host is asked to disable the irq inherently.
>
> Regards,
> Madhu
>
>> - No return IRQ_HANDLED; here? Mmm, maybe this makes sense.
>>
>> >> =A0 =A0if (host->mrq =3D=3D NULL) {
>> >> =A0 =A0 =A0 =A0 =A0 =A0OMAP_HSMMC_WRITE(host->base, STAT,
>> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP_HSMMC_READ(host->base, =
STAT));
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP_HSMMC_R=
EAD(host->base, STAT));
>> > This just adds a tab space. Not needed.
>>
>> Ack.
>>
>> >> =A0 =A0 =A0 =A0 =A0 =A0/* Flush posted write */
>> >> =A0 =A0 =A0 =A0 =A0 =A0OMAP_HSMMC_READ(host->base, STAT);
>> >> =A0 =A0 =A0 =A0 =A0 =A0return IRQ_HANDLED;
>> >> =A0 =A0}
>> >>
>> >> - =A0data =3D host->data;
>> >> - =A0status =3D OMAP_HSMMC_READ(host->base, STAT);
>> >> - =A0dev_dbg(mmc_dev(host->mmc), "IRQ Status is %x\n", status);
>> > Check my comment above.
>>
>> Yes, from theory it looks better to move the new code below this, in=
stead.
>>
>> >> =A0 =A0if (status & ERR) {
>> >> =A0#ifdef CONFIG_MMC_DEBUG
>> >> @@ -932,6 +952,29 @@ static int omap_hsmmc_get_ro(struct mmc_host=
 *mmc)
>> >> =A0 =A0return pdata->slots[0].get_ro(host->dev, 0);
>> >> =A0}
>> >>
>> >> +static void omap_hsmmc_enable_sdio_irq(struct mmc_host *mmc, int
>> enable)
>> >> +{
>> >> + =A0struct mmc_omap_host *host =3D mmc_priv(mmc);
>> >> +
>> >> + =A0host->sdio_int =3D enable;
>> >> + =A0if (enable) {
>> >> + =A0 =A0 =A0 =A0 =A0OMAP_HSMMC_WRITE(host->base, ISE,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(OMAP_HSMMC_=
READ(host->base, ISE) |
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_HSMMC_=
CARD_INT));
>> >> + =A0 =A0 =A0 =A0 =A0OMAP_HSMMC_WRITE(host->base, IE,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(OMAP_HSMMC_=
READ(host->base, IE) |
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_HSMMC_=
CARD_INT));
>> >> + =A0} else {
>> >> + =A0 =A0 =A0 =A0 =A0OMAP_HSMMC_WRITE(host->base, IE,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(OMAP_HSMMC_=
READ(host->base, IE) &
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (~OMAP_HSMM=
C_CARD_INT)));
>> >> + =A0 =A0 =A0 =A0 =A0OMAP_HSMMC_WRITE(host->base, ISE,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(OMAP_HSMMC_=
READ(host->base, ISE) &
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (~OMAP_HSMM=
C_CARD_INT)));
>> >> + =A0}
>> >> +
>> >> +}
>> >> +
>> >> =A0static void omap_hsmmc_init(struct mmc_omap_host *host)
>> >> =A0{
>> >> =A0 =A0u32 hctl, capa, value;
>> >> @@ -964,7 +1007,7 @@ static struct mmc_host_ops mmc_omap_ops =3D =
{
>> >> =A0 =A0.set_ios =3D omap_mmc_set_ios,
>> >> =A0 =A0.get_cd =3D omap_hsmmc_get_cd,
>> >> =A0 =A0.get_ro =3D omap_hsmmc_get_ro,
>> >> - =A0/* NYET -- enable_sdio_irq */
>> >> + =A0.enable_sdio_irq =3D omap_hsmmc_enable_sdio_irq,
>> >> =A0};
>> >>
>> >> =A0static int __init omap_mmc_probe(struct platform_device *pdev)
>> >> @@ -1011,6 +1054,7 @@ static int __init omap_mmc_probe(struct
>> >> platform_device *pdev)
>>
>> Greetings from the mailer again.
>>
>> >> =A0 =A0host->irq =A0 =A0 =A0 =3D irq;
>> >> =A0 =A0host->id =A0 =A0 =A0 =A0=3D pdev->id;
>> >> =A0 =A0host->slot_id =A0 =3D 0;
>> >> + =A0host->sdio_int =A0=3D 0;
>> > Not needed.
>> >
>> >> =A0 =A0host->mapbase =A0 =3D res->start;
>> >> =A0 =A0host->base =A0 =A0 =A0=3D ioremap(host->mapbase, SZ_4K);
>> >>
>> >> @@ -1080,6 +1124,10 @@ static int __init omap_mmc_probe(struct
>> >> platform_device *pdev)
>> >> =A0 =A0else if (pdata->slots[host->slot_id].wires >=3D 4)
>> >> =A0 =A0 =A0 =A0 =A0 =A0mmc->caps |=3D MMC_CAP_4_BIT_DATA;
>> >>
>> >> + =A0mmc->caps |=3D MMC_CAP_SDIO_IRQ;
>> >> + =A0OMAP_HSMMC_WRITE(host->base, CON,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP_HSMMC_READ(host->base, =
CON) | (CTPL |
>> > CLKEXTFREE));
>> > How about moving this to "enable_sdio_irq" so that these are done =
for
>> SDIO
>> > alone? Also can be disabled in the same fn.
>>
>> Ack. But I think that mmc->caps |=3D MMC_CAP_SDIO_IRQ has to stay he=
re.
>> Else "enable_sdio_irq" will never be called (?)
>>

As pointed out by Dirk, enable_sdio_irq wont be called if mmc->caps is
not set with MMC_CAP_SDIO_IRQ. So that should be kept separate.

I do not see any advantage (Any extra power saving ! ;)) in modifying
the CON register bits(CTPL and CLKEXTFREE) every time along with SDIO
interrupts. Also the extra read and write might add some overhead.

>> All in all, I wonder why IBG bit isn't used in this patch. Is this
>> tested with 1 or 4 bit (wire) SDIO?
>>

I have not yet verified the functionality with 1bit SDIO.

--- Regards,
Phani

>> Just for reference the slightly modified version of this patch for
>> testing in attachment (based on pure theory ;) ). I will come back
>> with testing results.
>>
>> Best regards
>>
>> Dirk
>>
>> > Regards,
>> > Madhusudhan
>> >> +
>> >> =A0 =A0omap_hsmmc_init(host);
>> >>
>> >> =A0 =A0/* Select DMA lines */
>> >> --
>> >> 1.6.0.4
>> >> --
>> >> To unsubscribe from this list: send the line "unsubscribe linux-o=
map"
>> in
>> >> the body of a message to majordomo@vger.kernel.org
>> >> More majordomo info at =A0http://vger.kernel.org/majordomo-info.h=
tml
>> >
>> >
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe linux-om=
ap" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.ht=
ml
>> >
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
