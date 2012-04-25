From: Ricardo Neri <ricardo.neri@ti.com>
Subject: Re: [PATCH 05/10] OMAPDSS: HDMI: Decouple HDMI audio from ASoC
Date: Tue, 24 Apr 2012 22:44:13 -0500
Message-ID: <4F97730D.7020707@ti.com>
References: <1332974305-4578-1-git-send-email-ricardo.neri@ti.com>  <1332974305-4578-6-git-send-email-ricardo.neri@ti.com> <1335187509.1535.37.camel@lappy>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47617 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758144Ab2DYDoS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Apr 2012 23:44:18 -0400
In-Reply-To: <1335187509.1535.37.camel@lappy>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: mythripk@ti.com, s-chereau@ti.com, x0055901@ti.com, vaibhav.bedia@ti.com, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com, agraf@suse.de, research@ottomaneng.com, linux-omap@vger.kernel.org

On 04/23/2012 08:25 AM, Tomi Valkeinen wrote:
> On Wed, 2012-03-28 at 16:38 -0600, Ricardo Neri wrote:
>> Instead of having OMAPDSS HDMI audio functionality depending on the
>> ASoC HDMI audio driver, use a new config option so that
>> potential users, including ASoC,  may select if needed.
>>
>> Signed-off-by: Ricardo Neri<ricardo.neri@ti.com>
>> ---
>>   drivers/video/omap2/dss/Kconfig           |    4 ++++
>>   drivers/video/omap2/dss/dss_features.c    |    3 +--
>>   drivers/video/omap2/dss/ti_hdmi.h         |    6 ++----
>>   drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |    3 +--
>>   drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h |    5 +----
>>   5 files changed, 9 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/video/omap2/dss/Kconfig b/drivers/video/omap2/dss/Kconfig
>> index 7be7c06..b492001 100644
>> --- a/drivers/video/omap2/dss/Kconfig
>> +++ b/drivers/video/omap2/dss/Kconfig
>> @@ -68,6 +68,10 @@ config OMAP4_DSS_HDMI
>>   	  HDMI Interface. This adds the High Definition Multimedia Interface.
>>   	  See http://www.hdmi.org/ for HDMI specification.
>>
>> +config OMAP4_DSS_HDMI_AUDIO
>> +	bool
>> +	depends on OMAP4_DSS_HDMI
>> +
>>   config OMAP2_DSS_SDI
>>   	bool "SDI support"
>>   	depends on ARCH_OMAP3
>> diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
>> index c1839e2..399a28a 100644
>> --- a/drivers/video/omap2/dss/dss_features.c
>> +++ b/drivers/video/omap2/dss/dss_features.c
>> @@ -497,8 +497,7 @@ static const struct ti_hdmi_ip_ops omap4_hdmi_functions = {
>>   	.dump_core		=	ti_hdmi_4xxx_core_dump,
>>   	.dump_pll		=	ti_hdmi_4xxx_pll_dump,
>>   	.dump_phy		=	ti_hdmi_4xxx_phy_dump,
>> -#if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
>> -	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
>> +#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
>>   	.audio_enable		=       ti_hdmi_4xxx_wp_audio_enable,
>>   	.audio_start		=       ti_hdmi_4xxx_audio_start,
>>   #endif
>> diff --git a/drivers/video/omap2/dss/ti_hdmi.h b/drivers/video/omap2/dss/ti_hdmi.h
>> index 529e227..211da6f 100644
>> --- a/drivers/video/omap2/dss/ti_hdmi.h
>> +++ b/drivers/video/omap2/dss/ti_hdmi.h
>> @@ -110,8 +110,7 @@ struct ti_hdmi_ip_ops {
>>
>>   	void (*dump_phy)(struct hdmi_ip_data *ip_data, struct seq_file *s);
>>
>> -#if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
>> -	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
>> +#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
>>   	void (*audio_enable)(struct hdmi_ip_data *ip_data, bool start);
>>
>>   	void (*audio_start)(struct hdmi_ip_data *ip_data, bool start);
>> @@ -145,8 +144,7 @@ void ti_hdmi_4xxx_wp_dump(struct hdmi_ip_data *ip_data, struct seq_file *s);
>>   void ti_hdmi_4xxx_pll_dump(struct hdmi_ip_data *ip_data, struct seq_file *s);
>>   void ti_hdmi_4xxx_core_dump(struct hdmi_ip_data *ip_data, struct seq_file *s);
>>   void ti_hdmi_4xxx_phy_dump(struct hdmi_ip_data *ip_data, struct seq_file *s);
>> -#if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
>> -	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
>> +#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
>>   void ti_hdmi_4xxx_wp_audio_enable(struct hdmi_ip_data *ip_data, bool enable);
>>   void ti_hdmi_4xxx_audio_start(struct hdmi_ip_data *ip_data, bool enable);
>>   #endif
>> diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
>> index e6fa61d..e06139a 100644
>> --- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
>> +++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
>> @@ -1030,8 +1030,7 @@ void ti_hdmi_4xxx_phy_dump(struct hdmi_ip_data *ip_data, struct seq_file *s)
>>   	DUMPPHY(HDMI_TXPHY_PAD_CFG_CTRL);
>>   }
>>
>> -#if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
>> -	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
>> +#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
>>   void hdmi_wp_audio_config_format(struct hdmi_ip_data *ip_data,
>>   					struct hdmi_audio_format *aud_fmt)
>>   {
>> diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
>> index 9fa5cb1..222cc16 100644
>> --- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
>> +++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
>> @@ -26,8 +26,6 @@
>>   #include "ti_hdmi.h"
>>   #if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
>>   	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
>> -#include<sound/soc.h>
>> -#include<sound/pcm_params.h>
>
> Unrelated change. And... is there something wrong with this? Shouldn't
> the defines above be changed?
Yes. The defines should have changed. I will also remove the #includes 
in a separate patch.

BR,
Ricardo
>
>   Tomi

