From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [PATCH 11/11] OMAPDSS: DPI: use VPLL2 regulator if VDDS_DSI is
 not found
Date: Sat, 16 Nov 2013 16:34:36 +0100
Message-ID: <5287908C.3040602@collabora.co.uk>
References: <1384608224-9452-1-git-send-email-javier.martinez@collabora.co.uk> <1384608224-9452-12-git-send-email-javier.martinez@collabora.co.uk> <20131116141853.GF10317@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:60456 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751929Ab3KPPfc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 Nov 2013 10:35:32 -0500
In-Reply-To: <20131116141853.GF10317@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Enric Balletbo i Serra <eballetbo@gmail.com>, bcousson@baylibre.com, tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Tony,

On 11/16/2013 03:18 PM, Tony Lindgren wrote:
> * Javier Martinez Canillas <javier.martinez@collabora.co.uk> [131116 05:25]:
>> On Device Tree boot the VDDS_DSI regulator is not linked to
>> the DPI device so omapfb driver probing fails with:
>> 
>> [    3.186035] OMAPFB: omapfb_probe
>> [    3.190704] omapdss DPI error: can't get VDDS_DSI regulator
>> [    3.196594] omapfb omapfb: failed to connect default display
>> [    3.202667] omapfb omapfb: failed to init overlay connections
>> [    3.208892] OMAPFB: free_resources
>> [    3.212493] OMAPFB: free all fbmem
>> [    3.216735] omapfb omapfb: failed to setup omapfb
>> 
>> As a workaround try to use the VPLL2 regulator from twl4030 in
>> dpi_init_regulator() if getting the VDDS_DSI regulator fails.
> 
> Probably makes sens to fix this in the dpi.c, but this can also be set
> in the .dts file. I just set up the following in the omap3-ldp.dts file:
> 

Sorry is not clear to me if you agree that makes sense to do this fix on dpi.c
or if you think this is a bad idea and prefer to do it in the DTS instead?

I'm asking to know if I have to send a follow up patch or not :)

> &vaux1 {
> 	/* Needed for ads7846 */
> 	regulator-name = "vcc";
> };
> 
> &vpll2 {
> 	/* Needed for DSS */
> 	regulator-name = "vdds_dsi";
> };
> 
> Regards,
> 
> Tony
> 
>  
>> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>> ---
>>  drivers/video/omap2/dss/dpi.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>> 
>> diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
>> index bd48cde..e328f0b 100644
>> --- a/drivers/video/omap2/dss/dpi.c
>> +++ b/drivers/video/omap2/dss/dpi.c
>> @@ -550,6 +550,11 @@ static int dpi_init_regulator(void)
>>  		return 0;
>>  
>>  	vdds_dsi = devm_regulator_get(&dpi.pdev->dev, "vdds_dsi");
>> +
>> +        /* DT HACK: try VPLL2 to make omapdss work for OMAP3 IGEPv2 */
>> +        if (IS_ERR(vdds_dsi))
>> +                vdds_dsi = devm_regulator_get(&dpi.pdev->dev, "VPLL2");
>> +
>>  	if (IS_ERR(vdds_dsi)) {
>>  		DSSERR("can't get VDDS_DSI regulator\n");
>>  		return PTR_ERR(vdds_dsi);
>> -- 
>> 1.8.4.2
>> 
> 

Best regards,
Javier
