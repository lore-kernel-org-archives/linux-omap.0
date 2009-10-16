From: John Rigby <jcrigby@gmail.com>
Subject: Re: MMC_CAP_SDIO_IRQ for omap 3430
Date: Fri, 16 Oct 2009 12:51:01 -0600
Message-ID: <4b73d43f0910161151t2b85a5e8w3fa9951e1339d69a@mail.gmail.com>
References: <4b73d43f0910151330q6c5cae7sa2a5948b586cc215@mail.gmail.com>
	 <4AD81DC2.4080607@googlemail.com>
	 <4b73d43f0910160643y59d39373y1dd1c1995f521778@mail.gmail.com>
	 <4AD88B0A.1010006@googlemail.com>
	 <4b73d43f0910160859j6958afeaw415a2a71efc72672@mail.gmail.com>
	 <4AD89A01.1020400@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f172.google.com ([209.85.221.172]:54079 "EHLO
	mail-qy0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410AbZJPSu6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Oct 2009 14:50:58 -0400
Received: by qyk2 with SMTP id 2so1677408qyk.21
        for <linux-omap@vger.kernel.org>; Fri, 16 Oct 2009 11:51:02 -0700 (PDT)
In-Reply-To: <4AD89A01.1020400@googlemail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap@vger.kernel.org, Madhusudhan <madhu.cr@ti.com>, Steve Sakoman <sakoman@gmail.com>

=46irst the disclaimers:
The board is new board that has had hardware mmc/sdio problems before.
 It is based closely on beagle but uses a different package which has
some package specific issues.  We think we have found them all but who
knows.

My kernel is a few months old 2.6.29.

Ok, given the above issues, it looks to me like I am getting
interrupted every time  CIRQ is enabled.  Nor sure if the libertas
driver is not disabling as it should or what.  So I end up in this
death spiral:

irq handler is called and status indicates CIRQ is pending

mmc_signal_sdio_irq is called which calls omap_hsmmc_enable_sdio_irq
with via mmc_host_ops, en is zero so CIRQ gets disabled

mmc_signal_sdio_irq then wakes up sdio_irq_thread which does its thing
then before going to sleep calls omap_hsmmc_enable_irq with en set to
1 so CIRC gets turned back on

with CIRC enabled the irq handler gets called and we are back where we =
started.

Looks like either the libertas driver is not disabling the irq or the
CIRQ irq is somehow getting stuck or I have a hw problem.

One thing I did try was to have the sdio_irq_thread basically ignore
the MMC_CAP_SDIO_IRQ flag except for calling
host->ops->enable_sdio_irq(host, 1) and I changed mmc_signal_sdio_irq
to not reschedule sdio_irq_thread.  In shows that the mere act of
enabling CIRQ does not break anything.  In this mode I get one CIRQ
irq for each time around the sdio_irq_thread loop.

I guess I should try checking the CIRQ bit in the status register
after calling the libertas handler which should clear the irq?


John


On Fri, Oct 16, 2009 at 10:06 AM, Dirk Behme <dirk.behme@googlemail.com=
> wrote:
> John Rigby wrote:
>>
>> Dirk,
>>
>> Thanks for the update. =A0After looking more closely at your patch I
>> found that the only thing my attempt was missing was the IBG setting=
=2E
>> I added that to mine with the result that the system hangs on loadin=
g
>> the libertas modules.
>
> On which board are you working? libertas does mean you are working on=
 wifi
> connected via SDIO?
>
>> The last thing i see is the firmware request
>> message.
>
> Ok, you see a hang. Below we have a timeout.
>
> I would vote for some interrupt issues. For timeouts I would vote for
> missing interrupts, while system hang might be infinite interrupts
> (something like this was reported in [1]).
>
> Could you add some debug code in omap_hsmmc_enable_sdio_irq() to trac=
e if
> enable/disable is called in the correct order? And in omap_hsmmc_irq(=
) in if
> (status & CIRQ) { to check if and how often it is called?
>
> Best regards
>
> Dirk
>
> [1] http://groups.google.com/group/beagleboard/msg/5cdfe2a319531937
>
>> On Fri, Oct 16, 2009 at 9:02 AM, Dirk Behme <dirk.behme@googlemail.c=
om>
>> wrote:
>>>
>>> John,
>>>
>>> John Rigby wrote:
>>>>
>>>> Dirk,
>>>>
>>>> Many thanks, after sending the request yesterday I made my own att=
empt
>>>> which failed miserably. =A0My patch looks like a subset of yours s=
o that
>>>> is to be expected. =A0I'll try yours out today and report back my
>>>> experience.
>>>
>>> I got already some (private) feedback (thanks!):
>>>
>>> - Accessing host->mmc->card in omap_hsmmc_set_ios() results in a nu=
ll
>>> pointer :( Seems that mmc->card isn't set yet while calling
>>> omap_hsmmc_set_ios().
>>>
>>> As workaround, for testing only, I hard coded setting IBG with some=
thing
>>> like
>>>
>>> =A0 =A0 =A0 case MMC_BUS_WIDTH_4:
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_HSMMC_WRITE(host->base, CON, con &=
 ~DW8);
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_HSMMC_WRITE(host->base, HCTL,
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_HSMMC_READ(host-=
>base, HCTL) | FOUR_BIT);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_HSMMC_WRITE(host=
->base, HCTL,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0OMAP_HSMMC_READ(host->base,
>>> HCTL) |
>>> IBG | FOUR_BIT);
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>>>
>>> If you test this, be careful that this doesn't hurt any other 4 bit=
 cards
>>> except the SDIO you want to test.
>>>
>>> Later, we have to find a way how to detect that we are in SDIO mode=
=2E We
>>> want
>>> to set IBG only if in SDIO and 4 bit mode.
>>>
>>> - =A0After this, I got the report that null pointer crash is gone. =
But SDIO
>>> doesn't seem to work any more:
>>>
>>> libertas_sdio: Libertas SDIO driver
>>> libertas_sdio: Copyright Pierre Ossman
>>> libertas_sdio mmc1:0001:1: firmware: requesting sd8686_helper.bin
>>> libertas_sdio mmc1:0001:1: firmware: requesting sd8686.bin
>>> libertas: command 0x0003 timed out
>>> libertas: requeueing command 0x0003 due to timeout (#1)
>>> libertas: command 0x0003 timed out
>>> libertas: requeueing command 0x0003 due to timeout (#2)
>>> libertas: command 0x0003 timed out
>>> libertas: requeueing command 0x0003 due to timeout (#3)
>>> libertas: command 0x0003 timed out
>>> libertas: Excessive timeouts submitting command 0x0003
>>> libertas: PREP_CMD: command 0x0003 failed: -110
>>> libertas_sdio: probe of mmc1:0001:1 failed with error -110
>>>
>>> I now start to think about it ;)
>>>
>>> Again, any help would be appreciated!
>>>
>>> Best regards
>>>
>>> Dirk
>>>
>>>> On Fri, Oct 16, 2009 at 1:16 AM, Dirk Behme <dirk.behme@googlemail=
=2Ecom>
>>>> wrote:
>>>>>
>>>>> John Rigby wrote:
>>>>>>
>>>>>> I have seen several discussions about lack of sdio irq support i=
n the
>>>>>> hsmmc driver but no patches. =A0Has anyone on this list implemen=
ted this
>>>>>> and/or can anyone point me to patches?
>>>>>
>>>>> What a coincidence ;)
>>>>>
>>>>> I'm currently working on this. See attachment what I currently ha=
ve. It
>>>>> is
>>>>> compile tested only against recent omap linux head. I don't have =
a
>>>>> board
>>>>> using SDIO at the moment, so no real testing possible :(
>>>>>
>>>>> Some background, maybe it helps people to step in:
>>>>>
>>>>> Gumstix OMAP3 based Overo air board connects Marvell 88W8686 wifi=
 by
>>>>> MMC
>>>>> port 2 in 4 bit configuration [1]. The wifi performance is quite =
bad
>>>>> (~100kB/s). There is some rumor that this might be SDIO irq relat=
ed
>>>>> [2].
>>>>> There was an attempt to fix this [3] already, but this doesn't wo=
rk
>>>>> [4].
>>>>> Having this, I started to look into it.
>>>>>
>>>>> I used [3], the TI Davinci driver [5] (supporting SDIO irq), the =
SDIO
>>>>> Simplified Specification [6] and the OMAP35x TRM [7] as starting
>>>>> points.
>>>>>
>>>>> Unfortunately, the Davinci MMC registers and irqs are different
>>>>> (Davinci
>>>>> has
>>>>> a dedicated SDIO irq). But combining [3] and [5] helps to get an =
idea
>>>>> what
>>>>> has to be done.
>>>>>
>>>>> I think the main issues of [3] were that it doesn't enable IBG fo=
r 4
>>>>> bit
>>>>> mode ([6] chapter 8.1.2) and that mmc_omap_irq() doesn't reset th=
e irq
>>>>> bits.
>>>>>
>>>>> Topics I still open:
>>>>>
>>>>> - Is it always necessary to deal with IE _and_ ISE register? I'm =
not
>>>>> totally
>>>>> clear what the difference between these two registers are ;) And =
in
>>>>> which
>>>>> order they have to be set.
>>>>>
>>>>> - Davinci driver [5] in line 1115 checks for data line to call
>>>>> mmc_signal_sdio_irq() for irq enable.
>>>>>
>>>>> - Davinci driver deals with SDIO in xfer_done() (line 873)
>>>>>
>>>>> - Davinci driver sets block size to 64 if SDIO in line 701
>>>>>
>>>>> It would be quite nice if anybody likes to comment on attachment =
and
>>>>> help
>>>>> testing.
>>>>>
>>>>> Many thanks and best regards
>>>>>
>>>>> Dirk
>>>>>
>>>>> [1] http://gumstix.net/wiki/index.php?title=3DOvero_Wifi
>>>>>
>>>>> [2] http://groups.google.com/group/beagleboard/msg/14e822778c5eeb=
56
>>>>>
>>>>> [3] http://groups.google.com/group/beagleboard/msg/d0eb69f4c20673=
be
>>>>>
>>>>> [4] http://groups.google.com/group/beagleboard/msg/5cdfe2a3195319=
37
>>>>>
>>>>> [5]
>>>>>
>>>>>
>>>>> http://arago-project.org/git/projects/?p=3Dlinux-davinci.git;a=3D=
blob;f=3Ddrivers/mmc/host/davinci_mmc.c;h=3D1bf0587250614c6d8abfe02028b=
96e0e47148ac8;hb=3DHEAD
>>>>>
>>>>> [6] http://www.sdcard.org/developers/tech/sdio/sd_bluetooth_spec/
>>>>>
>>>>> [7] http://focus.ti.com/lit/ug/spruf98c/spruf98c.pdf
>>>>>
>>>>>
>>>>> Subject: [PATCH][RFC] OMAP HSMMC: Add SDIO interrupt support
>>>>> Form: Dirk Behme <dirk.behme@googlemail.com>
>>>>>
>>>>> At the moment, OMAP HSMMC driver supports only SDIO polling, resu=
lting
>>>>> in
>>>>> poor
>>>>> performance. Add support for SDIO interrupt handling.
>>>>>
>>>>> Signed-off-by: Dirk Behme <dirk.behme@googlemail.com>
>>>>> ---
>>>>>
>>>>> Patch against recent omap-linux head "Linux omap got rebuilt from
>>>>> scratch"
>>>>> 274c94b29ee7c53609a756acca974e4742c59559
>>>>>
>>>>> Compile tested only. Please comment and help testing.
>>>>>
>>>>> =A0drivers/mmc/host/omap_hsmmc.c | =A0 48
>>>>> +++++++++++++++++++++++++++++++++++++-----
>>>>> =A01 file changed, 43 insertions(+), 5 deletions(-)
>>>>>
>>>>> Index: linux-beagle/drivers/mmc/host/omap_hsmmc.c
>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>> --- linux-beagle.orig/drivers/mmc/host/omap_hsmmc.c
>>>>> +++ linux-beagle/drivers/mmc/host/omap_hsmmc.c
>>>>> @@ -27,6 +27,7 @@
>>>>> =A0#include <linux/timer.h>
>>>>> =A0#include <linux/clk.h>
>>>>> =A0#include <linux/mmc/host.h>
>>>>> +#include <linux/mmc/card.h>
>>>>> =A0#include <linux/mmc/core.h>
>>>>> =A0#include <linux/io.h>
>>>>> =A0#include <linux/semaphore.h>
>>>>> @@ -65,6 +66,7 @@
>>>>> =A0#define SDVSDET =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
0x00000400
>>>>> =A0#define AUTOIDLE =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x1
>>>>> =A0#define SDBP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 8)
>>>>> +#define IBG =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 19)
>>>>> =A0#define DTO =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00xe
>>>>> =A0#define ICE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x1
>>>>> =A0#define ICS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x2
>>>>> @@ -76,6 +78,7 @@
>>>>> =A0#define INT_EN_MASK =A0 =A0 =A0 =A0 =A0 =A00x307F0033
>>>>> =A0#define BWR_ENABLE =A0 =A0 =A0 =A0 =A0 =A0 (1 << 4)
>>>>> =A0#define BRR_ENABLE =A0 =A0 =A0 =A0 =A0 =A0 (1 << 5)
>>>>> +#define CIRQ_ENABLE =A0 =A0 =A0 =A0 =A0 =A0(1 << 8)
>>>>> =A0#define INIT_STREAM =A0 =A0 =A0 =A0 =A0 =A0(1 << 1)
>>>>> =A0#define DP_SELECT =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 21)
>>>>> =A0#define DDIR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 4)
>>>>> @@ -87,6 +90,7 @@
>>>>> =A0#define CC =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x1
>>>>> =A0#define TC =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x02
>>>>> =A0#define OD =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x1
>>>>> +#define CIRQ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << =A08)
>>>>> =A0#define ERR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 15)
>>>>> =A0#define CMD_TIMEOUT =A0 =A0 =A0 =A0 =A0 =A0(1 << 16)
>>>>> =A0#define DATA_TIMEOUT =A0 =A0 =A0 =A0 =A0 (1 << 20)
>>>>> @@ -653,6 +657,15 @@ static irqreturn_t omap_hsmmc_irq(int ir
>>>>> =A0 =A0 =A0status =3D OMAP_HSMMC_READ(host->base, STAT);
>>>>> =A0 =A0 =A0dev_dbg(mmc_dev(host->mmc), "IRQ Status is %x\n", stat=
us);
>>>>>
>>>>> + =A0 =A0 =A0 if (status & CIRQ) {
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(mmc_dev(host->mmc), "SDIO i=
nterrupt");
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_HSMMC_WRITE(host->base, IE,
>>>>> OMAP_HSMMC_READ(host->base,
>>>>> IE)
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
& ~(CIRQ_ENABLE));
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_signal_sdio_irq(host->mmc);
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(&host->irq_lock);
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return IRQ_HANDLED;
>>>>> + =A0 =A0 =A0 }
>>>>> +
>>>>> =A0 =A0 =A0if (status & ERR) {
>>>>> =A0#ifdef CONFIG_MMC_DEBUG
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_hsmmc_report_irq(host, status);
>>>>> @@ -1165,8 +1178,15 @@ static void omap_hsmmc_set_ios(struct mm
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>>>>> =A0 =A0 =A0case MMC_BUS_WIDTH_4:
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP_HSMMC_WRITE(host->base, CON, con =
& ~DW8);
>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_HSMMC_WRITE(host->base, HCTL,
>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_HSMMC_READ(hos=
t->base, HCTL) | FOUR_BIT);
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_card_sdio(host->mmc->card))=
 {
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_HSMMC_WRITE(ho=
st->base, HCTL,
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0OMAP_HSMMC_READ(host->base,
>>>>> HCTL)
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0| IBG | FOUR_BIT);
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_HSMMC_WRITE(ho=
st->base, HCTL,
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0OMAP_HSMMC_READ(host->base,
>>>>> HCTL)
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0| FOUR_BIT);
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>>>>> =A0 =A0 =A0case MMC_BUS_WIDTH_1:
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP_HSMMC_WRITE(host->base, CON, con =
& ~DW8);
>>>>> @@ -1512,6 +1532,24 @@ static int omap_hsmmc_disable_fclk(struc
>>>>> =A0 =A0 =A0return 0;
>>>>> =A0}
>>>>>
>>>>> +static void omap_hsmmc_enable_sdio_irq(struct mmc_host *mmc, int
>>>>> enable)
>>>>> +{
>>>>> + =A0 =A0 =A0 struct omap_hsmmc_host *host =3D mmc_priv(mmc);
>>>>> + =A0 =A0 =A0 u32 ie, ise;
>>>>> +
>>>>> + =A0 =A0 =A0 ise =3D OMAP_HSMMC_READ(host->base, ISE);
>>>>> + =A0 =A0 =A0 ie =A0=3D OMAP_HSMMC_READ(host->base, IE);
>>>>> +
>>>>> + =A0 =A0 =A0 if (enable) {
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_HSMMC_WRITE(host->base, ISE, i=
se | CIRQ_ENABLE);
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_HSMMC_WRITE(host->base, IE, =A0=
ie =A0| CIRQ_ENABLE);
>>>>> + =A0 =A0 =A0 } else {
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_HSMMC_WRITE(host->base, ISE, i=
se & ~CIRQ_ENABLE);
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_HSMMC_WRITE(host->base, IE, =A0=
ie =A0& ~CIRQ_ENABLE);
>>>>> + =A0 =A0 =A0 }
>>>>> +
>>>>> +}
>>>>> +
>>>>> =A0static const struct mmc_host_ops omap_hsmmc_ops =3D {
>>>>> =A0 =A0 =A0.enable =3D omap_hsmmc_enable_fclk,
>>>>> =A0 =A0 =A0.disable =3D omap_hsmmc_disable_fclk,
>>>>> @@ -1519,7 +1557,7 @@ static const struct mmc_host_ops omap_hs
>>>>> =A0 =A0 =A0.set_ios =3D omap_hsmmc_set_ios,
>>>>> =A0 =A0 =A0.get_cd =3D omap_hsmmc_get_cd,
>>>>> =A0 =A0 =A0.get_ro =3D omap_hsmmc_get_ro,
>>>>> - =A0 =A0 =A0 /* NYET -- enable_sdio_irq */
>>>>> + =A0 =A0 =A0 .enable_sdio_irq =3D omap_hsmmc_enable_sdio_irq,
>>>>> =A0};
>>>>>
>>>>> =A0static const struct mmc_host_ops omap_hsmmc_ps_ops =3D {
>>>>> @@ -1529,7 +1567,7 @@ static const struct mmc_host_ops omap_hs
>>>>> =A0 =A0 =A0.set_ios =3D omap_hsmmc_set_ios,
>>>>> =A0 =A0 =A0.get_cd =3D omap_hsmmc_get_cd,
>>>>> =A0 =A0 =A0.get_ro =3D omap_hsmmc_get_ro,
>>>>> - =A0 =A0 =A0 /* NYET -- enable_sdio_irq */
>>>>> + =A0 =A0 =A0 .enable_sdio_irq =3D omap_hsmmc_enable_sdio_irq,
>>>>> =A0};
>>>>>
>>>>> =A0#ifdef CONFIG_DEBUG_FS
>>>>> @@ -1734,7 +1772,7 @@ static int __init omap_hsmmc_probe(struc
>>>>> =A0 =A0 =A0mmc->max_seg_size =3D mmc->max_req_size;
>>>>>
>>>>> =A0 =A0 =A0mmc->caps |=3D MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGH=
SPEED |
>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MMC_CAP_WAIT_WHILE_BUSY;
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MMC_CAP_WAIT_WHILE_BUSY =
| MMC_CAP_SDIO_IRQ;
>>>>>
>>>>> =A0 =A0 =A0if (mmc_slot(host).wires >=3D 8)
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->caps |=3D MMC_CAP_8_BIT_DATA;
>>>>>
>>>>>
>>>
>>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
