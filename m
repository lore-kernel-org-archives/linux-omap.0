From: "shekhar, chandra" <x0044955@ti.com>
Subject: Re: [PATCH] ARM: OMAP3: Initialize XCCR and RCCR McBSP registersfor McBSP DAI driver
Date: Thu, 18 Dec 2008 20:47:05 +0530
Message-ID: <0a0b01c96123$b1d0ca90$LocalHost@wipultra806>
References: <2C7D3DF36ADFFC479B44490D912B616705A484A4C7@dlee07.ent.ti.com> <20081218134137.GD30366@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39164 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750762AbYLRPRT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Dec 2008 10:17:19 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "Lopez Cruz, Misael" <x0052729@ti.com>
Cc: linux-omap@vger.kernel.org, "Pandita, Vikram" <vikram.pandita@ti.com>


----- Original Message ----- 
From: "Tony Lindgren" <tony@atomide.com>
To: "Lopez Cruz, Misael" <x0052729@ti.com>
Cc: <linux-omap@vger.kernel.org>; "Pandita, Vikram" <vikram.pandita@ti.com>
Sent: Thursday, December 18, 2008 7:11 PM
Subject: Re: [PATCH] ARM: OMAP3: Initialize XCCR and RCCR McBSP registersfor 
McBSP DAI driver


> Hi,
>
> * Lopez Cruz, Misael <x0052729@ti.com> [081218 12:16]:
>> This patch enables XCCR and RCCR McBSP register writing in OMAP 24xx/34xx
>> platforms. It also explicitly initializes those registers to their default
>> values in ASoC McBSP DAI driver.
>
> Can you please describe a bit what these registers do? It's impossible
> for anybody to decipher without looking at the TRM right now.
>
>> Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>
>> ---
>>  arch/arm/plat-omap/include/mach/mcbsp.h |    6 ++++++
>>  arch/arm/plat-omap/mcbsp.c              |    4 ++++
>>  sound/soc/omap/omap-mcbsp.c             |    4 ++++
>>  3 files changed, 14 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/include/mach/mcbsp.h 
>> b/arch/arm/plat-omap/include/mach/mcbsp.h
>> index 6a0d1a0..5885f3a 100644
>> --- a/arch/arm/plat-omap/include/mach/mcbsp.h
>> +++ b/arch/arm/plat-omap/include/mach/mcbsp.h
>> @@ -231,11 +231,16 @@
>>  #define XPBBLK(value) ((value)<<7) /* Bits 7:8 */
>>
>>  /*********************** McBSP XCCR bit definitions 
>> *************************/
>> +#define EXTCLKGATE 0x8000
>> +#define PPCONNECT 0x4000
>> +#define DXENDLY(value) ((value)<<12) /* Bits 12:13 */
>> +#define XFULL_CYCLE 0x0800
>>  #define DILB 0x0020
>>  #define XDMAEN 0x0008
>>  #define XDISABLE 0x0001
>>
>>  /********************** McBSP RCCR bit definitions 
>> *************************/
>> +#define RFULL_CYCLE 0x0800
>>  #define RDMAEN 0x0008
>>  #define RDISABLE 0x0001
>>
>> @@ -267,6 +271,8 @@ struct omap_mcbsp_reg_cfg {
>>  u16 rcerh;
>>  u16 xcerg;
>>  u16 xcerh;
>> + u16 xccr;
>> + u16 rccr;
>>  };
>>

i believe these  register width should be defined as 32 bits instead of 16, 
while read/write function will take care 16 or 32 bit write
depending on cpu.

>>  typedef enum {
>> diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
>> index af33fc7..d71b30b 100644
>> --- a/arch/arm/plat-omap/mcbsp.c
>> +++ b/arch/arm/plat-omap/mcbsp.c
>> @@ -173,6 +173,10 @@ void omap_mcbsp_config(unsigned int id, const struct 
>> omap_mcbsp_reg_cfg *config)
>>  OMAP_MCBSP_WRITE(io_base, MCR2, config->mcr2);
>>  OMAP_MCBSP_WRITE(io_base, MCR1, config->mcr1);
>>  OMAP_MCBSP_WRITE(io_base, PCR0, config->pcr0);
>> + if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
>> + OMAP_MCBSP_WRITE(io_base, XCCR, config->xccr);
>> + OMAP_MCBSP_WRITE(io_base, RCCR, config->rccr);
>> + }
>>  }
>>  EXPORT_SYMBOL(omap_mcbsp_config);
>>
>
> You can do the above with cpu_class_is_omap2() instead. Might be worth
> checking that these registers are available on 2420 too.
>
>> diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
>> index 8485a8a..2e7000d 100644
>> --- a/sound/soc/omap/omap-mcbsp.c
>> +++ b/sound/soc/omap/omap-mcbsp.c
>> @@ -295,6 +295,10 @@ static int omap_mcbsp_dai_set_dai_fmt(struct snd_soc_dai 
>> *cpu_dai,
>>  regs->spcr1 |= RINTM(3);
>>  regs->rcr2 |= RFIG;
>>  regs->xcr2 |= XFIG;
>> + if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
>> + regs->xccr = DXENDLY(1) | XDMAEN;
>> + regs->rccr = RFULL_CYCLE | RDMAEN;
>> + }
>>
>>  switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
>>  case SND_SOC_DAIFMT_I2S:
>> -- 
>
> I agree with Jarkko's comment, the ASoC change should go via alsa list
> as a separate patch.
>
> Regards,
>
> Tony
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

