From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH 1/3] serial: 8250_omap: Drop check for of_node
Date: Thu, 10 Jan 2019 18:54:27 +0530
Message-ID: <dbc00a69-2144-6e30-e9b1-4f8ee272ab8a@ti.com>
References: <20190109091206.25759-1-vigneshr@ti.com>
 <20190109091206.25759-2-vigneshr@ti.com> <20190109214403.GW5544@atomide.com>
 <20190110120758.bz63neey5ztepw4m@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190110120758.bz63neey5ztepw4m@earth.universe>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Jiri Slaby <jslaby@suse.com>, Lokesh Vutla <lokeshvutla@ti.com>, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


On 10-Jan-19 5:37 PM, Sebastian Reichel wrote:
> Hi,
> 
> On Wed, Jan 09, 2019 at 01:44:03PM -0800, Tony Lindgren wrote:
>> * Vignesh R <vigneshr@ti.com> [190109 09:11]:
>>> 8250_omap is DT only driver so dev->of_node always exists. Drop check
>>> for existence of valid dev->of_node to simplify omap8250_probe().
>>
>> That part seems safe to me now.
>>
>>> --- a/drivers/tty/serial/8250/8250_omap.c
>>> +++ b/drivers/tty/serial/8250/8250_omap.c
>> ...
>>> -		const struct of_device_id *id;
>>> -
>>> -		ret = of_alias_get_id(pdev->dev.of_node, "serial");
>>> -
>>> -		of_property_read_u32(pdev->dev.of_node, "clock-frequency",
>>> -				     &up.port.uartclk);
>>> -		priv->wakeirq = irq_of_parse_and_map(pdev->dev.of_node, 1);
>>> -
>>> -		id = of_match_device(of_match_ptr(omap8250_dt_ids), &pdev->dev);
>>> -		if (id && id->data)
>>> -			priv->habit |= *(u8 *)id->data;
>>
>> But this part it seems we still need to keep around
>> as we still have lots of clock-frequency references
>> in the *.dtsi files. Or am I missing something?
> 
> It's re-added a couple of lines later. Only the indent was removed.
> 

That's right. You beat me to it. Thanks :)

Regards
Vignesh
