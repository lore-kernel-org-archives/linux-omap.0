From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v7 9/9] DT:omap3+ads7846: use new common touchscreen
 bindings
Date: Mon, 14 Nov 2016 13:28:56 -0800
Message-ID: <20161114212855.GB4082@atomide.com>
References: <cover.1478890925.git.hns@goldelico.com>
 <bb3b82c63810026cd6c23a5788c3efc79fa53e60.1478890925.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <bb3b82c63810026cd6c23a5788c3efc79fa53e60.1478890925.git.hns@goldelico.com>
Sender: linux-input-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Rutland <mark.rutland@arm.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Michael Welling <mwelling@ieee.org>, Mika =?utf-8?B?UGVudHRpbMOk?= <mika.penttila@nextfour.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Igor Grinberg <grinberg@compulab.co.il>, "Andrew F. Davis" <afd@ti.com>, Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, letux-kernel@openphoenux.org, linux-iio@vger.kernel.org, kernel@pyra-handheld.com
List-Id: linux-omap@vger.kernel.org

* H. Nikolaus Schaller <hns@goldelico.com> [161111 11:03]:
> The standard touch screen bindings [1] replace the private ti,swap-xy
> with touchscreen-swaped-x-y. And for the Openpandora we use
> touchscreen-size etc. to match the LCD screen size.

This one should not cause conflicts, so please feel free to merge along
with the driver changes:

Acked-by: Tony Lindgren <tony@atomide.com>
