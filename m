From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH] phy: cpcap-usb: Fix missing return statement
Date: Fri, 16 Jun 2017 11:25:37 +0530
Message-ID: <e3ea6b6d-fd49-103b-2962-3ae42d2d0c24@ti.com>
References: <20170612081223.20743-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170612081223.20743-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On Monday 12 June 2017 01:42 PM, Tony Lindgren wrote:
> Commit 8ae904e3c236 ("phy: cpcap-usb: Add CPCAP PMIC USB support")
> is missing return statement as noted by Colin Ian King
> <colin.king@canonical.com>. If the optional pins are not configured,
> we just want to return early and not attempt to configure the pins.
> 
> Fixes: 8ae904e3c236 ("phy: cpcap-usb: Add CPCAP PMIC USB support")
> Reported-by: Colin Ian King <colin.king@canonical.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

merged, thanks!

-Kishon
> ---
>  drivers/phy/motorola/phy-cpcap-usb.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/phy/motorola/phy-cpcap-usb.c b/drivers/phy/motorola/phy-cpcap-usb.c
> --- a/drivers/phy/motorola/phy-cpcap-usb.c
> +++ b/drivers/phy/motorola/phy-cpcap-usb.c
> @@ -468,6 +468,8 @@ static int cpcap_usb_init_optional_pins(struct cpcap_phy_ddata *ddata)
>  		dev_info(ddata->dev, "default pins not configured: %ld\n",
>  			 PTR_ERR(ddata->pins));
>  		ddata->pins = NULL;
> +
> +		return 0;
>  	}
>  
>  	ddata->pins_ulpi = pinctrl_lookup_state(ddata->pins, "ulpi");
> 
