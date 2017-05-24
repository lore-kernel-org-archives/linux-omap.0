From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/3] usb: host: ohci-platform: Add basic runtime PM
 support
Date: Wed, 24 May 2017 10:23:20 +0300
Message-ID: <0d4d7f0f-2164-92f8-5826-d44af3f2a550@ti.com>
References: <20170522160007.9264-1-tony@atomide.com>
 <20170522160007.9264-2-tony@atomide.com>
 <c040a768-dd2e-a85d-fb3f-3088988f61aa@ti.com>
 <20170523140831.GV10472@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170523140831.GV10472-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Content-Language: en-GB
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 23/05/17 17:08, Tony Lindgren wrote:
> * Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> [170523 00:14]:
>> On 22/05/17 19:00, Tony Lindgren wrote:
>>> --- a/drivers/usb/host/ohci-platform.c
>>> +++ b/drivers/usb/host/ohci-platform.c
>>> @@ -290,7 +294,14 @@ static int ohci_platform_remove(struct platform_device *dev)
>>>  	struct usb_hcd *hcd = platform_get_drvdata(dev);
>>>  	struct usb_ohci_pdata *pdata = dev_get_platdata(&dev->dev);
>>>  	struct ohci_platform_priv *priv = hcd_to_ohci_priv(hcd);
>>> -	int clk, rst;
>>> +	int clk, rst, enabled;
>>> +
>>> +	enabled = pm_runtime_get_sync(&dev->dev);
>>
>> Why do we need to pm_runtime_get_sync() here?
> 
> ohci_platform_remove()
> 	usb_remove_hcd()
> 		ohci_stop()
> 
> Will cause "external abort on non-linefetch" otherwise.

Got it, thanks.

> 
> Regards,
> 
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
