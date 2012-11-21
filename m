From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 16/16] ARM: OMAP: omap4panda: Power down the USB PHY and
 ETH when not in use
Date: Wed, 21 Nov 2012 18:07:57 +0200
Message-ID: <50ACFC5D.1090406@ti.com>
References: <Pine.LNX.4.44L0.1211211028200.1731-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1211211028200.1731-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, keshava_mgowda-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 11/21/2012 05:32 PM, Alan Stern wrote:
> On Wed, 21 Nov 2012, Roger Quadros wrote:
> 
>> On 11/21/2012 04:52 PM, Alan Stern wrote:
>>> On Wed, 21 Nov 2012, Felipe Balbi wrote:
>>>
>>>> On Thu, Nov 15, 2012 at 04:34:14PM +0200, Roger Quadros wrote:
>>>>> From: Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>>>>
>>>>> This patch changes the management of the two GPIO for
>>>>> "hub reset" (actually controls enable of ULPI PHY and hub reset) and
>>>>> "hub power" (controls power to hub + eth).
>>>>
>>>> looks like this should be done by the hub driver. Alan, what would you
>>>> say ? Should the hub driver know how to power itself up ?
>>>
>>> Not knowing the context, I'm a little confused.  What is this hub 
>>> you're talking about?  Is it a separate USB hub incorporated into the 
>>> IP (like Intel's "rate-matching" hubs in their later chipsets)?  Or is 
>>> it the root hub?
>>>
>>
>> This is actually a USB HUB + Ethernet combo chip (LAN9514) that is hard
>> wired on the panda board with its Power and Reset pins controlled by 2
>> GPIOs from the OMAP SoC.
>>
>> When powered, this chip can consume significant power (~0.7 W) because
>> of the (integrated Ethernet even when suspended. I suppose the ethernet
>> driver SMSC95XX) doesn't put it into a low enough power state on suspend.
>>
>> It doesn't make sense to power the chip when USB is not required on the
>> whole (e.g. ehci_hcd module is not loaded). This is what this patch is
>> trying to fix.
> 
> Ah, okay.  Then yes, assuming you want to power this chip only when 
> either ehci-hcd or the ethernet driver is loaded, the right places 
> to manage the power GPIO are in the init and exit routines of the two 
> drivers.
> 

The Ethernet function actually connects over USB within the chip. So
managing the power only in the ehci-hcd driver should suffice.

cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
