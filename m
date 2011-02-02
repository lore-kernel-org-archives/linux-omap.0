From: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>
Subject: Re: [PATCH v2 13/13] OMAP: hwmod: Removal of macros for data that is
 obtained from hwmod database
Date: Wed, 2 Feb 2011 11:45:25 +0530
Message-ID: <AANLkTi=CiA5hHbBgGFbER2u37vW2_pFbQ+x98wpVL-HM@mail.gmail.com>
References: <1296485437-12806-1-git-send-email-kishon@ti.com>
	<1296485437-12806-14-git-send-email-kishon@ti.com>
	<20110201200713.34fdb4fc.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:38544 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752421Ab1BBGP0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 Feb 2011 01:15:26 -0500
Received: by mail-iy0-f169.google.com with SMTP id 17so7086827iyj.14
        for <linux-omap@vger.kernel.org>; Tue, 01 Feb 2011 22:15:25 -0800 (PST)
In-Reply-To: <20110201200713.34fdb4fc.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com, paul@pwsan.com, charu@ti.com, shubhrajyoti@ti.com, b-cousson@ti.com, khilman@deeprootsystems.com, p-basak2@ti.com

On Tue, Feb 1, 2011 at 11:37 PM, Jarkko Nikula <jhnikula@gmail.com> wro=
te:
> On Mon, 31 Jan 2011 20:20:37 +0530
> Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
>> Information like base address and DMA channel nubers should no longe=
r
>> be obtained using macros. These information should be obtained from
>> hwmod database. Hence the macros that define the base address are re=
moved.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> Signed-off-by: Charulatha V <charu@ti.com>
>> ---
>> =A0arch/arm/mach-omap1/mcbsp.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 64 ++++=
+++++++++++---------------
>> =A0arch/arm/plat-omap/include/plat/mcbsp.h | =A0 50 +---------------=
--------
>> =A02 files changed, 33 insertions(+), 81 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap1/mcbsp.c b/arch/arm/mach-omap1/mcbsp=
=2Ec
>> index 2b89ebd..d90f649 100644
>> --- a/arch/arm/mach-omap1/mcbsp.c
>> +++ b/arch/arm/mach-omap1/mcbsp.c
>> @@ -83,14 +83,14 @@ struct resource omap7xx_mcbsp_res[][6] =3D {
>> =A0 =A0 =A0 {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0=3D "mpu",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .start =3D OMAP7XX_MCBSP1_=
BASE,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .end =A0 =3D OMAP7XX_MCBSP=
1_BASE + SZ_256,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .start =3D 0xfffb1000,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .end =A0 =3D 0xfffb10ff,
>
> For these changes I don't see immediate reason as they reduce
> readability.

 Maybe I should leave without modifying these resources. The main
purpose of doing this
  is to remove macros defined in mcbsp.h so that the client drivers
don't use it directly.

>Is this better to do outside of this set together with a
> patch that adds these into hwmod database etc?

 OMAP1 does not have hwmod database.

>
>> -#define AUDIO_MCBSP_DATAWRITE =A0 =A0 =A0 =A0(OMAP1510_MCBSP1_BASE =
+ OMAP_MCBSP_REG_DXR1)
>> -#define AUDIO_MCBSP_DATAREAD (OMAP1510_MCBSP1_BASE + OMAP_MCBSP_REG=
_DRR1)
>> -
>> -#define AUDIO_MCBSP =A0 =A0 =A0 =A0 =A0OMAP_MCBSP1
>> -#define AUDIO_DMA_TX =A0 =A0 =A0 =A0 OMAP_DMA_MCBSP1_TX
>> -#define AUDIO_DMA_RX =A0 =A0 =A0 =A0 OMAP_DMA_MCBSP1_RX
>> -
>> =A0#else
>>
>> =A0#define OMAP_MCBSP_REG_DRR2 =A00x00
>> @@ -177,13 +136,6 @@ static struct platform_device omap_mcbsp##port_=
nr =3D { =A0 =A0\
>> =A0#define OMAP_ST_REG_SFIRCR =A0 0x28
>> =A0#define OMAP_ST_REG_SSELCR =A0 0x2C
>>
>> -#define AUDIO_MCBSP_DATAWRITE =A0 =A0 =A0 =A0(OMAP24XX_MCBSP2_BASE =
+ OMAP_MCBSP_REG_DXR1)
>> -#define AUDIO_MCBSP_DATAREAD (OMAP24XX_MCBSP2_BASE + OMAP_MCBSP_REG=
_DRR1)
>> -
>> -#define AUDIO_MCBSP =A0 =A0 =A0 =A0 =A0OMAP_MCBSP2
>> -#define AUDIO_DMA_TX =A0 =A0 =A0 =A0 OMAP24XX_DMA_MCBSP2_TX
>> -#define AUDIO_DMA_RX =A0 =A0 =A0 =A0 OMAP24XX_DMA_MCBSP2_RX
>> -
> These looks things that can be removed immediately and independently
> from this set.

  ok.

>
> --
> Jarkko
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
