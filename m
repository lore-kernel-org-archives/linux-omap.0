From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: USB ehci suspend/resume on beagleboard
Date: Thu, 4 Apr 2013 14:50:01 +0300
Message-ID: <515D68E9.5070404@ti.com>
References: <Pine.LNX.4.44L0.1302061038310.1893-100000@iolanthe.rowland.org> <511370D7.9070509@ti.com> <CANOLnOODiu+rEqCQH5BAzTXhWi4cUZO-OXO=-1xxyhMFW77UZQ@mail.gmail.com> <515D65D3.40006@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <515D65D3.40006-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Vivek Gautam <gautamvivek1987-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "ABRAHAM, KISHON VIJAY" <kishon-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

correcting misleading subject line.
was (Re: MUSB regression in linux next at least for pandboard)

On 04/04/2013 02:36 PM, Roger Quadros wrote:
> Hi,
> 
> On 02/07/2013 04:10 PM, Grazvydas Ignotas wrote:
>> On Thu, Feb 7, 2013 at 11:16 AM, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> wrote:
>> <snip>
>>> It seems the beagleboard problem is related to OMAP silicon errata [1].
>>> Apparently, remote wakeup as well as host issued wakeup break omap-ehci and have
>>> nothing to do with the hub or it's driver.
>>>
>>> I'll work on this issue after I'm done with device tree migration.
>>
>> Looking forward to this, mainline has been suffering from this since
>> almost forever..
>>
>>
> 
> Unfortunately, there is another errata [2] that makes it impossible to
> support suspend/resume on the beagleboard.
> 
> cheers,
> -roger
> 
> [2] Advisory 3.1.1.195 HSUSB Interoperability Issue With SMSC USB3320 PHY
> http://www.ti.com/general/docs/lit/getliterature.tsp?literatureNumber=sprz278f&fileType=pdf
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
