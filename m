From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v7 7/9] dt-bindings: input: move ads7846 bindings to
 touchscreen subdirectory
Date: Tue, 15 Nov 2016 16:16:21 -0600
Message-ID: <20161115221621.pedbsb5jgskla3av@rob-hp-laptop>
References: <cover.1478890925.git.hns@goldelico.com>
 <3a0b4f67ae4a40b6fea2f61089ef03cc88f29294.1478890925.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3a0b4f67ae4a40b6fea2f61089ef03cc88f29294.1478890925.git.hns@goldelico.com>
Sender: linux-input-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Rutland <mark.rutland@arm.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Michael Welling <mwelling@ieee.org>, Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila@nextfour.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Igor Grinberg <grinberg@compulab.co.il>, "Andrew F. Davis" <afd@ti.com>, Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, letux-kernel@openphoenux.org, linux-iio@vger.kernel.org, kernel@pyra-handheld.c
List-Id: linux-omap@vger.kernel.org

On Fri, Nov 11, 2016 at 08:02:04PM +0100, H. Nikolaus Schaller wrote:
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  Documentation/devicetree/bindings/input/{ => touchscreen}/ads7846.txt | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename Documentation/devicetree/bindings/input/{ => touchscreen}/ads7846.txt (100%)
> 
> diff --git a/Documentation/devicetree/bindings/input/ads7846.txt b/Documentation/devicetree/bindings/input/touchscreen/ads7846.txt
> similarity index 100%
> rename from Documentation/devicetree/bindings/input/ads7846.txt
> rename to Documentation/devicetree/bindings/input/touchscreen/ads7846.txt
> -- 
> 2.7.3

Acked-by: Rob Herring <robh@kernel.org> 
