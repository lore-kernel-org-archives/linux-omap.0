From: Ricardo Neri <rneri@dextratech.com>
Subject: Re: [alsa-devel] [RESEND PATCH v3 2/5] ARM: OMAP4: Assign IDs to
 DSS HDMI devices
Date: Fri, 25 Jan 2013 10:23:49 -0600
Message-ID: <5102B195.5000801@dextratech.com>
References: <1357341987-3327-1-git-send-email-rneri@dextratech.com> <1357341987-3327-3-git-send-email-rneri@dextratech.com> <51029A30.7070903@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from spamfilter.dextratech.com ([187.141.251.67]:35509 "EHLO
	mail.dextratech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755926Ab3AYQXv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Jan 2013 11:23:51 -0500
In-Reply-To: <51029A30.7070903@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastien Guiriec <s-guiriec@ti.com>
Cc: tomi.valkeinen@ti.com, broonie@opensource.wolfsonmicro.com, liam.r.girdwood@intel.com, tony@atomide.com, peter.ujfalusi@ti.com, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, dzuniga@dextratech.com

Hi Sebastien,

On 01/25/2013 08:44 AM, Sebastien Guiriec wrote:
> Hi Ricardo,
>
> You need to rebase this patch as the code has been moved to dss-common.c
> file now. So it would not apply.

Thanks! I will send a new rebased version.

Ricardo
>
> Sebastien
>
> On 01/05/2013 12:26 AM, Ricardo Neri wrote:
>> While Pandaboard and SDP4430 have only one HDMI output connector, it
>> may be
>> possible that future boards and SoCs support more than one HDMI output.
>> Thus, we define the identifier of the device. This is used by display
>> common code to identify and create the platform devices for HDMI audio
>> drivers.
>>
>> Signed-off-by: Ricardo Neri <rneri@dextratech.com>
>> ---
>>   arch/arm/mach-omap2/board-4430sdp.c    |    3 +++
>>   arch/arm/mach-omap2/board-omap4panda.c |    3 +++
>>   2 files changed, 6 insertions(+)
>>
>> diff --git a/arch/arm/mach-omap2/board-4430sdp.c
>> b/arch/arm/mach-omap2/board-4430sdp.c
>> index 3669c12..5a486d9 100644
>> --- a/arch/arm/mach-omap2/board-4430sdp.c
>> +++ b/arch/arm/mach-omap2/board-4430sdp.c
>> @@ -666,6 +666,9 @@ static struct omap_dss_device sdp4430_hdmi_device = {
>>       .type = OMAP_DISPLAY_TYPE_HDMI,
>>       .channel = OMAP_DSS_CHANNEL_DIGIT,
>>       .data = &sdp4430_hdmi_data,
>> +    .dev = {
>> +        .id = -1,
>> +    },
>>   };
>>
>>   static struct picodlp_panel_data sdp4430_picodlp_pdata = {
>> diff --git a/arch/arm/mach-omap2/board-omap4panda.c
>> b/arch/arm/mach-omap2/board-omap4panda.c
>> index bfcd397..9f336a3 100644
>> --- a/arch/arm/mach-omap2/board-omap4panda.c
>> +++ b/arch/arm/mach-omap2/board-omap4panda.c
>> @@ -440,6 +440,9 @@ static struct omap_dss_device
>> omap4_panda_hdmi_device = {
>>       .type = OMAP_DISPLAY_TYPE_HDMI,
>>       .channel = OMAP_DSS_CHANNEL_DIGIT,
>>       .data = &omap4_panda_hdmi_data,
>> +    .dev = {
>> +        .id = -1,
>> +    },
>>   };
>>
>>   static struct omap_dss_device *omap4_panda_dss_devices[] = {
>>
>

