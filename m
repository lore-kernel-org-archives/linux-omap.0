From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 5/7] drivers:input:ads7846(+tsc2046): add new common
 binding names, pre-calibration and flipping
Date: Mon, 9 Nov 2015 11:31:09 -0600
Message-ID: <20151109173109.GA15192@rob-hp-laptop>
References: <cover.1446822887.git.hns@goldelico.com>
 <49ae3bab17189684d046212e548d6d637618ee71.1446822887.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <49ae3bab17189684d046212e548d6d637618ee71.1446822887.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, gta04-owner@goldelico.com
List-Id: linux-omap@vger.kernel.org

On Fri, Nov 06, 2015 at 04:14:47PM +0100, H. Nikolaus Schaller wrote:
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
> [1]: Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  .../devicetree/bindings/input/ads7846.txt          |  8 ++-

The binding change looks okay, but...

> @@ -1213,7 +1259,7 @@ static const struct ads7846_platform_data *ads7846_probe_dt(struct device *dev)
>  	of_property_read_u16(node, "ti,vref-mv", &pdata->vref_mv);
>  	pdata->keep_vref_on = of_property_read_bool(node, "ti,keep-vref-on");
>  
> -	pdata->swap_xy = of_property_read_bool(node, "ti,swap-xy");
> +	pdata->swap_xy = of_property_read_bool(node, "touchscreen-swapped-x-y");

This will break with old dtb's. The driver should look for either 
property.

Rob
