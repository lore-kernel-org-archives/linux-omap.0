From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 2/3] wlcore/wl12xx: spi: add device tree support
Date: Tue, 29 Dec 2015 12:34:09 -0600
Message-ID: <20151229183409.GA12260@rob-hp-laptop>
References: <1451304139-10899-1-git-send-email-uri.mashiach@compulab.co.il>
 <1451304139-10899-3-git-send-email-uri.mashiach@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1451304139-10899-3-git-send-email-uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uri Mashiach <uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Cc: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Eliad Peller <eliad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Mon, Dec 28, 2015 at 02:02:18PM +0200, Uri Mashiach wrote:
> Add DT support for the wl1271 SPI WiFi.
> 
> Add documentation file for the wl1271 SPI WiFi.
> 
> Signed-off-by: Uri Mashiach <uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
> Acked-by: Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
> ---
> v1 -> v2: update interrupt documentation.
>           replace interrupts and interrupt-parent with interrupts-extended.

Why? interrupts-extended is really just for cases with 2 interrupt 
parents.

> 	  IRQ parameters retrieved from spi_device instead of DT.
> 	  remove redundant #ifdef CONFIG_OF
> v2 -> v3: Add MODULE_DEVICE_TABLE.
>           Remove #ifdef CONFIG_OF.
> 	  Make the Kconfig symbol to depend on OF.
> 	  Replace irqd_get_trigger_type() with irq_get_trigger_type().
> 
>  .../bindings/net/wireless/ti,wlcore,spi.txt        | 34 ++++++++++++++++

In any case:

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

>  drivers/net/wireless/ti/wlcore/Kconfig             |  2 +-
>  drivers/net/wireless/ti/wlcore/spi.c               | 47 ++++++++++++++++++++--
>  3 files changed, 78 insertions(+), 5 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/wireless/ti,wlcore,spi.txt
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
