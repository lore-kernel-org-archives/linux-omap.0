From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 00/13] Device tree support for OMAP HS USB Host
Date: Tue, 5 Feb 2013 13:32:19 +0200
Message-ID: <5110EDC3.8040200@ti.com>
References: <1359993540-20780-1-git-send-email-rogerq@ti.com> <5110EC0D.40609@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5110EC0D.40609-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 02/05/2013 01:25 PM, Rajendra Nayak wrote:
> On Monday 04 February 2013 09:28 PM, Roger Quadros wrote:
>> This patchset adds device tree support for OMAP's High Speed USB Host
>> subsystem. Board adaptation for Panda and Beagleboard is also provided.
>>
>> Tested on Beagleboard.
>>
>> Will only work with Panda if we provide a reference to the PHY clock
> 
> But there is no reference provided even for Beagle. Does it work because
> the default clk speed is 192Mhz?

On beagle board the PHY is connected differently, i.e. as the clock receptor.
The PHY clock comes directly from the USB_CLK pin.

On Panda the PHY is the clock provider to the USB_CLK pin. For that it needs
a reference clock at the REFCLK pin which comes from FREF_CLK3.

> 
>> generator in the device tree in PATCH 11. I do not know how to do that
>> as there is no way to provide a phandle to any of the OMAP generated clocks
>> in the device tree. Suggestions welcome:).
> 

cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
