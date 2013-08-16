From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH v3 1/2] rtc: omap: update of_device_id to reflect latest
 ip revisions
Date: Fri, 16 Aug 2013 16:15:57 +0200
Message-ID: <520E341D.4080206@baylibre.com>
References: <1376653017-21935-1-git-send-email-gururaja.hebbar@ti.com> <1376653017-21935-2-git-send-email-gururaja.hebbar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1376653017-21935-2-git-send-email-gururaja.hebbar@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Cc: akpm@linux-foundation.org, khilman@linaro.org, tony@atomide.com, rob.herring@calxeda.com, mark.rutland@arm.com, a.zummo@towertech.it, rob@landley.net, grant.likely@linaro.org, rtc-linux@googlegroups.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, davinci-linux-open-source@linux.davincidsp.com, sudhakar.raj@ti.com
List-Id: linux-omap@vger.kernel.org

Hi Gururaja,

On 16/08/2013 13:36, Hebbar, Gururaja wrote:
> The syntax of compatible property in DT is to mention the Most specific
> match to most generic match.
>
> Since AM335x is the platform with latest IP revision, add it 1st in
> the device id table.

I don't understand why? The order should not matter at all.

I've tried to follow the thread you had with Mark on the v2, but AFAIK, 
you've never answered to his latest question.

Moreover, checking the differences between the Davinci and the am3352 
RTC IP, I would not claim that both are compatible.

Sure you can use the am3352 with the Davinci driver, but you will lose 
the wakeup functionality without even being notify about that.

For my point of view, compatible mean that the HW will still be fully 
functional with both versions of the driver, which is not the case here.

am3352 DTS must use the ti,am3352-rtc to have the expected behavior. 
Using the ti,da830-rtc version will not make the board working as 
expected. So we cannot claim the compatibility.

> This way, we can add new matching compatible as 1st and maintain old
> compatible string for backwards compatibility.
>
> ex:
> 	compatible = "ti,am3352-rtc", "ti,da830-rtc";
>
> Signed-off-by: Hebbar, Gururaja <gururaja.hebbar@ti.com>
> CC: mark.rutland@arm.com
> ---
> Changes in v3:
> 	- new patch
>
> :100644 100644 dc62cc3... 2f0968c... M	drivers/rtc/rtc-omap.c
>   drivers/rtc/rtc-omap.c |    6 +++---
>   1 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
> index dc62cc3..2f0968c 100644
> --- a/drivers/rtc/rtc-omap.c
> +++ b/drivers/rtc/rtc-omap.c
> @@ -330,12 +330,12 @@ static struct platform_device_id omap_rtc_devtype[] = {
>   MODULE_DEVICE_TABLE(platform, omap_rtc_devtype);
>
>   static const struct of_device_id omap_rtc_of_match[] = {
> -	{	.compatible	= "ti,da830-rtc",
> -		.data		= &omap_rtc_devtype[OMAP_RTC_DATA_DA830_IDX],
> -	},
>   	{	.compatible	= "ti,am3352-rtc",
>   		.data		= &omap_rtc_devtype[OMAP_RTC_DATA_AM335X_IDX],
>   	},
> +	{	.compatible	= "ti,da830-rtc",
> +		.data		= &omap_rtc_devtype[OMAP_RTC_DATA_DA830_IDX],
> +	},
>   	{},
>   };
>   MODULE_DEVICE_TABLE(of, omap_rtc_of_match);

Bottom-line, if you get rid of the old compatible entry, you will not 
have to play some trick with the entries order.

Regards,
Benoit
