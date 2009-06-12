From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: Re: OMAP3xxx hsmmc : MMC3 doesn't work, always times out?
Date: Fri, 12 Jun 2009 10:25:51 +0300
Message-ID: <4A3202FF.9080201@nokia.com>
References: <5a7b8b7b0906101913h2dbcbbc6l8f27873b8f81a3e0@mail.gmail.com> <FCCFB4CDC6E5564B9182F639FC35608702F5345DB6@dbde02.ent.ti.com> <5a7b8b7b0906102035s448e33cfpe4b321d36288e514@mail.gmail.com> <1244700526.9815.31.camel@blitz> <5910F919-941B-4964-99F5-C5772B1965C9@gmail.com> <6ed0b2680906110229u7ce2481sddb0168829bf7d38@mail.gmail.com> <8CD1B7D1-9B84-45C1-BC91-B44839743500@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090604060003020901030802"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:19854 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755329AbZFLH06 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Jun 2009 03:26:58 -0400
In-Reply-To: <8CD1B7D1-9B84-45C1-BC91-B44839743500@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hugo Vincent <hugo.vincent@gmail.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "General mailing list for gumstix users." <gumstix-users@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------090604060003020901030802
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hugo Vincent wrote:
> On 11/06/2009, at 9:29 PM, Grazvydas Ignotas wrote:
> 
>> On Thu, Jun 11, 2009 at 10:43 AM, Hugo
>> Vincent<hugo.vincent@gmail.com> wrote:
>>> On 11/06/2009, at 6:08 PM, Peter Barada wrote:
>>>
>>>> On Thu, 2009-06-11 at 15:35 +1200, Hugo Vincent wrote:
>>>>> On Thu, Jun 11, 2009 at 2:39 PM, Pandita, Vikram<vikram.pandita@ti.com
>>>>> wrote:
>>>>>> Hugo
>>>>>>
>>>>>>> -----Original Message-----
>>>>>>> From: linux-omap-owner@vger.kernel.org
>>>>>>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Hugo
>>>>>>> Vincent
>>>>>>> Sent: Wednesday, June 10, 2009 9:14 PM
>>>>>>> To: linux-omap; General mailing list for gumstix users.
>>>>>>> Subject: OMAP3xxx hsmmc : MMC3 doesn't work, always times out?
>>>>>>>
>>>>>>> Hi everyone,
>>>>>>>
>>>>>>> I'm trying to get the MMC3 slot working on my OMAP3503 Gumstix
>>>>>>> Overo
>>>>>>> based board working.
>>>>>> Please check if your MMC3 Mux setting are as follows:
>>>>>> Note the input configuration for CLK and CMD. This is needed.
>>>>>>
>>>>>> /* MMC3 */
>>>>>> MUX_CFG_34XX("AF10_3430_MMC3_CLK", 0x1d0,
>>>>>>            OMAP34XX_MUX_MODE3 | OMAP34XX_PIN_INPUT_PULLUP)
>>>>>> MUX_CFG_34XX("AC3_3430_MMC3_CMD", 0x5d8,
>>>>>>            OMAP34XX_MUX_MODE2 | OMAP34XX_PIN_INPUT_PULLUP)
>>>>>> MUX_CFG_34XX("AE11_3430_MMC3_DAT0", 0x5e4,
>>>>>>            OMAP34XX_MUX_MODE2 | OMAP34XX_PIN_INPUT_PULLUP)
>>>>>> MUX_CFG_34XX("AH9_3430_MMC3_DAT1", 0x5e6,
>>>>>>            OMAP34XX_MUX_MODE2 | OMAP34XX_PIN_INPUT_PULLUP)
>>>>>> MUX_CFG_34XX("AF13_3430_MMC3_DAT2", 0x5e8,
>>>>>>            OMAP34XX_MUX_MODE2 | OMAP34XX_PIN_INPUT_PULLUP)
>>>>>> MUX_CFG_34XX("AF13_3430_MMC3_DAT3", 0x5e2,
>>>>>>            OMAP34XX_MUX_MODE2 | OMAP34XX_PIN_INPUT_PULLUP)
>>>>>>
>>>>>>
>>>>>> Also we will be soon (tomorrow) posting MUX patch for MMC1,2,3.
>>>>> Thanks for that Vikram. Unfortunately, these are the exact mux &
>>>>> pullup settings I was already using. (In my case, they were set by
>>>>> u-boot, but to be sure, I've copied and pasted the above exactly
>>>>> into
>>>>> mach-omap2/mux.c - same result). Any other ideas?
>>>> Are you using a 1.8V capable SD/MMC card?  MMC3 only works at 1.8V
>>>> on
>>>> the 3430 - MMC1 can work at 3V due to PBIAS register settings.  If
>>>> you're not, then the MMC can talk to the card, but the card can't
>>>> understand what its seeing due to the volatages of CLK/CMD being too
>>>> low...
>>> I am using a 3V SD card. But I'm also using TI TXS02612 for level
>>> translation (and to multiplex between two slots - but for now I
>>> only need to
>>> get one slot working and thus the select pin is wired high). I'm
>>> pretty
>>> confident that the level translation is working correctly as (a)
>>> the clk and
>>> cmd signals come out to the correct pins on the socket at the
>>> correct levels
>>> and (b) remultiplexing the datX signals as GPIOs and driving them is
>>> correctly reflected (and at the correct 3V levels) on the correct
>>> pins on
>>> the card socket. Similarly in the card->OMAP direction of signaling
>>> (they
>>> are of course bidirectional level translators).
>>>
>>> Do I need to somehow tell the mmc host or core driver that I have
>>> external
>>> level translation and therefore not to worry that the host only
>>> supports
>>> 1.8V cards?
>> The TRM says MMC3 "is used without external transceiver" [only?].
>> Doesn't the transceiver need additional control signals (dir_cmd and
>> dir_dat[2:0]), that are only provided by MMC2?
> 
> You are quite possibly correct, but the level translator I'm using is
> "invisible" - it doesn't require the transceiver control signals
> offered only on MMC2. So as far as I know, there is no hardware reason
> the OMAP MMC3 controller couldn't talk correctly at the electrical
> level with the card. This is evidenced by the CMD signal being
> correctly level translated (and this is via the same type of level
> translator as the data signals are according to the TXS02612
> datasheet), and toggling correctly(-looking) at the card socket (i.e.
> between 0 and 3.3V and it's edges synced to the clock signal). The
> DAT0-DAT3 signals never do anything though.
> 
> Hugo
> 
>>> Thanks for your help!
>>>
>>> Hugo
>>>
>>>>>>> Compiling 2.6.29-omap1 with
>>>>>>>  CONFIG_MMC=y
>>>>>>>  CONFIG_MMC_DEBUG=y
>>>>>>>  CONFIG_MMC_BLOCK=y
>>>>>>>  CONFIG_MMC_BLOCK_BOUNCE=y
>>>>>>> and MMC polling enabled (mmc->caps |= MMC_CAP_NEEDS_POLL; in
>>>>>>> omap_hsmmc.c)
>>>>>>>
>>>>>>> then doing: $ echo 8 > /proc/sys/kernel/printk
>>>>>>> gives the following:
>>>>>>>
>>>>>>> clock 0Hz busmode 1 powermode 1 cs 0 Vdd 20 width 0 timing 0
>>>>>>> mmc2: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 20 width 0
>>>>>>> timing 0
>>>>>>> mmc2: clock 400000Hz busmode 1 powermode 2 cs 1 Vdd 20 width 0
>>>>>>> timing 0
>>>>>>> mmc2: starting CMD0 arg 00000000 flags 000000c0
>>>>>>> mmci-omap-hs mmci-omap-hs.2: mmc2: CMD0, argument 0x00000000
>>>>>>> mmci-omap-hs mmci-omap-hs.2: IRQ Status is 1
>>>>>>> mmc2: req done (CMD0): 0: 00000000 00000000 00000000 00000000
>>>>>>> mmc2: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 20 width 0
>>>>>>> timing 0
>>>>>>> mmc2: starting CMD8 arg 000001aa flags 000002f5
>>>>>>> mmci-omap-hs mmci-omap-hs.2: mmc2: CMD8, argument 0x000001aa
>>>>>>> mmci-omap-hs mmci-omap-hs.2: IRQ Status is 18000
>>>>>>> mmci-omap-hs mmci-omap-hs.2: MMC IRQ 0x18000 : ERRI CTO
>>>>>>> mmc2: req done (CMD8): -110: 00000000 00000000 00000000 00000000
>>>>>>> mmc2: starting CMD5 arg 00000000 flags 000002e1
>>>>>>> mmci-omap-hs mmci-omap-hs.2: mmc2: CMD5, argument 0x00000000
>>>>>>> mmci-omap-hs mmci-omap-hs.2: IRQ Status is 18000
>>>>>>> mmci-omap-hs mmci-omap-hs.2: MMC IRQ 0x18000 : ERRI CTO
>>>>>>> mmc2: req failed (CMD5): -110, retrying...
>>>>>>> mmci-omap-hs mmci-omap-hs.2: mmc2: CMD5, argument 0x00000000
>>>>>>> mmci-omap-hs mmci-omap-hs.2: IRQ Status is 18000
>>>>>>> mmci-omap-hs mmci-omap-hs.2: MMC IRQ 0x18000 : ERRI CTO
>>>>>>> mmc2: req failed (CMD5): -110, retrying...
>>>>>>> mmci-omap-hs mmci-omap-hs.2: mmc2: CMD5, argument 0x00000000
>>>>>>> mmci-omap-hs mmci-omap-hs.2: IRQ Status is 18000
>>>>>>> mmci-omap-hs mmci-omap-hs.2: MMC IRQ 0x18000 : ERRI CTO
>>>>>>> mmc2: req failed (CMD5): -110, retrying...
>>>>>>> mmci-omap-hs mmci-omap-hs.2: mmc2: CMD5, argument 0x00000000
>>>>>>> mmci-omap-hs mmci-omap-hs.2: IRQ Status is 18000
>>>>>>> mmci-omap-hs mmci-omap-hs.2: MMC IRQ 0x18000 : ERRI CTO
>>>>>>> mmc2: req done (CMD5): -110: 00000000 00000000 00000000 00000000
>>>>>>> mmc2: starting CMD55 arg 00000000 flags 000000f5
>>>>>>> mmci-omap-hs mmci-omap-hs.2: mmc2: CMD55, argument 0x00000000
>>>>>>> mmci-omap-hs mmci-omap-hs.2: IRQ Status is 18000
>>>>>>> mmci-omap-hs mmci-omap-hs.2: MMC IRQ 0x18000 : ERRI CTO
>>>>>>> mmc2: req done (CMD55): -110: 00000000 00000000 00000000 00000000
>>>>>>> mmc2: starting CMD55 arg 00000000 flags 000000f5
>>>>>>> mmci-omap-hs mmci-omap-hs.2: mmc2: CMD55, argument 0x00000000
>>>>>>> mmci-omap-hs mmci-omap-hs.2: IRQ Status is 18000
>>>>>>> mmci-omap-hs mmci-omap-hs.2: MMC IRQ 0x18000 : ERRI CTO
>>>>>>> mmc2: req done (CMD55): -110: 00000000 00000000 00000000 00000000
>>>>>>> mmc2: starting CMD55 arg 00000000 flags 000000f5
>>>>>>> mmci-omap-hs mmci-omap-hs.2: mmc2: CMD55, argument 0x00000000
>>>>>>> mmci-omap-hs mmci-omap-hs.2: IRQ Status is 18000
>>>>>>> mmci-omap-hs mmci-omap-hs.2: MMC IRQ 0x18000 : ERRI CTO
>>>>>>> mmc2: req done (CMD55): -110: 00000000 00000000 00000000 00000000
>>>>>>> mmc2: starting CMD55 arg 00000000 flags 000000f5
>>>>>>> mmci-omap-hs mmci-omap-hs.2: mmc2: CMD55, argument 0x00000000
>>>>>>> mmci-omap-hs mmci-omap-hs.2: IRQ Status is 18000
>>>>>>> mmci-omap-hs mmci-omap-hs.2: MMC IRQ 0x18000 : ERRI CTO
>>>>>>> mmc2: req done (CMD55): -110: 00000000 00000000 00000000 00000000
>>>>>>> mmc2: starting CMD1 arg 00000000 flags 000000e1
>>>>>>> mmci-omap-hs mmci-omap-hs.2: mmc2: CMD1, argument 0x00000000
>>>>>>> mmci-omap-hs mmci-omap-hs.2: IRQ Status is 18000
>>>>>>> mmci-omap-hs mmci-omap-hs.2: MMC IRQ 0x18000 : ERRI CTO
>>>>>>> mmc2: req done (CMD1): -110: 00000000 00000000 00000000 00000000
>>>>>>> mmc2: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0 width 0 timing 0
>>>>>>>
>>>>>>> It seems every request returns -110 which is -ETIMEDOUT.
>>>>>>>
>>>>>>> I've checked the hardware, and it appears to be correct (level
>>>>>>> translators etc seem to be doing their job).
>>>>>>>
>>>>>>> During polling, the CMD and CLK signals show activity, but the
>>>>>>> data
>>>>>>> lines never change; this is presumably why every request is
>>>>>>> timing
>>>>>>> out.
>>>>>>>
>>>>>>> I've also tried it with 2.6.30-omap1 in git, which changes some
>>>>>>> MMC3-specific stuff (notably DMA), but has the exact same
>>>>>>> behaviour.
>>>>>>>
>>>>>>> I've also checked pin multiplexing settings and confirmed that
>>>>>>> the
>>>>>>> correct values are set for the MMC3 data pins. The card I'm
>>>>>>> using is a
>>>>>>> microSD card that works when attached to MMC1 (the Gumstix Overo
>>>>>>> built-in microSD slot). The slot is powered by 3.3V that is
>>>>>>> always on,
>>>>>>> there is no provision for power switching with this particular
>>>>>>> board.
>>>>>>>
>>>>>>> Any ideas?
>>>>>>>
>>>>>>> Many thanks,
>>>>>>> Hugo Vincent

We have fixed a few bugs in omap_hsmmc.c that we have not had time
to send to mainline, but will hopefully in the coming weeks.

I have attached some patches which probably do not apply cleanly,
and may not help with your problem anyway.



--------------090604060003020901030802
Content-Type: text/x-diff;
 name="0001-omap_hsmmc-set-open-drain-bit-correctly.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-omap_hsmmc-set-open-drain-bit-correctly.patch"

>From d92f5c940461992c7a25f134a58a94bd3161fd54 Mon Sep 17 00:00:00 2001
From: Denis Karpov <ext-denis.2.karpov@nokia.com>
Date: Thu, 23 Apr 2009 16:44:58 +0300
Subject: [PATCH] omap_hsmmc: set open drain bit correctly

The code could set the bit to 1 but not reset it to 0.

Signed-off-by: Denis Karpov <ext-denis.2.karpov@nokia.com>
Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 drivers/mmc/host/omap_hsmmc.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 19bbfa5..87d4e7a 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1033,9 +1033,11 @@ static void omap_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	if (ios->power_mode == MMC_POWER_ON)
 		send_init_stream(host);
 
+	con = OMAP_HSMMC_READ(host->base, CON);
 	if (ios->bus_mode == MMC_BUSMODE_OPENDRAIN)
-		OMAP_HSMMC_WRITE(host->base, CON,
-				OMAP_HSMMC_READ(host->base, CON) | OD);
+		OMAP_HSMMC_WRITE(host->base, CON, con | OD);
+	else
+		OMAP_HSMMC_WRITE(host->base, CON, con & ~OD);
 
 	mmc_host_lazy_disable(host->mmc);
 }
-- 
1.5.6.3


--------------090604060003020901030802
Content-Type: text/x-diff;
 name="0002-omap_hsmmc-clear-interrupt-status-after-init-sequen.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0002-omap_hsmmc-clear-interrupt-status-after-init-sequen.pat";
 filename*1="ch"

>From 908a0774d4e60408542fc848d00f8fdafd540762 Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@nokia.com>
Date: Sat, 16 May 2009 09:35:17 +0300
Subject: [PATCH] omap_hsmmc: clear interrupt status after init sequence

Clear the interrupt status after sending the initialization sequence,
as specified in the TRM.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 drivers/mmc/host/omap_hsmmc.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 066ed2e..af10012 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -354,6 +354,10 @@ static void send_init_stream(struct mmc_omap_host *host)
 
 	OMAP_HSMMC_WRITE(host->base, CON,
 		OMAP_HSMMC_READ(host->base, CON) & ~INIT_STREAM);
+
+	OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
+	OMAP_HSMMC_READ(host->base, STAT);
+
 	enable_irq(host->irq);
 }
 
-- 
1.5.6.3


--------------090604060003020901030802
Content-Type: text/x-diff;
 name="0003-omap_hsmmc-cater-for-weird-CMD6-behaviour.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0003-omap_hsmmc-cater-for-weird-CMD6-behaviour.patch"

>From d060f6d385adc1bd2e7b34b036915836df93624d Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@nokia.com>
Date: Sat, 16 May 2009 10:05:40 +0300
Subject: [PATCH] omap_hsmmc: cater for weird CMD6 behaviour

Sometimes the controller unexpectedly produces a TC (transfer
complete) interrupt before the CC (command complete) interrupt for
command 6 (SWITCH).  This is a problem because the CC interrupt
can get mixed up with the next request.  Add a hack for CMD6.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 drivers/mmc/host/omap_hsmmc.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index af10012..ee25ce4 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -470,6 +470,13 @@ mmc_omap_xfer_done(struct mmc_omap_host *host, struct mmc_data *data)
 	if (!data) {
 		struct mmc_request *mrq = host->mrq;
 
+		/* TC before CC from CMD6 - don't know why, but it happens */
+		if (host->cmd && host->cmd->opcode == 6 &&
+		    host->response_busy) {
+			host->response_busy = 0;
+			return;
+		}
+
 		host->mrq = NULL;
 		mmc_request_done(host->mmc, mrq);
 		return;
-- 
1.5.6.3


--------------090604060003020901030802
Content-Type: text/x-diff;
 name="0004-omap_hsmmc-prevent-races-with-irq-handler.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0004-omap_hsmmc-prevent-races-with-irq-handler.patch"

>From ee637dbef6306a9b774b388d02ac81200906830c Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@nokia.com>
Date: Sat, 16 May 2009 10:32:34 +0300
Subject: [PATCH] omap_hsmmc: prevent races with irq handler

If an unexpected interrupt occurs while preparing the
next request, an oops can occur.

For example, a new request is setting up DMA for data
transfer so host->data is not NULL.  An unexpected
transfer complete (TC) interrupt comes along and
the interrupt handler sets host->data to NULL.  Oops!

Prevent that by disabling interrupts while setting up
a new request.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 drivers/mmc/host/omap_hsmmc.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index ee25ce4..751f63f 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -448,6 +448,13 @@ mmc_omap_start_command(struct mmc_omap_host *host, struct mmc_command *cmd,
 	if (host->use_dma)
 		cmdreg |= DMA_EN;
 
+	/*
+	 * In an interrupt context (i.e. STOP command), the interrupt is already
+	 * enabled, otherwise it is not (i.e. new request).
+	 */
+	if (!in_interrupt())
+		enable_irq(host->irq);
+
 	OMAP_HSMMC_WRITE(host->base, ARG, cmd->arg);
 	OMAP_HSMMC_WRITE(host->base, CMD, cmdreg);
 }
@@ -981,6 +988,13 @@ static void omap_mmc_request(struct mmc_host *mmc, struct mmc_request *req)
 	struct mmc_omap_host *host = mmc_priv(mmc);
 	int err;
 
+	/*
+	 * Prevent races with the interrupt handler because of unexpected
+	 * interrupts, but not if we are already in interrupt context i.e.
+	 * retries.
+	 */
+	if (!in_interrupt())
+		disable_irq(host->irq);
 	WARN_ON(host->mrq != NULL);
 	host->mrq = req;
 	err = mmc_omap_prepare_data(host, req);
@@ -991,6 +1005,8 @@ static void omap_mmc_request(struct mmc_host *mmc, struct mmc_request *req)
 			req->cmd->error = err;
 
 		mmc_omap_xfer_done(host, host->data);
+		if (!in_interrupt())
+			enable_irq(host->irq);
 		return;
 	}
 
-- 
1.5.6.3


--------------090604060003020901030802--
