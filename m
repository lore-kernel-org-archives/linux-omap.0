From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH v2 1/2] usb: phy: add a new driver for usb3 phy
Date: Thu, 27 Sep 2012 15:18:38 +0100
Message-ID: <20120927141837.GA26268@n2100.arm.linux.org.uk>
References: <1348754648-8315-1-git-send-email-kishon@ti.com> <1348754648-8315-2-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1348754648-8315-2-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Moiz Sonasath <m-sonasath-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Sep 27, 2012 at 07:34:07PM +0530, Kishon Vijay Abraham I wrote:
> +static int omap5_usb_phy_power(struct omap_usb *phy, bool on)
> +{
> +	u32 val;
> +	unsigned long rate;
> +	struct clk *sys_clk;
> +
> +	sys_clk = clk_get(NULL, "sys_clkin");
> +	if (IS_ERR(sys_clk)) {
> +		pr_err("%s: unable to get sys_clkin\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	rate = clk_get_rate(sys_clk);
> +	rate = rate/1000000;
> +	clk_put(sys_clk);

Actually, you're supposed to hold on to the struct clk all the time your
driver is making use of that - you're not supposed to drop it.

That has several advantages: if clk_get() fails, then you're failing
earlier on (when the driver is being probed) and when some event occurs.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
