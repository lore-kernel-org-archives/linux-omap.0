From: "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 04/10] rtc: rtc-twl: Add DT support for RTC inside
 twl4030/twl6030
Date: Tue, 20 Dec 2011 16:13:41 +0100
Message-ID: <4EF0A625.4050008@ti.com>
References: <1323439361-1647-1-git-send-email-b-cousson@ti.com>
 <1323439361-1647-5-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1323439361-1647-5-git-send-email-b-cousson-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: "akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org" <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Andrew,

I've never got any feedback on this patch from Alessandro and it seems
that you took care of some rtc stuff recently.

Thanks in advance,
Benoit

On 12/9/2011 3:02 PM, Benoit Cousson wrote:
> Add the DT support for the TI rtc-twl present in the twl4030
> and twl6030 devices.
>
> Signed-off-by: Benoit Cousson<b-cousson-l0cyMroinI0@public.gmane.org>
> Cc: Alessandro Zummo<a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>
> ---
>   Documentation/devicetree/bindings/rtc/twl-rtc.txt |   12 ++++++++++++
>   drivers/rtc/rtc-twl.c                             |   10 ++++++++--
>   2 files changed, 20 insertions(+), 2 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/rtc/twl-rtc.txt
>
> diff --git a/Documentation/devicetree/bindings/rtc/twl-rtc.txt b/Documentation/devicetree/bindings/rtc/twl-rtc.txt
> new file mode 100644
> index 0000000..596e0c9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/twl-rtc.txt
> @@ -0,0 +1,12 @@
> +* TI twl RTC
> +
> +The TWL family (twl4030/6030) contains a RTC.
> +
> +Required properties:
> +- compatible : Should be twl4030-rtc
> +
> +Examples:
> +
> +rtc@0 {
> +    compatible = "ti,twl4030-rtc";
> +};
> diff --git a/drivers/rtc/rtc-twl.c b/drivers/rtc/rtc-twl.c
> index 20687d5..d43b4f6 100644
> --- a/drivers/rtc/rtc-twl.c
> +++ b/drivers/rtc/rtc-twl.c
> @@ -550,6 +550,11 @@ static int twl_rtc_resume(struct platform_device *pdev)
>   #define twl_rtc_resume  NULL
>   #endif
>
> +static const struct of_device_id twl_rtc_of_match[] = {
> +	{.compatible = "ti,twl4030-rtc", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, twl_rtc_of_match);
>   MODULE_ALIAS("platform:twl_rtc");
>
>   static struct platform_driver twl4030rtc_driver = {
> @@ -559,8 +564,9 @@ static struct platform_driver twl4030rtc_driver = {
>   	.suspend	= twl_rtc_suspend,
>   	.resume		= twl_rtc_resume,
>   	.driver		= {
> -		.owner	= THIS_MODULE,
> -		.name	= "twl_rtc",
> +		.owner		= THIS_MODULE,
> +		.name		= "twl_rtc",
> +		.of_match_table = twl_rtc_of_match,
>   	},
>   };
>
