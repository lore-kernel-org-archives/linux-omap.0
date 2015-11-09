From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/7] drivers:input:tsc2007: add new common binding names,
 pre-calibration, flipping and rotation
Date: Mon, 9 Nov 2015 11:33:27 -0600
Message-ID: <20151109173327.GA14524@rob-hp-laptop>
References: <cover.1446822887.git.hns@goldelico.com>
 <ad1d3042c80142a59ab883fe17fe950dea734d94.1446822887.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ad1d3042c80142a59ab883fe17fe950dea734d94.1446822887.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, gta04-owner@goldelico.com
List-Id: linux-omap@vger.kernel.org

On Fri, Nov 06, 2015 at 04:14:43PM +0100, H. Nikolaus Schaller wrote:
> commit b98abe52fa8e ("Input: add common DT binding for touchscreens")
> introduced common DT bindings for touchscreens [1] and a helper function to
> parse the DT.
> 
> This has been integrated and interpretation of the inversion (flipping)
> properties for the x and y axis has been added to accommodate any
> orientation of the touch in relation to the LCD.
> 
> By scaling the min/max ADC values to the screen size it is now possible to
> pre-calibrate the touch so that is (almost) exactly matches the LCD it is
> glued onto. This allows to well enough operate the touch before a user
> space calibration can improve the precision.
> 
> calculate_pressure has been renamed to calculate_resistance because
> that is what it is doing.
> 
> [1]: Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  .../bindings/input/touchscreen/tsc2007.txt         |  20 +--
>  drivers/input/touchscreen/tsc2007.c                | 135 +++++++++++++++++----
>  include/linux/i2c/tsc2007.h                        |   8 ++
>  3 files changed, 135 insertions(+), 28 deletions(-)

This one has similar problems with breaking backwards compatibility.

Rob
