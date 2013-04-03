From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v3 01/11] usb: phy: Add APIs for runtime power management
Date: Wed, 3 Apr 2013 10:38:33 +0530
Message-ID: <515BB951.40702@ti.com>
References: <1364824448-14732-1-git-send-email-gautam.vivek@samsung.com> <1364824448-14732-2-git-send-email-gautam.vivek@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1364824448-14732-2-git-send-email-gautam.vivek@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vivek Gautam <gautam.vivek@samsung.com>, balbi@ti.com
Cc: linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, stern@rowland.harvard.edu, sarah.a.sharp@linux.intel.com, rob.herring@calxeda.com, kgene.kim@samsung.com, dianders@chromium.org, t.figa@samsung.com, p.paneri@samsung.com
List-Id: linux-omap@vger.kernel.org

Hi,

On Monday 01 April 2013 07:24 PM, Vivek Gautam wrote:
> Adding  APIs to handle runtime power management on PHY
> devices. PHY consumers may need to wake-up/suspend PHYs
> when they work across autosuspend.
>
> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
> ---
>   include/linux/usb/phy.h |  141 +++++++++++++++++++++++++++++++++++++++++++++++
>   1 files changed, 141 insertions(+), 0 deletions(-)
>
> diff --git a/include/linux/usb/phy.h b/include/linux/usb/phy.h
> index 6b5978f..01bf9c1 100644
> --- a/include/linux/usb/phy.h
> +++ b/include/linux/usb/phy.h
> @@ -297,4 +297,145 @@ static inline const char *usb_phy_type_string(enum usb_phy_type type)
>   		return "UNKNOWN PHY TYPE";
>   	}
>   }
> +
> +static inline void usb_phy_autopm_enable(struct usb_phy *x)
> +{
> +	if (!x || !x->dev) {
> +		dev_err(x->dev, "no PHY or attached device available\n");
> +		return;
> +		}
> +
> +	pm_runtime_enable(x->dev);
> +}

IMO we need not have wrapper APIs for runtime_enable and runtime_disable 
here. Generally runtime_enable and runtime_disable is done in probe and 
remove of a driver respectively. So it's better to leave the 
runtime_enable/runtime_disable to be done in *phy provider* driver than 
having an API for it to be done by *phy user* driver. Felipe, what do 
you think?

Thanks
Kishon
