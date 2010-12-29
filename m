From: "Lambert, David" <dlambert@ti.com>
Subject: Re: [PATCH 3/5] ASoC: DMIC: Adding OMAP DMIC driver to build
Date: Tue, 28 Dec 2010 20:21:25 -0600
Message-ID: <AANLkTimRCcBi=FE4h3Daa=zMdmXATLPqM48KNRN8x159@mail.gmail.com>
References: <1293509826-23253-1-git-send-email-dlambert@ti.com>
 <1293509826-23253-4-git-send-email-dlambert@ti.com> <20101228114000.GD31292@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:52851 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751428Ab0L2CVq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Dec 2010 21:21:46 -0500
Received: by yxl31 with SMTP id 31so5089963yxl.4
        for <linux-omap@vger.kernel.org>; Tue, 28 Dec 2010 18:21:45 -0800 (PST)
In-Reply-To: <20101228114000.GD31292@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>

On Tue, Dec 28, 2010 at 5:40 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, Dec 27, 2010 at 10:17:04PM -0600, David Lambert wrote:
>> Adds the OMAP DMIC driver and codec to the build.
>>
>> Signed-off-by: David Lambert <dlambert@ti.com>
>> ---
>> =A0sound/soc/codecs/Kconfig =A0| =A0 =A03 +++
>> =A0sound/soc/codecs/Makefile | =A0 =A02 ++
>> =A0sound/soc/omap/Kconfig =A0 =A0| =A0 =A05 +++++
>> =A0sound/soc/omap/Makefile =A0 | =A0 =A02 ++
>
> This should be one of the last patches in the series, but given the s=
ort
> of drivers you're introducing I'd expect the drivers to just directly
> add the build system stuff in the patch.
>

OK... I can put the makefile and kconfig changes in with the DMIC drive=
r and the
DMIC codec.

>> =A04 files changed, 12 insertions(+), 0 deletions(-)
>>
>> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
>> index 0f33db2..f6c6d31 100644
>> --- a/sound/soc/codecs/Kconfig
>> +++ b/sound/soc/codecs/Kconfig
>> @@ -166,6 +166,9 @@ config SND_SOC_L3
>> =A0config SND_SOC_DA7210
>> =A0 =A0 =A0 =A0 =A0tristate
>>
>> +config SND_SOC_DMIC
>> + =A0 =A0 tristate
>> +
>> =A0config SND_SOC_MAX98088
>> =A0 =A0 =A0 =A0 tristate
>>
>> diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
>> index 10e5e09..9139cf9 100644
>> --- a/sound/soc/codecs/Makefile
>> +++ b/sound/soc/codecs/Makefile
>> @@ -14,6 +14,7 @@ snd-soc-cs42l51-objs :=3D cs42l51.o
>> =A0snd-soc-cs4270-objs :=3D cs4270.o
>> =A0snd-soc-cx20442-objs :=3D cx20442.o
>> =A0snd-soc-da7210-objs :=3D da7210.o
>> +snd-soc-dmic-objs :=3D dmic.o
>> =A0snd-soc-l3-objs :=3D l3.o
>> =A0snd-soc-max98088-objs :=3D max98088.o
>> =A0snd-soc-pcm3008-objs :=3D pcm3008.o
>> @@ -91,6 +92,7 @@ obj-$(CONFIG_SND_SOC_CS42L51) =A0 =A0 =A0 +=3D snd=
-soc-cs42l51.o
>> =A0obj-$(CONFIG_SND_SOC_CS4270) +=3D snd-soc-cs4270.o
>> =A0obj-$(CONFIG_SND_SOC_CX20442) =A0 =A0 =A0 =A0+=3D snd-soc-cx20442=
=2Eo
>> =A0obj-$(CONFIG_SND_SOC_DA7210) +=3D snd-soc-da7210.o
>> +obj-$(CONFIG_SND_SOC_DMIC) =A0 +=3D snd-soc-dmic.o
>> =A0obj-$(CONFIG_SND_SOC_L3) =A0 =A0 +=3D snd-soc-l3.o
>> =A0obj-$(CONFIG_SND_SOC_JZ4740_CODEC) =A0 +=3D snd-soc-jz4740-codec.=
o
>> =A0obj-$(CONFIG_SND_SOC_MAX98088) =A0 =A0 =A0 +=3D snd-soc-max98088.=
o
>> diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
>> index a088db6..548b13c 100644
>> --- a/sound/soc/omap/Kconfig
>> +++ b/sound/soc/omap/Kconfig
>> @@ -9,6 +9,9 @@ config SND_OMAP_SOC_MCBSP
>> =A0config SND_OMAP_SOC_MCPDM
>> =A0 =A0 =A0 tristate
>>
>> +config SND_OMAP_SOC_DMIC
>> + =A0 =A0 tristate
>> +
>> =A0config SND_OMAP_SOC_N810
>> =A0 =A0 =A0 tristate "SoC Audio support for Nokia N810"
>> =A0 =A0 =A0 depends on SND_OMAP_SOC && MACH_NOKIA_N810 && I2C
>> @@ -103,6 +106,8 @@ config SND_OMAP_SOC_SDP4430
>> =A0 =A0 =A0 depends on TWL4030_CORE && SND_OMAP_SOC && MACH_OMAP_443=
0SDP
>> =A0 =A0 =A0 select SND_OMAP_SOC_MCPDM
>> =A0 =A0 =A0 select SND_SOC_TWL6040
>> + =A0 =A0 select SND_SOC_DMIC
>> + =A0 =A0 select SND_OMAP_SOC_DMIC
>> =A0 =A0 =A0 help
>> =A0 =A0 =A0 =A0 Say Y if you want to add support for SoC audio on Te=
xas Instruments
>> =A0 =A0 =A0 =A0 SDP4430.
>> diff --git a/sound/soc/omap/Makefile b/sound/soc/omap/Makefile
>> index ba9fc65..6ff27f5 100644
>> --- a/sound/soc/omap/Makefile
>> +++ b/sound/soc/omap/Makefile
>> @@ -1,9 +1,11 @@
>> =A0# OMAP Platform Support
>> =A0snd-soc-omap-objs :=3D omap-pcm.o
>> +snd-soc-omap-dmic-objs :=3D omap-dmic.o
>> =A0snd-soc-omap-mcbsp-objs :=3D omap-mcbsp.o
>> =A0snd-soc-omap-mcpdm-objs :=3D omap-mcpdm.o mcpdm.o
>>
>> =A0obj-$(CONFIG_SND_OMAP_SOC) +=3D snd-soc-omap.o
>> +obj-$(CONFIG_SND_OMAP_SOC_DMIC) +=3D snd-soc-omap-dmic.o
>> =A0obj-$(CONFIG_SND_OMAP_SOC_MCBSP) +=3D snd-soc-omap-mcbsp.o
>> =A0obj-$(CONFIG_SND_OMAP_SOC_MCPDM) +=3D snd-soc-omap-mcpdm.o
>>
>> --
>> 1.7.0.4
>>
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
