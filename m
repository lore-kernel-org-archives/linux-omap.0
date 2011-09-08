From: Mans Rullgard <mans.rullgard@linaro.org>
Subject: Re: [PATCH] ASoC: omap: convert per-board modules to
 platform drivers
Date: Thu, 8 Sep 2011 16:41:30 +0100
Message-ID: <CAG5Tg6XxGP1YhQ0zW3f=1EkZfAmb9vj3pBemeSazpH1_CZ3OzQ@mail.gmail.com>
References: <1315494354-17597-1-git-send-email-mans.rullgard@linaro.org>
	<4E68DBF7.1030009@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <4E68DBF7.1030009@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linaro-dev@lists.linaro.org, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 8 September 2011 16:15, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 09/08/2011 05:05 PM, Mans Rullgard wrote:
>> This converts the per-board modules to platform drivers for a
>> device created by in main platform setup. =A0These drivers call
>> snd_soc_register_card() directly instead of going via a "soc-audio"
>> device and the corresponding driver in soc-core.
>>
>> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices=
.c
>> index 5b8ca68..7cb93d9 100644
>> --- a/arch/arm/mach-omap2/devices.c
>> +++ b/arch/arm/mach-omap2/devices.c
>> @@ -299,6 +299,11 @@ static struct platform_device omap_pcm =3D {
>> =A0 =A0 =A0 .id =A0 =A0 =3D -1,
>> =A0};
>>
>> +static struct platform_device omap_soc_audio =3D {
>> + =A0 =A0 .name =A0 =3D "omap-soc-audio",
>> + =A0 =A0 .id =A0 =A0 =3D -1,
>> +};
>> +
>> =A0/*
>> =A0 * OMAP2420 has 2 McBSP ports
>> =A0 * OMAP2430 has 5 McBSP ports
>> @@ -323,6 +328,7 @@ static void omap_init_audio(void)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 platform_device_register(&omap_mcbsp5);
>>
>> =A0 =A0 =A0 platform_device_register(&omap_pcm);
>> + =A0 =A0 platform_device_register(&omap_soc_audio);
>> =A0}
>>
>> =A0#else
>> diff --git a/sound/soc/omap/am3517evm.c b/sound/soc/omap/am3517evm.c
>> index 73dde4a..fcd18af 100644
>> --- a/sound/soc/omap/am3517evm.c
>> +++ b/sound/soc/omap/am3517evm.c
>> @@ -151,45 +151,60 @@ static struct snd_soc_card snd_soc_am3517evm =3D {
>> =A0 =A0 =A0 .num_links =3D 1,
>> =A0};
>>
>> [...]
>> +static struct platform_driver am3517evm_driver =3D {
>> + =A0 =A0 .driver =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "omap-soc-audio",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .owner =3D THIS_MODULE,
>> + =A0 =A0 },
>>
>> - =A0 =A0 return ret;
>> + =A0 =A0 .probe =3D am3517evm_soc_probe,
>> + =A0 =A0 .remove =3D __devexit_p(am3517evm_soc_remove),
>> +};
>> +[...]
>> +
>> +static struct platform_driver igep2_driver =3D {
>> + =A0 =A0 .driver =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "omap-soc-audio",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .owner =3D THIS_MODULE,
>> + =A0 =A0 },
>> +
>> + =A0 =A0 .probe =3D igep2_soc_probe,
>> + =A0 =A0 .remove =3D __devexit_p(igep2_soc_remove),
>> +};
>> [...]
>>
>> +static struct platform_driver n810_driver =3D {
>> + =A0 =A0 .driver =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "omap-soc-audio",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .owner =3D THIS_MODULE,
>> + =A0 =A0 },
>> +
>> + =A0 =A0 .probe =3D n810_soc_probe,
>> + =A0 =A0 .remove =3D __devexit_p(n810_soc_remove),
>> +};
>> [...]
>
> This isn't really any better then using the soc-core device, since all yo=
ur
> drivers are still named the same. udev still wouldn't know which one to l=
oad.
> Use different device driver names for different drivers.

I guess this worked by accident on my system.

Are there any other changes needed?

-- =

Mans Rullgard
Multimedia
mans.rullgard@linaro.org
