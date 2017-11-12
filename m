From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] omap3-n900: enable autofocus
Date: Sun, 12 Nov 2017 13:07:15 +0100
Message-ID: <20171112120715.lyiwwvqileospbqv@pali>
References: <20171112112528.GA21009@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171112112528.GA21009@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com
List-Id: linux-omap@vger.kernel.org

On Sunday 12 November 2017 12:25:29 Pavel Machek wrote:
> 
> Connect auto-focus coil to the camera sensor, so that it can be used
> by camera applications.
> 
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

Acked-by: Pali Rohár <pali.rohar@gmail.com>

> diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
> index 669c51c..59cc743 100644
> --- a/arch/arm/boot/dts/omap3-n900.dts
> +++ b/arch/arm/boot/dts/omap3-n900.dts
> @@ -778,6 +778,8 @@
>  
>  		reset-gpio = <&gpio4 6 GPIO_ACTIVE_HIGH>; /* 102 */
>  
> +		lens-focus = <&ad5820>;
> +
>  		port {
>  			csi_cam1: endpoint {
>  				bus-type = <3>; /* CCP2 */
> 

-- 
Pali Rohár
pali.rohar@gmail.com
