From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: DTS: am3517.dtsi:  Disable reference to OMAP3 OTG
 controller
Date: Thu, 12 Jul 2018 06:57:22 -0700
Message-ID: <20180712135722.GQ99251@atomide.com>
References: <20180711175454.9464-1-aford173@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180711175454.9464-1-aford173@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Ford <aford173@gmail.com>
Cc: adam.ford@logicpd.com, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Adam Ford <aford173@gmail.com> [180711 10:58]:
> The AM3517 has a different OTG controller location than the OMAP3,
> which is included from omap3.dtsi.  This results in a hwmod error.
> Since the AM3517 has a different OTG controller address, this patch
> disabes one that is isn't available.

Applying into omap-for-v4.18/fixes thanks.

Tony
