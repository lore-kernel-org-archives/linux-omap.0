From: Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 11/11] i2c: omap: enhance pinctrl support
Date: Fri, 31 May 2013 11:07:02 -0700
Message-ID: <87bo7r10s9.fsf@linaro.org>
References: <1369995191-20855-1-git-send-email-gururaja.hebbar@ti.com>
	<1369995191-20855-12-git-send-email-gururaja.hebbar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1369995191-20855-12-git-send-email-gururaja.hebbar-l0cyMroinI0@public.gmane.org>
	(Hebbar Gururaja's message of "Fri, 31 May 2013 15:43:11 +0530")
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Hebbar Gururaja <gururaja.hebbar-l0cyMroinI0@public.gmane.org>
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

+Linus Walleij (pinctrl maintainer)

Hebbar Gururaja <gururaja.hebbar-l0cyMroinI0@public.gmane.org> writes:

> Amend the I2C omap pin controller to optionally take a pin control
> handle and set the state of the pins to:
>
> - "default" on boot, resume and before performing an i2c transfer
> - "idle" after initial default, after resume default, and after each
> i2c xfer
> - "sleep" on suspend()
>
> By optionally putting the pins into sleep state in the suspend callback
> we can accomplish two things.
> - One is to minimize current leakage from pins and thus save power,
> - second, we can prevent the IP from driving pins output in an
> uncontrolled manner, which may happen if the power domain drops the
> domain regulator.
>
> Note:
> A .suspend & .resume callback is added which simply puts the pins to sleep
> state upon suspend & are moved to default & idle state upon resume.
>
> If any of the above pin states are missing in dt, a warning message
> about the missing state is displayed.
> If certain pin-states are not available, to remove this warning message
> pass respective state name with null phandler.
>
> (Changes based on i2c-nomadik.c)
>
> Signed-off-by: Hebbar Gururaja <gururaja.hebbar-l0cyMroinI0@public.gmane.org>
> Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

[...]

> @@ -1123,14 +1138,47 @@ omap_i2c_probe(struct platform_device *pdev)
>  		dev->set_mpu_wkup_lat = pdata->set_mpu_wkup_lat;
>  	}
>  
> -	dev->pins = devm_pinctrl_get_select_default(&pdev->dev);
> -	if (IS_ERR(dev->pins)) {
> -		if (PTR_ERR(dev->pins) == -EPROBE_DEFER)
> +	dev->pinctrl = devm_pinctrl_get(&pdev->dev);
> +	if (!IS_ERR(dev->pinctrl)) {
> +		dev->pins_default = pinctrl_lookup_state(dev->pinctrl,
> +							 PINCTRL_STATE_DEFAULT);

This part is already done by probe in driver core, why does it need to
be done again.  dev->pins->default_state should already have this.
(c.f. pinctrl_bind_pins() in drivers/base/pinctrl.c)

But that brings up a bigger question about whether or not we should be
doing the rest of this (idle/sleep) pin management in the drivers or in
the driver core as well.  I would much prefer it be handled by the
driver core.

In fact, since these are all PM related events, it should probably be
handled by the PM core and seems pretty straight forward to do so.

Kevin
