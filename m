From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH 05/19] OMAPDSS: Kconfig: Add depencies and help section
 to OMAP4_DSS_HDMI_AUDIO
Date: Fri, 16 May 2014 14:56:48 +0300
Message-ID: <5375FD00.20004@ti.com>
References: <cover.1399884780.git.jsarha@ti.com> <198496d6220a13b0e8910361d969b8f978ee1398.1399884780.git.jsarha@ti.com> <5375EE07.4090802@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52864 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753295AbaEPL46 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 May 2014 07:56:58 -0400
In-Reply-To: <5375EE07.4090802@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, bcousson@baylibre.com, detheridge@ti.com

On 05/16/2014 01:52 PM, Tomi Valkeinen wrote:
> Hi,
>
> On 12/05/14 12:12, Jyri Sarha wrote:
>> Signed-off-by: Jyri Sarha <jsarha@ti.com>
>> ---
>>   drivers/video/fbdev/omap2/dss/Kconfig |   10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/video/fbdev/omap2/dss/Kconfig b/drivers/video/fbdev/omap2/dss/Kconfig
>> index 8921a7a..ecc2f50 100644
>> --- a/drivers/video/fbdev/omap2/dss/Kconfig
>> +++ b/drivers/video/fbdev/omap2/dss/Kconfig
>> @@ -70,7 +70,15 @@ config OMAP4_DSS_HDMI
>>   	  HDMI support for OMAP4 based SoCs.
>>
>>   config OMAP4_DSS_HDMI_AUDIO
>> -	bool
>> +	bool "HDMI audio support for OMAP4"
>> +	depends on OMAP4_DSS_HDMI
>> +	depends on SND_OMAP_SOC=y || OMAP2_DSS = SND_OMAP_SOC
>> +	default y
>> +	help
>> +	  HDMI audio support for OMAP4 based SoCs. Adds integrated
>> +	  ASoC Digital Audio Interface component driver into OMAPDSS
>> +	  module. Select SND_SOC_HDMI_CODEC and SND_SIMPLE_CARD with
>> +	  devicetree description for full HDMI audio support.
>
> What does "for full HDMI audio support" mean? What's the partial support? =)
>

The hdmi driver provides a digital audio interface (DAI) which can be 
used to transmit audio over the HDMI cable. The ASoC DAI component 
driver provides just that functionality. A machine, platform, and (in 
this case a dummy) codec component driver is also needed for a complete 
ALSA device functionality.

Anyway, I look into Mark's suggestion of instantiating all the necessary 
component drivers from the HDMI driver.

Best regards,
Jyri
