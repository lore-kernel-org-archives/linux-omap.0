From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: MMC_CAP_SDIO_IRQ for omap 3430
Date: Fri, 16 Oct 2009 21:55:25 +0200
Message-ID: <4AD8CFAD.40507@googlemail.com>
References: <4b73d43f0910151330q6c5cae7sa2a5948b586cc215@mail.gmail.com>	 <4AD81DC2.4080607@googlemail.com>	 <4b73d43f0910160643y59d39373y1dd1c1995f521778@mail.gmail.com>	 <4AD88B0A.1010006@googlemail.com>	 <4b73d43f0910160859j6958afeaw415a2a71efc72672@mail.gmail.com>	 <4AD89A01.1020400@googlemail.com> <4b73d43f0910161151t2b85a5e8w3fa9951e1339d69a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f218.google.com ([209.85.220.218]:56805 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774AbZJPT4X (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Oct 2009 15:56:23 -0400
Received: by fxm18 with SMTP id 18so2834397fxm.37
        for <linux-omap@vger.kernel.org>; Fri, 16 Oct 2009 12:56:26 -0700 (PDT)
In-Reply-To: <4b73d43f0910161151t2b85a5e8w3fa9951e1339d69a@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: John Rigby <jcrigby@gmail.com>
Cc: linux-omap@vger.kernel.org, Madhusudhan <madhu.cr@ti.com>, Steve Sakoman <sakoman@gmail.com>

John Rigby wrote:
> First the disclaimers:
> The board is new board that has had hardware mmc/sdio problems before.
>  It is based closely on beagle but uses a different package which has
> some package specific issues.  We think we have found them all but who
> knows.
> 
> My kernel is a few months old 2.6.29.

Then you can't apply my patch 1:1. Steve already found that there are 
a lot of differences between recent git head and 2.6.31. A lot of 
omap_hsmmc changes were done since 2.6.31.

> Ok, given the above issues, it looks to me like I am getting
> interrupted every time  CIRQ is enabled.

Infinite interrupts. This is what I assumed :(

> Nor sure if the libertas
> driver is not disabling as it should or what.  

I'm not sure if libertas has to do something with this.

>So I end up in this
> death spiral:
> 
> irq handler is called and status indicates CIRQ is pending
> 
> mmc_signal_sdio_irq is called which calls omap_hsmmc_enable_sdio_irq
> with via mmc_host_ops, en is zero so CIRQ gets disabled
> 
> mmc_signal_sdio_irq then wakes up sdio_irq_thread which does its thing
> then before going to sleep calls omap_hsmmc_enable_irq with en set to
> 1 so CIRC gets turned back on

Sounds ok. And thanks for giving the call stack. As mentioned, I did 
only compile check ;)

> with CIRC enabled the irq handler gets called and we are back where we started.

The issue then is not acknowledging the interrupt correctly. The TRM 
(spruf98.c) tells us:

-- cut --
Card interrupt Enable
A clear of this bit also clears the corresponding status bit.
During 1-bit mode, if the interrupt routine does not remove the
source of a card interrupt in the SDIO card, the status bit is
reasserted when this bit is set to 1.
-- cut --

The clear card interrupt enable should be done by ~(CIRQ_ENABLE) in

+if (status & CIRQ) {
+	dev_dbg(mmc_dev(host->mmc), "SDIO interrupt");
+	OMAP_HSMMC_WRITE(host->base, IE, OMAP_HSMMC_READ(host->base, IE)
+			 & ~(CIRQ_ENABLE));
+	mmc_signal_sdio_irq(host->mmc);
+	spin_unlock(&host->irq_lock);
+	return IRQ_HANDLED;
+}

Anybody sees anything wrong here? Maybe we missed something?

I assume that we are not in 1-bit mode. We should be in 4 bit mode. It 
could be checked by some test code that we are in 4 bit mode and IBG 
is set.

Additionally, what I wonder regarding this, is the davinci driver [1] 
additionally checking for DAT1 level in enable_sdio_irq

1114         if (enable) {
1115                 if (!((readl(host->base + DAVINCI_SDIOST0))
1116                             & SDIOST0_DAT1_HI)) {
1117                         writel(SDIOIST_IOINT,
1118                                         host->base + 
DAVINCI_SDIOIST);
1119                         mmc_signal_sdio_irq(host->mmc);
1120                 } else {
... enable int
1124                 }
1125         } else {
... disable int
1129         }

And it does similar stuff in xfer_done

  873         if (host->mmc->caps & MMC_CAP_SDIO_IRQ) {
  874                 if (host->sdio_int && (!((readl(host->base + 
DAVINCI_SDIOST0))
  875                                         & SDIOST0_DAT1_HI))) {
  876                         writel(SDIOIST_IOINT, host->base + 
DAVINCI_SDIOIST);
  877                         mmc_signal_sdio_irq(host->mmc);
  878                 }
  879         }

Most probably there is a reason for doing so?

Best regards

Dirk

[1] 
http://arago-project.org/git/projects/?p=linux-davinci.git;a=blob;f=drivers/mmc/host/davinci_mmc.c;h=1bf0587250614c6d8abfe02028b96e0e47148ac8;hb=HEAD

> Looks like either the libertas driver is not disabling the irq or the
> CIRQ irq is somehow getting stuck or I have a hw problem.
> 
> One thing I did try was to have the sdio_irq_thread basically ignore
> the MMC_CAP_SDIO_IRQ flag except for calling
> host->ops->enable_sdio_irq(host, 1) and I changed mmc_signal_sdio_irq
> to not reschedule sdio_irq_thread.  In shows that the mere act of
> enabling CIRQ does not break anything.  In this mode I get one CIRQ
> irq for each time around the sdio_irq_thread loop.
> 
> I guess I should try checking the CIRQ bit in the status register
> after calling the libertas handler which should clear the irq?
> 
> 
> John
> 
> 
> On Fri, Oct 16, 2009 at 10:06 AM, Dirk Behme <dirk.behme@googlemail.com> wrote:
>> John Rigby wrote:
>>> Dirk,
>>>
>>> Thanks for the update.  After looking more closely at your patch I
>>> found that the only thing my attempt was missing was the IBG setting.
>>> I added that to mine with the result that the system hangs on loading
>>> the libertas modules.
>> On which board are you working? libertas does mean you are working on wifi
>> connected via SDIO?
>>
>>> The last thing i see is the firmware request
>>> message.
>> Ok, you see a hang. Below we have a timeout.
>>
>> I would vote for some interrupt issues. For timeouts I would vote for
>> missing interrupts, while system hang might be infinite interrupts
>> (something like this was reported in [1]).
>>
>> Could you add some debug code in omap_hsmmc_enable_sdio_irq() to trace if
>> enable/disable is called in the correct order? And in omap_hsmmc_irq() in if
>> (status & CIRQ) { to check if and how often it is called?
>>
>> Best regards
>>
>> Dirk
>>
>> [1] http://groups.google.com/group/beagleboard/msg/5cdfe2a319531937
>>
>>> On Fri, Oct 16, 2009 at 9:02 AM, Dirk Behme <dirk.behme@googlemail.com>
>>> wrote:
>>>> John,
>>>>
>>>> John Rigby wrote:
>>>>> Dirk,
>>>>>
>>>>> Many thanks, after sending the request yesterday I made my own attempt
>>>>> which failed miserably.  My patch looks like a subset of yours so that
>>>>> is to be expected.  I'll try yours out today and report back my
>>>>> experience.
>>>> I got already some (private) feedback (thanks!):
>>>>
>>>> - Accessing host->mmc->card in omap_hsmmc_set_ios() results in a null
>>>> pointer :( Seems that mmc->card isn't set yet while calling
>>>> omap_hsmmc_set_ios().
>>>>
>>>> As workaround, for testing only, I hard coded setting IBG with something
>>>> like
>>>>
>>>>       case MMC_BUS_WIDTH_4:
>>>>               OMAP_HSMMC_WRITE(host->base, CON, con & ~DW8);
>>>> -               OMAP_HSMMC_WRITE(host->base, HCTL,
>>>> -                       OMAP_HSMMC_READ(host->base, HCTL) | FOUR_BIT);
>>>> +                       OMAP_HSMMC_WRITE(host->base, HCTL,
>>>> +                                        OMAP_HSMMC_READ(host->base,
>>>> HCTL) |
>>>> IBG | FOUR_BIT);
>>>>              break;
>>>>
>>>> If you test this, be careful that this doesn't hurt any other 4 bit cards
>>>> except the SDIO you want to test.
>>>>
>>>> Later, we have to find a way how to detect that we are in SDIO mode. We
>>>> want
>>>> to set IBG only if in SDIO and 4 bit mode.
>>>>
>>>> -  After this, I got the report that null pointer crash is gone. But SDIO
>>>> doesn't seem to work any more:
>>>>
>>>> libertas_sdio: Libertas SDIO driver
>>>> libertas_sdio: Copyright Pierre Ossman
>>>> libertas_sdio mmc1:0001:1: firmware: requesting sd8686_helper.bin
>>>> libertas_sdio mmc1:0001:1: firmware: requesting sd8686.bin
>>>> libertas: command 0x0003 timed out
>>>> libertas: requeueing command 0x0003 due to timeout (#1)
>>>> libertas: command 0x0003 timed out
>>>> libertas: requeueing command 0x0003 due to timeout (#2)
>>>> libertas: command 0x0003 timed out
>>>> libertas: requeueing command 0x0003 due to timeout (#3)
>>>> libertas: command 0x0003 timed out
>>>> libertas: Excessive timeouts submitting command 0x0003
>>>> libertas: PREP_CMD: command 0x0003 failed: -110
>>>> libertas_sdio: probe of mmc1:0001:1 failed with error -110
>>>>
>>>> I now start to think about it ;)
>>>>
>>>> Again, any help would be appreciated!
>>>>
>>>> Best regards
>>>>
>>>> Dirk
>>>>
>>>>> On Fri, Oct 16, 2009 at 1:16 AM, Dirk Behme <dirk.behme@googlemail.com>
>>>>> wrote:
>>>>>> John Rigby wrote:
>>>>>>> I have seen several discussions about lack of sdio irq support in the
>>>>>>> hsmmc driver but no patches.  Has anyone on this list implemented this
>>>>>>> and/or can anyone point me to patches?
>>>>>> What a coincidence ;)
>>>>>>
>>>>>> I'm currently working on this. See attachment what I currently have. It
>>>>>> is
>>>>>> compile tested only against recent omap linux head. I don't have a
>>>>>> board
>>>>>> using SDIO at the moment, so no real testing possible :(
>>>>>>
>>>>>> Some background, maybe it helps people to step in:
>>>>>>
>>>>>> Gumstix OMAP3 based Overo air board connects Marvell 88W8686 wifi by
>>>>>> MMC
>>>>>> port 2 in 4 bit configuration [1]. The wifi performance is quite bad
>>>>>> (~100kB/s). There is some rumor that this might be SDIO irq related
>>>>>> [2].
>>>>>> There was an attempt to fix this [3] already, but this doesn't work
>>>>>> [4].
>>>>>> Having this, I started to look into it.
>>>>>>
>>>>>> I used [3], the TI Davinci driver [5] (supporting SDIO irq), the SDIO
>>>>>> Simplified Specification [6] and the OMAP35x TRM [7] as starting
>>>>>> points.
>>>>>>
>>>>>> Unfortunately, the Davinci MMC registers and irqs are different
>>>>>> (Davinci
>>>>>> has
>>>>>> a dedicated SDIO irq). But combining [3] and [5] helps to get an idea
>>>>>> what
>>>>>> has to be done.
>>>>>>
>>>>>> I think the main issues of [3] were that it doesn't enable IBG for 4
>>>>>> bit
>>>>>> mode ([6] chapter 8.1.2) and that mmc_omap_irq() doesn't reset the irq
>>>>>> bits.
>>>>>>
>>>>>> Topics I still open:
>>>>>>
>>>>>> - Is it always necessary to deal with IE _and_ ISE register? I'm not
>>>>>> totally
>>>>>> clear what the difference between these two registers are ;) And in
>>>>>> which
>>>>>> order they have to be set.
>>>>>>
>>>>>> - Davinci driver [5] in line 1115 checks for data line to call
>>>>>> mmc_signal_sdio_irq() for irq enable.
>>>>>>
>>>>>> - Davinci driver deals with SDIO in xfer_done() (line 873)
>>>>>>
>>>>>> - Davinci driver sets block size to 64 if SDIO in line 701
>>>>>>
>>>>>> It would be quite nice if anybody likes to comment on attachment and
>>>>>> help
>>>>>> testing.
>>>>>>
>>>>>> Many thanks and best regards
>>>>>>
>>>>>> Dirk
>>>>>>
>>>>>> [1] http://gumstix.net/wiki/index.php?title=Overo_Wifi
>>>>>>
>>>>>> [2] http://groups.google.com/group/beagleboard/msg/14e822778c5eeb56
>>>>>>
>>>>>> [3] http://groups.google.com/group/beagleboard/msg/d0eb69f4c20673be
>>>>>>
>>>>>> [4] http://groups.google.com/group/beagleboard/msg/5cdfe2a319531937
>>>>>>
>>>>>> [5]
>>>>>>
>>>>>>
>>>>>> http://arago-project.org/git/projects/?p=linux-davinci.git;a=blob;f=drivers/mmc/host/davinci_mmc.c;h=1bf0587250614c6d8abfe02028b96e0e47148ac8;hb=HEAD
>>>>>>
>>>>>> [6] http://www.sdcard.org/developers/tech/sdio/sd_bluetooth_spec/
>>>>>>
>>>>>> [7] http://focus.ti.com/lit/ug/spruf98c/spruf98c.pdf
>>>>>>
>>>>>>
>>>>>> Subject: [PATCH][RFC] OMAP HSMMC: Add SDIO interrupt support
>>>>>> Form: Dirk Behme <dirk.behme@googlemail.com>
>>>>>>
>>>>>> At the moment, OMAP HSMMC driver supports only SDIO polling, resulting
>>>>>> in
>>>>>> poor
>>>>>> performance. Add support for SDIO interrupt handling.
>>>>>>
>>>>>> Signed-off-by: Dirk Behme <dirk.behme@googlemail.com>
>>>>>> ---
>>>>>>
>>>>>> Patch against recent omap-linux head "Linux omap got rebuilt from
>>>>>> scratch"
>>>>>> 274c94b29ee7c53609a756acca974e4742c59559
>>>>>>
>>>>>> Compile tested only. Please comment and help testing.
>>>>>>
>>>>>>  drivers/mmc/host/omap_hsmmc.c |   48
>>>>>> +++++++++++++++++++++++++++++++++++++-----
>>>>>>  1 file changed, 43 insertions(+), 5 deletions(-)
>>>>>>
>>>>>> Index: linux-beagle/drivers/mmc/host/omap_hsmmc.c
>>>>>> ===================================================================
>>>>>> --- linux-beagle.orig/drivers/mmc/host/omap_hsmmc.c
>>>>>> +++ linux-beagle/drivers/mmc/host/omap_hsmmc.c
>>>>>> @@ -27,6 +27,7 @@
>>>>>>  #include <linux/timer.h>
>>>>>>  #include <linux/clk.h>
>>>>>>  #include <linux/mmc/host.h>
>>>>>> +#include <linux/mmc/card.h>
>>>>>>  #include <linux/mmc/core.h>
>>>>>>  #include <linux/io.h>
>>>>>>  #include <linux/semaphore.h>
>>>>>> @@ -65,6 +66,7 @@
>>>>>>  #define SDVSDET                        0x00000400
>>>>>>  #define AUTOIDLE               0x1
>>>>>>  #define SDBP                   (1 << 8)
>>>>>> +#define IBG                    (1 << 19)
>>>>>>  #define DTO                    0xe
>>>>>>  #define ICE                    0x1
>>>>>>  #define ICS                    0x2
>>>>>> @@ -76,6 +78,7 @@
>>>>>>  #define INT_EN_MASK            0x307F0033
>>>>>>  #define BWR_ENABLE             (1 << 4)
>>>>>>  #define BRR_ENABLE             (1 << 5)
>>>>>> +#define CIRQ_ENABLE            (1 << 8)
>>>>>>  #define INIT_STREAM            (1 << 1)
>>>>>>  #define DP_SELECT              (1 << 21)
>>>>>>  #define DDIR                   (1 << 4)
>>>>>> @@ -87,6 +90,7 @@
>>>>>>  #define CC                     0x1
>>>>>>  #define TC                     0x02
>>>>>>  #define OD                     0x1
>>>>>> +#define CIRQ                   (1 <<  8)
>>>>>>  #define ERR                    (1 << 15)
>>>>>>  #define CMD_TIMEOUT            (1 << 16)
>>>>>>  #define DATA_TIMEOUT           (1 << 20)
>>>>>> @@ -653,6 +657,15 @@ static irqreturn_t omap_hsmmc_irq(int ir
>>>>>>      status = OMAP_HSMMC_READ(host->base, STAT);
>>>>>>      dev_dbg(mmc_dev(host->mmc), "IRQ Status is %x\n", status);
>>>>>>
>>>>>> +       if (status & CIRQ) {
>>>>>> +               dev_dbg(mmc_dev(host->mmc), "SDIO interrupt");
>>>>>> +               OMAP_HSMMC_WRITE(host->base, IE,
>>>>>> OMAP_HSMMC_READ(host->base,
>>>>>> IE)
>>>>>> +                                & ~(CIRQ_ENABLE));
>>>>>> +               mmc_signal_sdio_irq(host->mmc);
>>>>>> +               spin_unlock(&host->irq_lock);
>>>>>> +               return IRQ_HANDLED;
>>>>>> +       }
>>>>>> +
>>>>>>      if (status & ERR) {
>>>>>>  #ifdef CONFIG_MMC_DEBUG
>>>>>>              omap_hsmmc_report_irq(host, status);
>>>>>> @@ -1165,8 +1178,15 @@ static void omap_hsmmc_set_ios(struct mm
>>>>>>              break;
>>>>>>      case MMC_BUS_WIDTH_4:
>>>>>>              OMAP_HSMMC_WRITE(host->base, CON, con & ~DW8);
>>>>>> -               OMAP_HSMMC_WRITE(host->base, HCTL,
>>>>>> -                       OMAP_HSMMC_READ(host->base, HCTL) | FOUR_BIT);
>>>>>> +               if (mmc_card_sdio(host->mmc->card)) {
>>>>>> +                       OMAP_HSMMC_WRITE(host->base, HCTL,
>>>>>> +                                        OMAP_HSMMC_READ(host->base,
>>>>>> HCTL)
>>>>>> +                                        | IBG | FOUR_BIT);
>>>>>> +               } else {
>>>>>> +                       OMAP_HSMMC_WRITE(host->base, HCTL,
>>>>>> +                                        OMAP_HSMMC_READ(host->base,
>>>>>> HCTL)
>>>>>> +                                        | FOUR_BIT);
>>>>>> +               }
>>>>>>              break;
>>>>>>      case MMC_BUS_WIDTH_1:
>>>>>>              OMAP_HSMMC_WRITE(host->base, CON, con & ~DW8);
>>>>>> @@ -1512,6 +1532,24 @@ static int omap_hsmmc_disable_fclk(struc
>>>>>>      return 0;
>>>>>>  }
>>>>>>
>>>>>> +static void omap_hsmmc_enable_sdio_irq(struct mmc_host *mmc, int
>>>>>> enable)
>>>>>> +{
>>>>>> +       struct omap_hsmmc_host *host = mmc_priv(mmc);
>>>>>> +       u32 ie, ise;
>>>>>> +
>>>>>> +       ise = OMAP_HSMMC_READ(host->base, ISE);
>>>>>> +       ie  = OMAP_HSMMC_READ(host->base, IE);
>>>>>> +
>>>>>> +       if (enable) {
>>>>>> +               OMAP_HSMMC_WRITE(host->base, ISE, ise | CIRQ_ENABLE);
>>>>>> +               OMAP_HSMMC_WRITE(host->base, IE,  ie  | CIRQ_ENABLE);
>>>>>> +       } else {
>>>>>> +               OMAP_HSMMC_WRITE(host->base, ISE, ise & ~CIRQ_ENABLE);
>>>>>> +               OMAP_HSMMC_WRITE(host->base, IE,  ie  & ~CIRQ_ENABLE);
>>>>>> +       }
>>>>>> +
>>>>>> +}
>>>>>> +
>>>>>>  static const struct mmc_host_ops omap_hsmmc_ops = {
>>>>>>      .enable = omap_hsmmc_enable_fclk,
>>>>>>      .disable = omap_hsmmc_disable_fclk,
>>>>>> @@ -1519,7 +1557,7 @@ static const struct mmc_host_ops omap_hs
>>>>>>      .set_ios = omap_hsmmc_set_ios,
>>>>>>      .get_cd = omap_hsmmc_get_cd,
>>>>>>      .get_ro = omap_hsmmc_get_ro,
>>>>>> -       /* NYET -- enable_sdio_irq */
>>>>>> +       .enable_sdio_irq = omap_hsmmc_enable_sdio_irq,
>>>>>>  };
>>>>>>
>>>>>>  static const struct mmc_host_ops omap_hsmmc_ps_ops = {
>>>>>> @@ -1529,7 +1567,7 @@ static const struct mmc_host_ops omap_hs
>>>>>>      .set_ios = omap_hsmmc_set_ios,
>>>>>>      .get_cd = omap_hsmmc_get_cd,
>>>>>>      .get_ro = omap_hsmmc_get_ro,
>>>>>> -       /* NYET -- enable_sdio_irq */
>>>>>> +       .enable_sdio_irq = omap_hsmmc_enable_sdio_irq,
>>>>>>  };
>>>>>>
>>>>>>  #ifdef CONFIG_DEBUG_FS
>>>>>> @@ -1734,7 +1772,7 @@ static int __init omap_hsmmc_probe(struc
>>>>>>      mmc->max_seg_size = mmc->max_req_size;
>>>>>>
>>>>>>      mmc->caps |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
>>>>>> -                    MMC_CAP_WAIT_WHILE_BUSY;
>>>>>> +                    MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP_SDIO_IRQ;
>>>>>>
>>>>>>      if (mmc_slot(host).wires >= 8)
>>>>>>              mmc->caps |= MMC_CAP_8_BIT_DATA;
>>>>>>
>>>>>>
>>
> 

