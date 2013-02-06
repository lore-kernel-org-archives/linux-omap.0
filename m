From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: how to specify an OMAP clock in device tree?
Date: Wed, 6 Feb 2013 12:39:56 +0200
Message-ID: <511232FC.6040402@ti.com>
References: <1359993540-20780-1-git-send-email-rogerq@ti.com> <1359993540-20780-12-git-send-email-rogerq@ti.com> <5110D229.1000808@ti.com> <5110E9C4.9000301@ti.com> <51110D4B.50904@ti.com> <51111371.6050502@ti.com> <511114C1.4050809@ti.com> <5111157D.7040803@ti.com> <51111739.2050805@ti.com> <511118FE.7020405@ti.com> <51111CC4.1060004@ti.com> <51122EC0.3040804@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <51122EC0.3040804-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 02/06/2013 12:21 PM, Rajendra Nayak wrote:
> On Tuesday 05 February 2013 08:22 PM, Roger Quadros wrote:
>> Doesn't look very elegant to me, but I wouldn't mind if there is no better option.
>> Even then, we can't rely on the device name as its index can change based on where it is
> 
> Well, thats what I said in the first mail, that *if* you are able to
> fix the device name, *then* we could use clkdev the way its used in
> non-DT case. But then you came back saying 'Fixing the device name
> doesn't really solve the problem.' :)

It does, yes, but depending on fixed device names is not so great for DT, is it?
Doesn't solve the problem in the right sense :)

> 
>> located in the dts file. e.g. in the beginning it may be named phy.8, and if a device
>> node is added before it, it will get changed to phy.9
> 
> If you provide a phandle to the PHY node in the board node, for which
> you need to add the clk alias, you can always extract the device (using
> of_find_device_by_node() ) and hence its name, so it doesn't matter if
> its phy.8 or phy.9.

Right, I'll come up with something on these lines.

Thanks for the suggestions :).

cheers,
-roger

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
