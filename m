From: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v3 3/5] usb: musb: Add support of CPPI 4.1 DMA controller
 to DA8xx
Date: Thu, 19 Jan 2017 19:38:27 +0300
Message-ID: <ae0ad09b-5793-04c6-fbc1-c476ff18902d@cogentembedded.com>
References: <20170119140835.18981-1-abailon@baylibre.com>
 <20170119140835.18981-4-abailon@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170119140835.18981-4-abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, b-liu-l0cyMroinI0@public.gmane.org
Cc: nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 01/19/2017 05:08 PM, Alexandre Bailon wrote:

> Currently, only the PIO mode is supported.
> This add support of CPPI 4.1 to DA8xx.
> As the In DA8xx the CPPI 4.1 DMA is a part of the USB.
> Create the CPPI 4.1 device as a child of USB.
>
> Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> ---
>  drivers/usb/musb/Kconfig |  4 ++--
>  drivers/usb/musb/da8xx.c | 35 ++++++++++++++++++++++++++++++++++-
>  2 files changed, 36 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
> index 72a2a50..5506a9c 100644
> --- a/drivers/usb/musb/Kconfig
> +++ b/drivers/usb/musb/Kconfig
> @@ -160,8 +160,8 @@ config USB_TI_CPPI_DMA
>  	  Enable DMA transfers when TI CPPI DMA is available.
>
>  config USB_TI_CPPI41_DMA
> -	bool 'TI CPPI 4.1 (AM335x)'
> -	depends on ARCH_OMAP && DMADEVICES
> +	bool 'TI CPPI 4.1'
> +	depends on (ARCH_OMAP || ARCH_DAVINCI_DA8XX) && DMADEVICES
>  	select TI_CPPI41
>
>  config USB_TUSB_OMAP_DMA
> diff --git a/drivers/usb/musb/da8xx.c b/drivers/usb/musb/da8xx.c
> index cd3d763..5f50a78 100644
> --- a/drivers/usb/musb/da8xx.c
> +++ b/drivers/usb/musb/da8xx.c
[...]
> @@ -457,12 +458,40 @@ static inline u8 get_vbus_power(struct device *dev)
>  	return current_uA / 1000 / 2;
>  }
>
> +#ifdef CONFIG_USB_TI_CPPI41_DM

    CONFIG_USB_TI_CPPI41_DMA! :-)

[...]

MBR, Sergei

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
