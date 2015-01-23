From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 0/5] extcon: usb: Introduce USB GPIO extcon driver. Fix
 DRA7 USB.
Date: Fri, 23 Jan 2015 09:26:56 +0200
Message-ID: <54C1F7C0.4020505@ti.com>
References: <1421689942-10201-1-git-send-email-rogerq@ti.com> <20150120190237.GG15169@saruman> <54C0FBDC.6040803@ti.com> <54C10FF4.5030503@ti.com> <20150122202907.GC22288@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150122202907.GC22288-HgARHv6XitJaoMGHk7MhZQC/G2K4zDHf@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, george.cherian-l0cyMroinI0@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Felipe,

On 22/01/15 22:29, Felipe Balbi wrote:
> On Thu, Jan 22, 2015 at 04:57:56PM +0200, Roger Quadros wrote:
>>
>> On 22/01/15 15:32, Roger Quadros wrote:
>>> Felipe,
>>>
>>> On 20/01/15 21:02, Felipe Balbi wrote:
>>>> On Mon, Jan 19, 2015 at 07:52:17PM +0200, Roger Quadros wrote:
>>>>> Hi,
>>>>>
>>>>> On DRA7 EVMs the USB ID pin is connected to a GPIO line. The USB drivers
>>>>> (dwc3 + dwc3-omap) depend on extcon framework to get the USB cable state
>>>>> (USB or USB-Host) to put the controller in the right mode.
>>>>>
>>>>> There were earlier attempts [1] to get this working by trying to patch up
>>>>> the existing GPIO extcon driver.
>>>>>
>>>>> This series attemts to take a different approach by introducing a new
>>>>> USB specific extcon driver to handle the USB ID GPIO pin and
>>>>> interpret a right USB cable state.
>>>>>
>>>>> The reasoning to introduce this new driver is:
>>>>> 1) The existing GPIO extcon driver doesn't understand USB cable states
>>>>> and it can't handle more than one cable per instance.
>>>>>    
>>>>> For the USB case we need to handle at least 2 cable states.
>>>>>     a) USB (attach/detach)
>>>>>     b) USB-Host (attach/detach)
>>>>> and could possible include more states like
>>>>>     c) Fast-charger (attach/detach)
>>>>>     d) Slow-charger (attach/detach)
>>>>>     
>>>>> 2) This USB specific driver can be easily updated in the future to
>>>>> handle VBUS events, or charger detect events, in case it happens
>>>>> to be available on GPIO for any platform.
>>>>>
>>>>> 3) The DT implementation is very easy. You just need one extcon node per USB
>>>>> instead of one extcon node per cable state as in case of [1].
>>>>>
>>>>> 4) The cable state string doesn't need to be encoded in the device tree
>>>>> as in case of [1].
>>>>>
>>>>> 5) With only ID event available, you can simulate a USB-peripheral attach
>>>>> when USB-Host is detacted instead of hacking the USB driver to do the same.
>>>>>
>>>>> Tested on DRA7-evm and DRA72-evm.
>>>>
>>>> while at that, you might want to patch X15 too.
>>>>
>>> USB2 port is meant for peripheral use only. ID pin from USB port is not connected to GPIO.
>>>
>>
>> OK answering myself here :).
>> Peripheral mode doesn't work on x15-bb as the USB driver (dwc3-omap)
>> doesn't set the mailbox correctly even when dwc3 node is set as otg = "peripheral".
>>
>> Looks like we need to implement usb-gpio-extcon for x15 even though ID is hard coded.
> 
> right, another option is to have dwc3-omap read the child's DTS to check
> dr_mode and hardcode things based on that.
> 
I think that option is better as it doesn't require a GPIO line to be reserved
for ID when USB is not meant for dual-role use.

cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
