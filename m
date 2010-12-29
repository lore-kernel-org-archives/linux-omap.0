From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/5] ASoC: DMIC: Adding the OMAP DMIC driver
Date: Wed, 29 Dec 2010 11:47:38 +0200
Message-ID: <20101229094738.GA2254@legolas.emea.dhcp.ti.com>
References: <1293509826-23253-1-git-send-email-dlambert@ti.com>
 <1293509826-23253-2-git-send-email-dlambert@ti.com>
 <20101228111424.GB2239@legolas.emea.dhcp.ti.com>
 <AANLkTi=6iWz0jdakBBgw2OEOjADvS2YmCN0ebKODQ7Ke@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:35870 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750837Ab0L2Jro (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Dec 2010 04:47:44 -0500
Received: by eye27 with SMTP id 27so5483010eye.33
        for <linux-omap@vger.kernel.org>; Wed, 29 Dec 2010 01:47:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTi=6iWz0jdakBBgw2OEOjADvS2YmCN0ebKODQ7Ke@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Lambert, David" <dlambert@ti.com>
Cc: balbi@ti.com, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>

Hi,

On Tue, Dec 28, 2010 at 07:13:58PM -0600, Lambert, David wrote:
>> one blank line only. BTW, are these used anywwhere outside the dmic.=
c
>> driver ? If not, it's better to move the definitions there.
>>
>
>They were originally in the omap-dmic.h header, but it was suggested
>that we move
>them to a platform header so that the driver could be more
>architecture independent
>and we could put the platform specific details here.  I'm OK putting
>them just about
>anywhere, as long as we have consensus.

The thing I don't like about putting register definitions under
<plat/*.h> is that it creates the need for making the driver "depends o=
n
ARCH_OMAP" because it's the only architecture which has that file. If
you put under <linux/*> or directly on the .c source file, you can have
a much needed compile test with several architectures.

Even though the driver will never work with those other archs, compile
testing with several of them isn't bad at all.

>>> +#ifdef DEBUG
>>> +static void omap_dmic_reg_dump(struct omap_dmic *dmic)
>>> +{
>>> + =A0 =A0 =A0 dev_dbg(dmic->dev, "***********************\n");
>>> + =A0 =A0 =A0 dev_dbg(dmic->dev, "OMAP_DMIC_IRQSTATUS_RAW: =A00x%04=
x\n",
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dmic_read(dmic, OMAP_DMIC_IRQSTA=
TUS_RAW));
>>> + =A0 =A0 =A0 dev_dbg(dmic->dev, "OMAP_DMIC_IRQSTATUS: =A00x%04x\n"=
,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dmic_read(dmic, OMAP_DMIC_IRQSTA=
TUS));
>>> + =A0 =A0 =A0 dev_dbg(dmic->dev, "OMAP_DMIC_IRQENABLE_SET: =A00x%04=
x\n",
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dmic_read(dmic, OMAP_DMIC_IRQENA=
BLE_SET));
>>> + =A0 =A0 =A0 dev_dbg(dmic->dev, "OMAP_DMIC_IRQENABLE_CLR: =A00x%04=
x\n",
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dmic_read(dmic, OMAP_DMIC_IRQENA=
BLE_CLR));
>>> + =A0 =A0 =A0 dev_dbg(dmic->dev, "OMAP_DMIC_IRQWAKE_EN: =A00x%04x\n=
",
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dmic_read(dmic, OMAP_DMIC_IRQWAK=
E_EN));
>>> + =A0 =A0 =A0 dev_dbg(dmic->dev, "OMAP_DMIC_DMAENABLE_SET: =A00x%04=
x\n",
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dmic_read(dmic, OMAP_DMIC_DMAENA=
BLE_SET));
>>> + =A0 =A0 =A0 dev_dbg(dmic->dev, "OMAP_DMIC_DMAENABLE_CLR: =A00x%04=
x\n",
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dmic_read(dmic, OMAP_DMIC_DMAENA=
BLE_CLR));
>>> + =A0 =A0 =A0 dev_dbg(dmic->dev, "OMAP_DMIC_DMAWAKEEN: =A00x%04x\n"=
,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dmic_read(dmic, OMAP_DMIC_DMAWAK=
EEN));
>>> + =A0 =A0 =A0 dev_dbg(dmic->dev, "OMAP_DMIC_CTRL: =A00x%04x\n",
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dmic_read(dmic, OMAP_DMIC_CTRL))=
;
>>> + =A0 =A0 =A0 dev_dbg(dmic->dev, "OMAP_DMIC_DATA: =A00x%04x\n",
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dmic_read(dmic, OMAP_DMIC_DATA))=
;
>>> + =A0 =A0 =A0 dev_dbg(dmic->dev, "OMAP_DMIC_FIFO_CTRL: =A00x%04x\n"=
,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dmic_read(dmic, OMAP_DMIC_FIFO_C=
TRL));
>>> + =A0 =A0 =A0 dev_dbg(dmic->dev, "OMAP_DMIC_FIFO_DMIC1R_DATA: =A00x=
%08x\n",
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dmic_read(dmic, OMAP_DMIC_FIFO_D=
MIC1R_DATA));
>>> + =A0 =A0 =A0 dev_dbg(dmic->dev, "OMAP_DMIC_FIFO_DMIC1L_DATA: =A00x=
%08x\n",
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dmic_read(dmic, OMAP_DMIC_FIFO_D=
MIC1L_DATA));
>>> + =A0 =A0 =A0 dev_dbg(dmic->dev, "OMAP_DMIC_FIFO_DMIC2R_DATA: =A00x=
%08x\n",
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dmic_read(dmic, OMAP_DMIC_FIFO_D=
MIC2R_DATA));
>>> + =A0 =A0 =A0 dev_dbg(dmic->dev, "OMAP_DMIC_FIFO_DMIC2L_DATA: =A00x=
%08x\n",
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dmic_read(dmic, OMAP_DMIC_FIFO_D=
MIC2L_DATA));
>>> + =A0 =A0 =A0 dev_dbg(dmic->dev, "OMAP_DMIC_FIFO_DMIC3R_DATA: =A00x=
%08x\n",
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dmic_read(dmic, OMAP_DMIC_FIFO_D=
MIC3R_DATA));
>>> + =A0 =A0 =A0 dev_dbg(dmic->dev, "OMAP_DMIC_FIFO_DMIC3L_DATA: =A00x=
%08x\n",
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dmic_read(dmic, OMAP_DMIC_FIFO_D=
MIC3L_DATA));
>>> + =A0 =A0 =A0 dev_dbg(dmic->dev, "***********************\n");
>>> +}
>>> +#else
>>> +static void omap_dmic_reg_dump(struct omap_dmic *dmic) {}
>>> +#endif
>>
>> Would be better to make a debugfs layer ??
>
>I'll look in to what it would take to do this.  Could this be a
>feature to add later?

It could, but this omap_dmic_reg_dump() really doesn't look nice. And
you even have a #undef DEBUG on the top of the file, which will require
code change to actually make this one work.

>>> +static irqreturn_t omap_dmic_irq_handler(int irq, void *dev_id)
>>> +{
>>> + =A0 =A0 =A0 struct omap_dmic *dmic =3D dev_id;
>>> + =A0 =A0 =A0 u32 irq_status;
>>> +
>>> + =A0 =A0 =A0 irq_status =3D omap_dmic_read(dmic, OMAP_DMIC_IRQSTAT=
US);
>>> +
>>> + =A0 =A0 =A0 /* Acknowledge irq event */
>>> + =A0 =A0 =A0 omap_dmic_write(dmic, OMAP_DMIC_IRQSTATUS, irq_status=
);
>>> + =A0 =A0 =A0 if (irq_status & OMAP_DMIC_IRQ_FULL)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dmic->dev, "DMIC FIFO error %=
x\n", irq_status);
>>> +
>>> + =A0 =A0 =A0 if (irq_status & OMAP_DMIC_IRQ_EMPTY)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dmic->dev, "DMIC FIFO error %=
x\n", irq_status);
>>> +
>>> + =A0 =A0 =A0 if (irq_status & OMAP_DMIC_IRQ)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dmic->dev, "DMIC write reques=
t\n");
>>
>> no locking needed ??
>>
>>> +static int omap_dmic_dai_startup(struct snd_pcm_substream *substre=
am,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s=
truct snd_soc_dai *dai)
>>> +{
>>> + =A0 =A0 =A0 struct omap_dmic *dmic =3D snd_soc_dai_get_drvdata(da=
i);
>>> +
>>> + =A0 =A0 =A0 if (!dmic->active++)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_get_sync(dmic->dev);
>>> +
>>> + =A0 =A0 =A0 return 0;
>>> +}
>>> +
>>> +static void omap_dmic_dai_shutdown(struct snd_pcm_substream *subst=
ream,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 struct snd_soc_dai *dai)
>>> +{
>>> + =A0 =A0 =A0 struct omap_dmic *dmic =3D snd_soc_dai_get_drvdata(da=
i);
>>> +
>>> + =A0 =A0 =A0 if (!--dmic->active)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_put_sync(dmic->dev);
>>
>> I could be wrong but I believe pm_runtime implementation on OMAP has
>> its own refcounting, so you could drop the need for dmic->active.
>
>This was a included for a future use case where the driver would be
>accessed by the
>Audio Back End.  In this case, there are multiple DAI's associated to
>this driver and
>we need to keep track of the number of active DAI's and only cal
>pm_runtime_put_sync()
>when there are no others running.

Isn't it the same thing ?

DAI 0 -> omap_dmic_dai_startup() -> pm_runtime_get_sync() ->
dev->power.usage_count =3D 1

DAI 1 -> omap_dmic_dai_startup() -> pm_runtime_get_sync() ->
dev->power.usage_count =3D 2

DAI 2 -> omap_dmic_dai_startup() -> pm_runtime_get_sync() ->
dev->power.usage_count =3D 3

DAI 0 -> omap_dmic_dai_shutdown() -> pm_runtime_put_sync() ->
dev->power.usage_count =3D 2

and so on. Device will only be put in suspend again, when
dev->power.usage_count reaches zero.

>>> + =A0 =A0 =A0 ret =3D request_threaded_irq(dmic->irq, NULL, omap_dm=
ic_irq_handler,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
IRQF_ONESHOT, "DMIC", (void *)dmic);
>>
>> Does this need to be threaded ? Doesn't look like. Also, you don't n=
eed
>> the (void *) cast.
>
>This was originally not a threaded IRQ handler.  But in an internal
>review, it was
>suggested that this was the current trend in drivers and I should
>follow that course.
>I'm open to having it non-threaded.

Ok, no problem. But in this case you should have a non-threaded part
which will read the IRQ status register to verify we *do* have an IRQ
from this device and only in such case you will wake up the thread by
returning IRQ_WAKE_THREAD.

--=20
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
