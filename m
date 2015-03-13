From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] Documentation: omap-twl4030: Remove ti,codec property
Date: Fri, 13 Mar 2015 12:05:20 +0100
Message-ID: <38159868.RLZZTyUOlK@wuerfel>
References: <1426194899-14037-1-git-send-email-marek@goldelico.com> <1426194899-14037-3-git-send-email-marek@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426194899-14037-3-git-send-email-marek@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Belisko <marek@goldelico.com>
Cc: bcousson@baylibre.com, tony@atomide.com, peter.ujfalusi@ti.com, eballetbo@gmail.com, javier@dowhile0.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jarkko.nikula@bitmer.com, hns@goldelico.com
List-Id: linux-omap@vger.kernel.org

On Thursday 12 March 2015 22:14:59 Marek Belisko wrote:
> diff --git a/Documentation/devicetree/bindings/sound/omap-twl4030.txt b/Documentation/devicetree/bindings/sound/omap-twl4030.txt
> index 1ab6bc8..656165f 100644
> --- a/Documentation/devicetree/bindings/sound/omap-twl4030.txt
> +++ b/Documentation/devicetree/bindings/sound/omap-twl4030.txt
> @@ -4,7 +4,6 @@ Required properties:
>  - compatible: "ti,omap-twl4030"
>  - ti,model: Name of the sound card (for example "omap3beagle")
>  - ti,mcbsp: phandle for the McBSP node
> -- ti,codec: phandle for the twl4030 audio node

As this was a required property, are you sure that no other operating system
uses it?

Even if not, you should probably change it to be an optional property, so
that the existing dtbs do not become noncompliant after the change.

	Arnd
