From: "Lambert, David" <dlambert@ti.com>
Subject: Re: [PATCH v2 1/4] ASoC: DMIC: Adding the OMAP DMIC driver
Date: Fri, 7 Jan 2011 10:34:53 -0600
Message-ID: <AANLkTinraf3OO+exD=ScMf6opsRRW7Kopt1k7ZpEiiB2@mail.gmail.com>
References: <1294322439-16305-1-git-send-email-dlambert@ti.com>
 <1294322439-16305-2-git-send-email-dlambert@ti.com> <20110106222052.GC8408@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:48928 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754404Ab1AGQfO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Jan 2011 11:35:14 -0500
Received: by mail-qw0-f51.google.com with SMTP id 8so17962870qwj.38
        for <linux-omap@vger.kernel.org>; Fri, 07 Jan 2011 08:35:14 -0800 (PST)
In-Reply-To: <20110106222052.GC8408@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>

On Thu, Jan 6, 2011 at 4:20 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Thu, Jan 06, 2011 at 08:00:36AM -0600, David Lambert wrote:
>
>> @@ -103,6 +106,7 @@ config SND_OMAP_SOC_SDP4430
>> =A0 =A0 =A0 depends on TWL4030_CORE && SND_OMAP_SOC && MACH_OMAP_443=
0SDP
>> =A0 =A0 =A0 select SND_OMAP_SOC_MCPDM
>> =A0 =A0 =A0 select SND_SOC_TWL6040
>> + =A0 =A0 select SND_SOC_DMIC
>> =A0 =A0 =A0 help
>> =A0 =A0 =A0 =A0 Say Y if you want to add support for SoC audio on Te=
xas Instruments
>> =A0 =A0 =A0 =A0 SDP4430.
>
> Any tweaks to specific machines should be done separately to adding t=
he
> new drivers.

OK... I'll put that in to a separate patch.

>
>> + =A0 =A0 struct omap_dmic *dmic =3D snd_soc_dai_get_drvdata(dai);
>> + =A0 =A0 int ctrl, div_sel =3D -EINVAL;
>> +
>> + =A0 =A0 if (div_id !=3D OMAP_DMIC_CLKDIV)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>> +
>> + =A0 =A0 switch (dmic->clk_freq) {
>> + =A0 =A0 case 19200000:
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (div =3D=3D 5)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 div_sel =3D 0x1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 else if (div =3D=3D 8)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 div_sel =3D 0x0;
>
> I suggested switch statements previously; you didn't comment on my
> reply.
>

Sorry... my personal standard on when to go with a switch statement is
>2 choices,
I'll change it over to a switch...

>> +static irqreturn_t omap_dmic_irq_handler(int irq, void *dev_id)
>> +{
>> + =A0 =A0 struct omap_dmic *dmic =3D dev_id;
>
> My comments on this function appear to have been mostly ignored also.
>

Being as with this hardware, the IRQ handler really does nothing, I
think it best
if I just take it out for now.  It is useful in debugging cases to ensu=
re you're
moving data.  I'll just remove it.

>> + =A0 =A0 switch (rate) {
>> + =A0 =A0 case 192000:
>> + =A0 =A0 =A0 =A0 =A0 =A0 div =3D 5;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 div =3D 8;
>
> Shouldn't the default case be a case 96000?

The default case IS 96000 (only options for rate here are 96000 and
192000), isn't it?

>
>> + =A0 =A0 case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>
> Remove the empty cases, they're handled by the default.
>

OK

>> +
>> +MODULE_AUTHOR("David Lambert <dlambert@ti.com>");
>> +MODULE_DESCRIPTION("OMAP DMIC SoC Interface");
>> +MODULE_LICENSE("GPL");
>
> As also previously noted you should have a MODULE_ALIAS.

The MODULE_ALIAS is in there... just following example of the other dri=
vers
I looked at, it was placed above the platform_driver declaration.

+MODULE_ALIAS("platform:omap-dmic-dai");
+
+static struct platform_driver asoc_dmic_driver =3D {
+       .driver =3D {
+               .name =3D "omap-dmic-dai",
+               .owner =3D THIS_MODULE,
+       },
+       .probe =3D asoc_dmic_probe,
+       .remove =3D __devexit_p(asoc_dmic_remove),
+};

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
