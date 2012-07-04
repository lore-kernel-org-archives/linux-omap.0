From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH] arm/dts: am33xx wdt node
Date: Wed, 4 Jul 2012 13:40:01 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E9A2FE9@DBDE01.ent.ti.com>
References: <1341405037-16391-1-git-send-email-afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54645 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753006Ab2GDNkR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jul 2012 09:40:17 -0400
In-Reply-To: <1341405037-16391-1-git-send-email-afzal@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "tony@atomide.com" <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>

+ Grant and device tree, watchdog lists

On Wed, Jul 04, 2012 at 18:00:37, Mohammed, Afzal wrote:
> Add am33xx wdt node.
> 
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> ---
> 
> Hi,
> 
> This was tested on AM335X EVM. This depends on,
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg69424.html
> 
> Regards
> Afzal
> 
> 
>  arch/arm/boot/dts/am33xx.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index f46e353..08b2a5b 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -185,5 +185,10 @@
>  			compatible = "ti,omap3-hsmmc";
>  			ti,hwmods = "mmc3";
>  		};
> +
> +		wdt2: wdt@44e35000 {
> +			compatible = "ti,omap3-wdt";
> +			ti,hwmods = "wd_timer2";
> +		};
>  	};
>  };
> -- 
> 1.7.11.1
> 
> 

