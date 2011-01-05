From: "Lambert, David" <dlambert@ti.com>
Subject: Re: [PATCH 1/5] ASoC: DMIC: Adding the OMAP DMIC driver
Date: Wed, 5 Jan 2011 07:56:13 -0600
Message-ID: <AANLkTi=k981bx0jjWhJdZmxY8-Uyt=KSB4v0E-uKQ_pL@mail.gmail.com>
References: <1293509826-23253-1-git-send-email-dlambert@ti.com>
 <1293509826-23253-2-git-send-email-dlambert@ti.com> <20101228141759.GA31883@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:38702 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751005Ab1AEN4t convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Jan 2011 08:56:49 -0500
Received: by mail-gx0-f176.google.com with SMTP id 4so6861690gxk.35
        for <linux-omap@vger.kernel.org>; Wed, 05 Jan 2011 05:56:49 -0800 (PST)
In-Reply-To: <20101228141759.GA31883@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>

Mark,

On Tue, Dec 28, 2010 at 8:18 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, Dec 27, 2010 at 10:17:02PM -0600, David Lambert wrote:
>
>> + =A0 =A0 case 19200000:
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (div =3D=3D 5)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 div_sel =3D 0x1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 else if (div =3D=3D 8)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 div_sel =3D 0x0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>
> A switch statement for the valid div values would feel more natural,
> together with a default case to report errors though that's handled
> below so could be skipped.
>
>> + =A0 =A0 /* Acknowledge irq event */
>> + =A0 =A0 omap_dmic_write(dmic, OMAP_DMIC_IRQSTATUS, irq_status);
>> + =A0 =A0 if (irq_status & OMAP_DMIC_IRQ_FULL)
>
> Blank line between these two.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dmic->dev, "DMIC FIFO error %x\n",=
 irq_status);
>> +
>> + =A0 =A0 if (irq_status & OMAP_DMIC_IRQ_EMPTY)
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dmic->dev, "DMIC FIFO error %x\n",=
 irq_status);
>
> I'd expect these errors to be displayed by default.
>
>> + =A0 =A0 if (irq_status & OMAP_DMIC_IRQ)
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dmic->dev, "DMIC write request\n")=
;
>
> A comment explaining why we don't actually do anything with the reque=
st
> would be helpful. =A0Given that we're ignoring the event it'd seem be=
tter
> to just leave it masked and not take the interrupt in the first place=
=2E

Since the IRQ handler isn't really doing anything in this driver,
would it better
to just not have one?

>
>> +static int omap_dmic_dai_startup(struct snd_pcm_substream *substrea=
m,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct=
 snd_soc_dai *dai)
>> +{
>> + =A0 =A0 struct omap_dmic *dmic =3D snd_soc_dai_get_drvdata(dai);
>> +
>> + =A0 =A0 if (!dmic->active++)
>> + =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_get_sync(dmic->dev);
>
> The pm_runtime API does refcounting for you so you should be able to
> just skip the active count check here, IIRC there's a pm_runtime API =
you
> could use to query if the DMIC is enabled so you could skip the local
> refcount entirely.
>

I haven't been able to find a an API to query it, but I could just
reference the count
directly with dmic->dev->power.usage_count.

>> +static int omap_dmic_dai_hw_free(struct snd_pcm_substream *substrea=
m,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct=
 snd_soc_dai *dai)
>> +{
>> + =A0 =A0 struct omap_dmic *dmic =3D snd_soc_dai_get_drvdata(dai);
>> + =A0 =A0 struct omap_dmic_link *link =3D dmic->link;
>> + =A0 =A0 int ret =3D 0;
>> +
>> + =A0 =A0 if (dmic->active =3D=3D 1) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D omap_dmic_close(dmic);
>> + =A0 =A0 =A0 =A0 =A0 =A0 link->channels =3D 0;
>> + =A0 =A0 }
>
> I'd feel a bit more happy if this were done in the same place as the
> drop of the refcount though this should actually be OK I think.
>
>> + =A0 =A0 switch (freq) {
>> + =A0 =A0 case 19200000:
>> + =A0 =A0 case 24000000:
>> + =A0 =A0 case 24576000:
>> + =A0 =A0 case 12000000:
>> + =A0 =A0 =A0 =A0 =A0 =A0 dmic->clk_freq =3D freq;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dai->dev, "clk freq not supported =
%d\n", freq);
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_freq;
>> + =A0 =A0 }
>
> Can't you ask the parent clock what rate it's set to?
>

Didn't really think there was a need for that on the audio driver.
There are clock API's available
to query that already.

>> + =A0 =A0 ret =3D request_threaded_irq(dmic->irq, NULL, omap_dmic_ir=
q_handler,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0IRQ=
=46_ONESHOT, "DMIC", (void *)dmic);
>> + =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dmic->dev, "irq request failed\n")=
;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_irq;
>> + =A0 =A0 }
>
> Does this really need to be a threaded IRQ - the IRQ was just reading
> from CPU registers as far as I remember?
>
>> +MODULE_AUTHOR("David Lambert <dlambert@ti.com>");
>> +MODULE_DESCRIPTION("OMAP DMIC SoC Interface");
>> +MODULE_LICENSE("GPL");
>
> Should have a MODULE_ALIAS too in case it gets built modular.
>

--
David Lambert
OMAP=99 Multimedia
214-567-5692
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
