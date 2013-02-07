From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: MUSB regression in linux next at least for pandboard
Date: Thu, 7 Feb 2013 11:16:07 +0200
Message-ID: <511370D7.9070509@ti.com>
References: <Pine.LNX.4.44L0.1302061038310.1893-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1302061038310.1893-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Vivek Gautam <gautamvivek1987-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "ABRAHAM, KISHON VIJAY" <kishon-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 02/06/2013 05:43 PM, Alan Stern wrote:
> On Wed, 6 Feb 2013, Felipe Balbi wrote:
> 
>>> I can't reproduce the problem on Panda, but I can on Beagle with a slightly
>>> different behaviour.
>>>
>>> 1) connecting/disconnecting device directly to the beagleboard's USB port works fine.
>>>
>>> 2) If I connect a USB Hub to the port and connect a device to it after the hub has
>>> autosuspended, the device is never detected.
>>> doing lsusb after that triggers the detection and produces a lot of transaction errors.
>>> Beagle log is below, before and after 'lsusb'
>>>
>>> I suppose this doesn't affect Panda because it has a hub connected immediately below the
>>> root hub that never suspends (as ethernet is hardwired to it).
>>
>> Roger, try changing hub's autosuspend delay to something greater than
>> 30ms and see if it helps. There was a discussion lately about that.
> 
> There also were some patches to address this problem recently merged by
> Greg KH (they are in Linus's current git, added after 3.8-rc6 was 
> released):
> 
> da0aa7169b97d90f4af39a9dc84d58bbe19d7e78 USB: add usb_hcd_{start,end}_port_resume
> f292e7f9fb0e4bec68bbd83443407d6bb7922d36 USB: EHCI: notify usbcore about port resumes
> ee74290b7853db9d5fd64db70e5c175241c59fba USB: EHCI: fix timer bug affecting port resume
> 

Alan, thanks for the hints.

It seems the beagleboard problem is related to OMAP silicon errata [1].
Apparently, remote wakeup as well as host issued wakeup break omap-ehci and have
nothing to do with the hub or it's driver.

I'll work on this issue after I'm done with device tree migration.

cheers,
-roger

[1] - Advisory 3.1.1.157 EHCI Controller- Issue in Suspend Resume Protocol
http://www.ti.com/general/docs/lit/getliterature.tsp?literatureNumber=sprz278f&fileType=pdf
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
