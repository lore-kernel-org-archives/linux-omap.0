From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] ARM: dts: omap3-devkit8000: Add dm9000 support
Date: Thu, 21 May 2015 13:54:10 -0700
Message-ID: <20150521205410.GW10274@atomide.com>
References: <1432237937-16691-1-git-send-email-anthoine.bourgeois@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:52912 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753915AbbEUUyN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 May 2015 16:54:13 -0400
Content-Disposition: inline
In-Reply-To: <1432237937-16691-1-git-send-email-anthoine.bourgeois@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anthoine Bourgeois <anthoine.bourgeois@gmail.com>
Cc: linux-omap@vger.kernel.org

Hi,

* Anthoine Bourgeois <anthoine.bourgeois@gmail.com> [150521 12:55]:
> Support dm9000 network interface in the device tree of devkit8000 board.
> 
> Signed-off-by: Anthoine Bourgeois <anthoine.bourgeois@gmail.com>
> ---
>  arch/arm/boot/dts/omap3-devkit8000.dts | 41 ++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap3-devkit8000.dts b/arch/arm/boot/dts/omap3-devkit8000.dts
> index 283db1d..b32eeda 100644
> --- a/arch/arm/boot/dts/omap3-devkit8000.dts
> +++ b/arch/arm/boot/dts/omap3-devkit8000.dts
> @@ -158,3 +158,44 @@
>  		};
>  	};
>  };
> +
> +&gpmc {
> +	ranges = <6 0 0x2c000000 0x1000000>;       /* CS6: 16MB for DM9000 */
> +
> +	ethernet@0,0 {
> +		compatible = "davicom,dm9000";
> +		reg = <6 0x000 3
> +		       6 0x400 3>;

So CS6 for GPMC and ioarea at offsets 0 and 0x400.. But the
size of 3 does not look right to me.. That's the size that
gets ioremapped by the Ethernet driver?

> +		bank-width = <2>;
> +		interrupt-parent = <&gpio1>;		/* CS6 -> DM9000 */

Is this comment maybe on the wrong line or how is the GPIO
interrupt related to the CS6? :)

Otherwise looks good to me.

Regards,

Tony
