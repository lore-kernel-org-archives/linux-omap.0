From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [PATCH 1/1] ARM: OMAP2+: pdata-quirks: add legacy display init
 for IGEPv2 board
Date: Wed, 09 Oct 2013 09:44:11 +0200
Message-ID: <5255094B.2060207@collabora.co.uk>
References: <1380941496-26899-1-git-send-email-javier.martinez@collabora.co.uk> <5254F0ED.5030800@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:42046 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751508Ab3JIHpc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Oct 2013 03:45:32 -0400
In-Reply-To: <5254F0ED.5030800@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Enric Balletbo i Serra <eballetbo@gmail.com>, bcousson@baylibre.com, linux-omap@vger.kernel.org

On 10/09/2013 08:00 AM, Tomi Valkeinen wrote:
> Hi,
> 

Hi Tomi, thanks a lot for your feedback.

> On 05/10/13 05:51, Javier Martinez Canillas wrote:
>> IGEPv2 board has both an DVI and TFP410 video interfaces but
>> DSS support for DeviceTree has not yet landed in mainline so
>> is necessary to init the displays using legacy platform code.
>> 
>> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>> ---
>>  arch/arm/mach-omap2/dss-common.c   | 37 +++++++++++++++++++++++++++++++++++++
>>  arch/arm/mach-omap2/dss-common.h   |  1 +
>>  arch/arm/mach-omap2/pdata-quirks.c |  7 +++++++
>>  3 files changed, 45 insertions(+)
>> 
>> diff --git a/arch/arm/mach-omap2/dss-common.c b/arch/arm/mach-omap2/dss-common.c
>> index bf89eff..0c1cf2e 100644
>> --- a/arch/arm/mach-omap2/dss-common.c
>> +++ b/arch/arm/mach-omap2/dss-common.c
>> @@ -39,6 +39,7 @@
>>  #define HDMI_GPIO_HPD  63 /* Hotplug detect */
>>  
>>  #define PANDA_DVI_TFP410_POWER_DOWN_GPIO	0
>> +#define IGEP2_DVI_TFP410_POWER_DOWN_GPIO	170
>>  
>>  /* DVI Connector */
>>  static struct connector_dvi_platform_data omap4_panda_dvi_connector_pdata = {
>> @@ -53,6 +54,18 @@ static struct platform_device omap4_panda_dvi_connector_device = {
>>  	.dev.platform_data      = &omap4_panda_dvi_connector_pdata,
>>  };
>>  
>> +static struct connector_dvi_platform_data omap3_igep2_dvi_connector_pdata = {
>> +	.name                   = "dvi",
>> +	.source                 = "tfp410.0",
>> +	.i2c_bus_num            = 3,
>> +};
>> +
>> +static struct platform_device omap3_igep2_dvi_connector_device = {
>> +	.name                   = "connector-dvi",
>> +	.id                     = 0,
>> +	.dev.platform_data      = &omap3_igep2_dvi_connector_pdata,
>> +};
>> +
>>  /* TFP410 DPI-to-DVI chip */
>>  static struct encoder_tfp410_platform_data omap4_panda_tfp410_pdata = {
>>  	.name                   = "tfp410.0",
>> @@ -67,6 +80,19 @@ static struct platform_device omap4_panda_tfp410_device = {
>>  	.dev.platform_data      = &omap4_panda_tfp410_pdata,
>>  };
>>  
>> +static struct encoder_tfp410_platform_data omap3_igep2_tfp410_pdata = {
>> +	.name                   = "tfp410.0",
>> +	.source                 = "dpi.0",
>> +	.data_lines             = 24,
>> +	.power_down_gpio        = IGEP2_DVI_TFP410_POWER_DOWN_GPIO,
>> +};
>> +
>> +static struct platform_device omap3_igep2_tfp410_device = {
>> +	.name                   = "tfp410",
>> +	.id                     = 0,
>> +	.dev.platform_data      = &omap3_igep2_tfp410_pdata,
>> +};
>> +
> 
> I think it would be better to organize the file in sections based on
> boards. Not mixing the display devices for different boards like above.
> 

Perfect I can do this reorganization and repost if Tony drops this patch from
his branch. But this is just a hack and and it should go away as soon as your
DSS DT patches land in mainline.

>>  /* HDMI Connector */
>>  static struct connector_hdmi_platform_data omap4_panda_hdmi_connector_pdata = {
>>  	.name                   = "hdmi",
>> @@ -99,6 +125,10 @@ static struct omap_dss_board_info omap4_panda_dss_data = {
>>  	.default_display_name = "dvi",
>>  };
>>  
>> +static struct omap_dss_board_info igep2_dss_data = {
>> +	.default_display_name = "dvi",
>> +};
>> +
>>  void __init omap4_panda_display_init_of(void)
>>  {
>>  	omap_display_init(&omap4_panda_dss_data);
>> @@ -110,6 +140,13 @@ void __init omap4_panda_display_init_of(void)
>>  	platform_device_register(&omap4_panda_hdmi_connector_device);
>>  }
>>  
>> +void __init omap3_igep2_display_init_of(void)
>> +{
>> +	omap_display_init(&igep2_dss_data);
>> +
>> +	platform_device_register(&omap3_igep2_tfp410_device);
>> +	platform_device_register(&omap3_igep2_dvi_connector_device);
>> +}
> 
> Wouldn't it be better to remove the display setup from the board file at
> the same time as it's added here? Otherwise we'll end up with the same
> display setup being in two different files.
> 

I can't do it yet because the two are still needed for different boot paths.
Once the board DTS has all the hardware support that is currently available on
the board file I'll delete the board file but until then I can't remove anything
from the legacy code since that is what users are using right now.

>> @@ -103,6 +108,8 @@ static struct pdata_init pdata_quirks[] __initdata = {
>>  #ifdef CONFIG_ARCH_OMAP3
>>  	{ "nokia,omap3-n9", hsmmc2_internal_input_clk, },
>>  	{ "nokia,omap3-n950", hsmmc2_internal_input_clk, },
>> +	{ "nokia,omap3-n950", hsmmc2_internal_input_clk, },
> 
> The above is extra.
>

Yes, I noticed too just after sending the patch so I sent a v2 of the patch a
few minutes later [1]. Sorry for the confusion.

>  Tomi
> 
> 

Best regards,
Javier

[1]: http://www.spinics.net/lists/linux-omap/msg98257.html
