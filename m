From: Gururaja Hebbar <gururaja.hebbar-l0cyMroinI0@public.gmane.org>
Subject: Re: [Patch V2 4/4] ARM: dts: AM33XX: update rtc node compatibility
Date: Tue, 30 Jul 2013 10:35:52 +0530
Message-ID: <51F749B0.7020802@ti.com>
References: <1372841225-18813-1-git-send-email-gururaja.hebbar@ti.com>
	<1372841225-18813-5-git-send-email-gururaja.hebbar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1372841225-18813-5-git-send-email-gururaja.hebbar-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: benoit.cousson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, benoit.cousson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vaibhav.bedia-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On 7/3/2013 2:17 PM, Hebbar Gururaja wrote:
> Since AM33xx  RTC IP has RTC_IRQWAKEEN to support Alarm Wake-up.
>
> Update the rtc compatible property to "ti,am3352-rtc" to enable handling
> of this feature inside rtc-omap driver.

The other 2 rtc driver related patches have been pulled up. If you have 
no comments, can you please pull this up.

Regards
Gururaja

>
> Signed-off-by: Hebbar Gururaja <gururaja.hebbar-l0cyMroinI0@public.gmane.org>
> ---
> :100644 100644 77aa1b0... dde180a... M	arch/arm/boot/dts/am33xx.dtsi
>   arch/arm/boot/dts/am33xx.dtsi |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index 77aa1b0..dde180a 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -297,7 +297,7 @@
>   		};
>
>   		rtc@44e3e000 {
> -			compatible = "ti,da830-rtc";
> +			compatible = "ti,am3352-rtc";
>   			reg = <0x44e3e000 0x1000>;
>   			interrupts = <75
>   				      76>;
>
