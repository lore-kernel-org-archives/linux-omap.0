From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] serial: 8250_omap: Drop check for of_node
Date: Wed, 9 Jan 2019 13:44:03 -0800
Message-ID: <20190109214403.GW5544@atomide.com>
References: <20190109091206.25759-1-vigneshr@ti.com>
 <20190109091206.25759-2-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190109091206.25759-2-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Jiri Slaby <jslaby@suse.com>, Lokesh Vutla <lokeshvutla@ti.com>, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Vignesh R <vigneshr@ti.com> [190109 09:11]:
> 8250_omap is DT only driver so dev->of_node always exists. Drop check
> for existence of valid dev->of_node to simplify omap8250_probe().

That part seems safe to me now.

> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
...
> -		const struct of_device_id *id;
> -
> -		ret = of_alias_get_id(pdev->dev.of_node, "serial");
> -
> -		of_property_read_u32(pdev->dev.of_node, "clock-frequency",
> -				     &up.port.uartclk);
> -		priv->wakeirq = irq_of_parse_and_map(pdev->dev.of_node, 1);
> -
> -		id = of_match_device(of_match_ptr(omap8250_dt_ids), &pdev->dev);
> -		if (id && id->data)
> -			priv->habit |= *(u8 *)id->data;

But this part it seems we still need to keep around
as we still have lots of clock-frequency references
in the *.dtsi files. Or am I missing something?

Regards

Tony
