From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 6/8] drivers:input:ads7846(+tsc2046): add new common
 binding names, pre-calibration and flipping
Date: Sun, 30 Oct 2016 22:41:30 -0500
Message-ID: <20161031034130.4gljsgfugnsp4edy@rob-hp-laptop>
References: <cover.1477557860.git.hns@goldelico.com>
 <8b04ed29eb6a9ed154380941beb3a12a73a276d0.1477557860.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8b04ed29eb6a9ed154380941beb3a12a73a276d0.1477557860.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Rutland <mark.rutland@arm.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Michael Welling <mwelling@ieee.org>, Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila@nextfour.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Igor Grinberg <grinberg@compulab.co.il>, Sebastian Reichel <sre@kernel.org>, "Andrew F. Davis" <afd@ti.com>, Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Sangwon Jee <jeesw@melfas.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, letux-kern
List-Id: linux-omap@vger.kernel.org

On Thu, Oct 27, 2016 at 10:44:19AM +0200, H. Nikolaus Schaller wrote:
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
> [1]: Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  .../devicetree/bindings/input/ads7846.txt          |  9 +++-
>  drivers/input/touchscreen/ads7846.c                | 60 ++++++++++++++++++----
>  2 files changed, 57 insertions(+), 12 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
