From: Jon Hunter <jgchunter@gmail.com>
Subject: Re: [PATCH v2 11/14] Documentation: dt: binding: omap: am43x timer
Date: Tue, 28 May 2013 22:25:09 +0100
Message-ID: <51A520B5.8040803@gmail.com>
References: <cover.1369658705.git.afzal@ti.com> <223d90dc9eeab13d8496690d336cdf0f7d27cd22.1369658705.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <223d90dc9eeab13d8496690d336cdf0f7d27cd22.1369658705.git.afzal@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@linaro.org>, Benoit Cousson <benoit.cousson@linaro.org>
List-Id: linux-omap@vger.kernel.org


On 27/05/13 15:37, Afzal Mohammed wrote:
> AM43x timer bindings.
> 
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> ---
>  Documentation/devicetree/bindings/arm/omap/timer.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/omap/timer.txt b/Documentation/devicetree/bindings/arm/omap/timer.txt
> index d02e27c..70cb398 100644
> --- a/Documentation/devicetree/bindings/arm/omap/timer.txt
> +++ b/Documentation/devicetree/bindings/arm/omap/timer.txt
> @@ -14,6 +14,8 @@ Required properties:
>  			ti,omap5430-timer (applicable to OMAP543x devices)
>  			ti,am335x-timer	(applicable to AM335x devices)
>  			ti,am335x-timer-1ms (applicable to AM335x devices)
> +			"ti,am4372-timer-1ms", "ti,am335x-timer-1ms" for AM43x 1ms timer
> +			"ti,am4372-timer", "ti,am335x-timer" for AM43x timers other than 1ms one
>  
>  - reg:			Contains timer register address range (base address and
>  			length).

If you are adding more compatibility strings, then this implies that the
AM43x timers are not 100% compatible with any other device listed (such
as am335x or any omap device). That's fine but you should state that in
the changelog. If the AM43x timer registers are 100% compatible with
existing devices you should not add these.

Jon
