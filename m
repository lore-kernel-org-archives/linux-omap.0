From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 4/4] ARM: dts: AM33XX: update rtc node compatibility
Date: Tue, 2 Jul 2013 11:42:49 +0530
Message-ID: <51D26F61.7080308@ti.com>
References: <1372412109-986-1-git-send-email-gururaja.hebbar@ti.com>
	<1372412109-986-5-git-send-email-gururaja.hebbar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1372412109-986-5-git-send-email-gururaja.hebbar-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Hebbar Gururaja <gururaja.hebbar-l0cyMroinI0@public.gmane.org>
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, =?UTF-8?B?QmVub8OudCBDb3Vzc29u?= <benoit.cousson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Changing to Benoit's gmail id since he apparently wont access TI mail
anymore.

On 6/28/2013 3:05 PM, Hebbar Gururaja wrote:
> Since AM33xx  RTC IP has RTC_IRQWAKEEN to support Alarm Wake-up.
> 
> Update the rtc compatible property to "ti,am3352-rtc" to enable handling
> of this feature inside rtc-omap driver.
> 
> Signed-off-by: Hebbar Gururaja <gururaja.hebbar-l0cyMroinI0@public.gmane.org>
> Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> Cc: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
> Cc: Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: b-cousson-l0cyMroinI0@public.gmane.org
> ---
> :100644 100644 77aa1b0... dde180a... M	arch/arm/boot/dts/am33xx.dtsi
>  arch/arm/boot/dts/am33xx.dtsi |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index 77aa1b0..dde180a 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -297,7 +297,7 @@
>  		};
>  
>  		rtc@44e3e000 {
> -			compatible = "ti,da830-rtc";
> +			compatible = "ti,am3352-rtc";

compatible is a list so you can instead do:
	
	compatible = "ti,am3352-rtc", "ti,da830-rtc";

That way the dts works irrespective of driver updates. When driver
supports enhanced features of hardware, they are available to the user
else the basic functionality still works.

Thanks,
Sekhar
