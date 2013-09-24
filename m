From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] arm: dts: omap5-uevm: Add status parameter for i2c/spi/uart.
Date: Tue, 24 Sep 2013 11:14:44 +0530
Message-ID: <524126CC.3020300@ti.com>
References: <1380001165-19078-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1380001165-19078-1-git-send-email-sourav.poddar-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Cc: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 24 September 2013 11:09 AM, Sourav Poddar wrote:
> omap5 has all devices enable by default.
> Disable thosw not required in omap5 uevm board.

s/thosw/those

> 
> Fix the following:
> Added status parameter
> Simulataneously, fix some tab formatting.

s/Simulataneously/Simultaneously

> 
> Signed-off-by: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
> ---
>  arch/arm/boot/dts/omap5-uevm.dts |   38 +++++++++++++++++++++++++++++++-------
>  1 files changed, 31 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
> index 65d7b60..78cf0f2 100644
> --- a/arch/arm/boot/dts/omap5-uevm.dts
> +++ b/arch/arm/boot/dts/omap5-uevm.dts
> @@ -450,6 +450,18 @@
>  	};
>  };
>  
> +&i2c2 {
> +	status = "disabled";
> +};
> +
> +&i2c3 {
> +	status = "disabled";
> +};
> +
> +&i2c4 {
> +	status = "disabled";
> +};

The right thing to do would be to mark these as disabled in omap5.dtsi
so boards can enable only what they need instead of disable what they
don't need (which is potentially a very long list)

Thanks,
Sekhar
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
