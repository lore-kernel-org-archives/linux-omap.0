From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v9 1/8] drivers:input:tsc2007: add new common binding
 names, pre-calibration, flipping and rotation
Date: Mon, 9 Jan 2017 11:43:44 -0600
Message-ID: <20170109174344.5kvijgyhusboftx3@rob-hp-laptop>
References: <cover.1482936802.git.hns@goldelico.com>
 <9830dd21e6425e3a866fac6ed4cc73ddd58b719f.1482936802.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9830dd21e6425e3a866fac6ed4cc73ddd58b719f.1482936802.git.hns@goldelico.com>
Sender: linux-input-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Rutland <mark.rutland@arm.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Michael Welling <mwelling@ieee.org>, Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila@nextfour.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Igor Grinberg <grinberg@compulab.co.il>, "Andrew F. Davis" <afd@ti.com>, Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Alexander Stein <alexander.stein@systec-electronic.com>, Eric Engestrom <eric@engestrom.ch>, Hans de Goede <hdegoede@redhat.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Petr
List-Id: linux-omap@vger.kernel.org

On Wed, Dec 28, 2016 at 03:53:16PM +0100, H. Nikolaus Schaller wrote:
> commit b98abe52fa8e ("Input: add common DT binding for touchscreens")
> introduced common DT bindings for touchscreens [1] and a helper function to
> parse the DT.
> 
> commit ed7c9870c9bc ("Input: of_touchscreen - add support for inverted / swapped axes")
> added another helper for parsing axis inversion and swapping
> and applying them to x and y coordinates.
> 
> Both helpers have been integrated to accommodate any orientation of the
> touch panel in relation to the LCD.
> 
> A new feature is to introduce scaling the min/max ADC values to the screen
> size.
> 
> This makes it possible to pre-calibrate the touch so that is (almost)
> exactly matches the LCD pixel coordinates it is glued onto. This allows to
> well enough operate the touch before a user space calibration step can
> improve the precision.
> 
> Please note that the old ti,fuzz properties have been removed since they
> are replaced by the common bindings touchscreen-fuzz-x/y/z.
> 
> Finally, calculate_pressure has been renamed to calculate_resistance
> because that is what it is doing.
> 
> [1]: Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  .../bindings/input/touchscreen/tsc2007.txt         |  20 ++--

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/input/touchscreen/tsc2007.c                | 120 +++++++++++++++++----
>  include/linux/i2c/tsc2007.h                        |   8 ++
>  3 files changed, 118 insertions(+), 30 deletions(-)
