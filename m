From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [RFC  PATCH] Board support for the the GPIO keys
Date: Thu, 19 Aug 2010 17:17:06 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0324222967@dbde02.ent.ti.com>
References: <1282218130-17111-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <1282218130-17111-1-git-send-email-shubhrajyoti@ti.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
To: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Datta, Shubhrajyoti wrote:
> Subject: [RFC PATCH] Board support for the the GPIO keys
> 

Please tag $SUBJECT with something like "omap: 4430sdp: "

> Board support for the GPIO keys.
> The proximity sensor is connected to GPIO and is registered as a 
> GPIO key.
> 
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>

...


> +static void omap_sfh7741prox_init(void)
> +{
> +	int  error;
> +
> +	error = gpio_request(OMAP4_SFH7741_ENABLE_GPIO, "sfh7741");
> +	if (error < 0) {
> +		pr_err("failed to request GPIO %d, error %d\n",
> +			OMAP4_SFH7741_ENABLE_GPIO, error);
> +		return;
> +	}
> +
> +	error = gpio_direction_output(OMAP4_SFH7741_ENABLE_GPIO , 1);
> +	if (error < 0) {
> +		pr_err("%s: GPIO configuration failed: GPIO %d,error %d\n",\
> +			 __func__, OMAP4_SFH7741_ENABLE_GPIO, error);

That trailing '\' is unnecessary.

 