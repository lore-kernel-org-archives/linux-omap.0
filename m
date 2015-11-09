From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH 5/7] drivers:input:ads7846(+tsc2046): add new common binding names, pre-calibration and flipping
Date: Mon, 9 Nov 2015 18:36:48 +0100
Message-ID: <C2304EBD-A75D-495A-9A90-5E2082E983B7@goldelico.com>
References: <cover.1446822887.git.hns@goldelico.com> <49ae3bab17189684d046212e548d6d637618ee71.1446822887.git.hns@goldelico.com> <20151109173109.GA15192@rob-hp-laptop>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151109173109.GA15192@rob-hp-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, =?iso-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, gta04-owner@goldelico.com
List-Id: linux-omap@vger.kernel.org


Am 09.11.2015 um 18:31 schrieb Rob Herring <robh@kernel.org>:

> On Fri, Nov 06, 2015 at 04:14:47PM +0100, H. Nikolaus Schaller wrote:
>> commit b98abe52fa8e ("Input: add common DT binding for touchscreens")
>> introduced common DT bindings for touchscreens [1] and a helper function to
>> parse the DT.
>> 
>> This has been integrated and interpretation of the inversion (flipping)
>> properties for the x and y axis has been added to accommodate any
>> orientation of the touch in relation to the LCD.
>> 
>> By scaling the min/max ADC values to the screen size it is now possible to
>> pre-calibrate the touch so that is (almost) exactly matches the LCD it is
>> glued onto. This allows to well enough operate the touch before a user
>> space calibration can improve the precision.
>> 
>> [1]: Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
>> 
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> ---
>> .../devicetree/bindings/input/ads7846.txt          |  8 ++-
> 
> The binding change looks okay, but...
> 
>> @@ -1213,7 +1259,7 @@ static const struct ads7846_platform_data *ads7846_probe_dt(struct device *dev)
>> 	of_property_read_u16(node, "ti,vref-mv", &pdata->vref_mv);
>> 	pdata->keep_vref_on = of_property_read_bool(node, "ti,keep-vref-on");
>> 
>> -	pdata->swap_xy = of_property_read_bool(node, "ti,swap-xy");
>> +	pdata->swap_xy = of_property_read_bool(node, "touchscreen-swapped-x-y");
> 
> This will break with old dtb's.

We have a patch for all boards in tree (external dtbs must be modified by their maintainers).

> The driver should look for either 
> property.

It is easy to recognize either one.

Noted for V2.

BR and thanks,
Nikolaus