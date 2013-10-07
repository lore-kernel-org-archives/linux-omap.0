From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V2] ARM: OMAP3: Fix hardware detection for omap3630 when
 booted with device tree
Date: Mon, 7 Oct 2013 15:32:37 -0500
Message-ID: <52531A65.5070803@ti.com>
References: <20131007192009.GA8949@atomide.com> <1381177842-2678-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1381177842-2678-1-git-send-email-nm@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Felipe <balbi@ti.com>, Olof Johansson <olof@lixom.net>
Cc: devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 10/07/2013 03:30 PM, Nishanth Menon wrote:
[...]
> diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
> index 0c514dc..02dd4a9 100644
> --- a/arch/arm/boot/dts/omap3-beagle-xm.dts
> +++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
> @@ -11,7 +11,7 @@
>  
>  / {
>  	model = "TI OMAP3 BeagleBoard xM";
> -	compatible = "ti,omap3-beagle-xm", "ti,omap3-beagle", "ti,omap3";
> +	compatible = "ti,omap3-beagle-xm", "ti,omap363x", "ti,omap3";

^^^ yikes - should have been ti,omap36xx -> apologies, my fix was not
committed in local branch :( - will update and resend - grr..


-- 
Regards,
Nishanth Menon
