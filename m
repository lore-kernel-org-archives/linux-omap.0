From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv2] phy: cpcap-usb: Add CPCAP PMIC USB support
Date: Tue, 28 Mar 2017 21:04:24 -0500
Message-ID: <20170329020424.2gbocl65dwrqgk4n@rob-hp-laptop>
References: <20170322234602.5888-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170322234602.5888-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>, Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Mar 22, 2017 at 04:46:02PM -0700, Tony Lindgren wrote:
> Some Motorola phones like droid 4 use a custom CPCAP PMIC that has a
> multiplexing USB PHY.
> 
> This USB PHY can operate at least in four modes using pin multiplexing
> and two control GPIOS:
> 
> - Pass through companion PHY for the SoC USB PHY
> - ULPI PHY for the SoC
> - Pass through USB for the modem
> - UART debug console for the SoC
> 
> This patch adds support for droid 4 USB PHY and debug UART modes,
> support for other modes can be added later on as needed.
> 
> Both peripheral and host mode are working for the USB. The
> host mode depends on the cpcap-charger driver for VBUS.
> 
> VBUS and ID pin detection are done using cpcap-adc IIO ADC
> driver.
> 
> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>
> Cc: Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Tested-by: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> ---
> 
> Changes since v1:
> 
> - Use iio_read_channel_processed() instead of iio_read_channel_scaled()
>   as changed in the v2 of the ADC driver 
> 
> - Keep Tested-by from Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> as the change
>   from v1 is trivial
> 
> ---
>  .../devicetree/bindings/phy/phy-cpcap-usb.txt      |  40 ++

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

>  drivers/phy/Kconfig                                |   8 +
>  drivers/phy/Makefile                               |   1 +
>  drivers/phy/phy-cpcap-usb.c                        | 695 +++++++++++++++++++++
>  4 files changed, 744 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-cpcap-usb.txt
>  create mode 100644 drivers/phy/phy-cpcap-usb.c
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
