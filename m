From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v3 5/7] ARM: DRA7: hwmod: Add SYSCONFIG for usb_otg_ss
Date: Wed, 18 Jun 2014 16:49:56 +0530
Message-ID: <53A175DC.8080709@ti.com>
References: <1399283686-6127-1-git-send-email-rogerq@ti.com> <1399283686-6127-6-git-send-email-rogerq@ti.com> <53A173A5.7020509@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44824 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965421AbaFRLWT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Jun 2014 07:22:19 -0400
In-Reply-To: <53A173A5.7020509@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: kishon@ti.com, tony@atomide.com, balbi@ti.com, bcousson@baylibre.com, "Menon, Nishanth" <nm@ti.com>, george.cherian@ti.com, sergei.shtylyov@cogentembedded.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-usb@vger.kernel.org, Paul Walmsley <paul@pwsan.com>

On Wednesday 18 June 2014 04:40 PM, Roger Quadros wrote:
> + Nishant and Rajendra for review.
> 
> On 05/05/2014 12:54 PM, Roger Quadros wrote:
>> Add the sysconfig class bits for the Super Speed USB
>> controllers
>>
>> CC: Paul Walmsley <paul@pwsan.com>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>

verified against TRM version vP, looks good to me.
Reviewed-by: Rajendra Nayak <rnayak@ti.com>

>> ---
>>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
>> index 810c205..067d322 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
>> @@ -1731,8 +1731,20 @@ static struct omap_hwmod dra7xx_uart6_hwmod = {
>>   *
>>   */
>>  
>> +static struct omap_hwmod_class_sysconfig dra7xx_usb_otg_ss_sysc = {
>> +	.rev_offs	= 0x0000,
>> +	.sysc_offs	= 0x0010,
>> +	.sysc_flags	= (SYSC_HAS_DMADISABLE | SYSC_HAS_MIDLEMODE |
>> +			   SYSC_HAS_SIDLEMODE),
>> +	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
>> +			   SIDLE_SMART_WKUP | MSTANDBY_FORCE | MSTANDBY_NO |
>> +			   MSTANDBY_SMART | MSTANDBY_SMART_WKUP),
>> +	.sysc_fields	= &omap_hwmod_sysc_type2,
>> +};
>> +
>>  static struct omap_hwmod_class dra7xx_usb_otg_ss_hwmod_class = {
>>  	.name	= "usb_otg_ss",
>> +	.sysc	= &dra7xx_usb_otg_ss_sysc,
>>  };
>>  
>>  /* usb_otg_ss1 */
>>
> 

