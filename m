From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 2/3] iio:adc:palmas: add DT support
Date: Mon, 5 Oct 2015 12:17:55 +0100
Message-ID: <20151005111754.GG19064@leverpostej>
References: <86F849CB-1A50-4BEB-99C6-79FF97971DCB@goldelico.com>
 <cover.1443973837.git.hns@goldelico.com>
 <6C211191-87B8-4444-ADA7-8BE454C2B3D3@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <6C211191-87B8-4444-ADA7-8BE454C2B3D3-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Pradeep Goudagunta <pgoudagunta-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org, jic23-tko9wxEg+fIOOJlXag/Snyp2UmYkHbXO@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Sun, Oct 04, 2015 at 06:05:59PM +0200, H. Nikolaus Schaller wrote:
> From: Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
> 
> Code was found at:
> https://android.googlesource.com/kernel/tegra/+/a90856a6626d502d42c6e7abccbdf9d730b36270%5E%21/#F1
> 
> Signed-off-by: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> [Fixed minor typos + add channels list to documentation]
> Signed-off-by: Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
> ---
> .../devicetree/bindings/iio/adc/palmas-gpadc.txt   | 46 +++++++++++++++++++
> drivers/iio/adc/palmas_gpadc.c                     | 52 +++++++++++++++++++---
> 2 files changed, 93 insertions(+), 5 deletions(-)
> create mode 100644 Documentation/devicetree/bindings/iio/adc/palmas-gpadc.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/palmas-gpadc.txt b/Documentation/devicetree/bindings/iio/adc/palmas-gpadc.txt
> new file mode 100644
> index 0000000..2149afe
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/palmas-gpadc.txt
> @@ -0,0 +1,46 @@
> +* Palmas general purpose ADC IP block devicetree bindings
> +
> +Channels list:
> +	0 battery type
> +	1 battery temp NTC (optional current source)
> +	2 GP
> +	3 temp (with ext. diode, optional current source)
> +	4 GP
> +	5 GP
> +	6 VBAT_SENSE
> +	7 VCC_SENSE
> +	8 Backup Battery voltage
> +	9 external charger (VCHG)
> +	10 VBUS
> +	11 DC-DC current probe (how does this work?)
> +	12 internal die temp
> +	13 internal die temp
> +	14 USB ID pin voltage
> +	15 test network
> +
> +Required properties:
> +- compatible : Must be "ti,palmas-gpadc".
> +
> +Optional sub-nodes:
> +ti,channel0-current-microamp: Channel 0 current in uA.
> +	Values are rounded to derive 0uA, 5uA, 15uA, 20uA.
> +ti,channel3-current-microamp: Channel 3 current in uA.
> +	Valid are rounded to derive 0uA, 10uA, 400uA, 800uA.

It's only possible to configure channels 0 and 3 in this manner?

> +ti,enable-extended-delay: Enable extended delay.

What is this? When would I select it? Why does it belong in the DT
rather than being a runtime option?

> +Example:
> +
> +pmic {
> +	compatible = "ti,twl6035-pmic", "ti,palmas-pmic";
> +	...
> +	gpadc {
> +		compatible = "ti,palmas-gpadc";
> +		interrupts = <18 0
> +			      16 0
> +			      17 0>;
> +		ti,channel0-current-microamp = <5>;
> +		ti,channel3-current-microamp = <10>;
> +		};
> +	};
> +	...
> +};

I thought you needed #iio-cells for encoding the channel?

Mark.
