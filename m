From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 1/5] doc: Add "ti,am437x-dwc3" comaptible for dwc3
 glue
Date: Thu, 13 Mar 2014 14:17:09 +0200
Message-ID: <5321A1C5.8020501@ti.com>
References: <1394193422-18242-1-git-send-email-george.cherian@ti.com> <1394193422-18242-2-git-send-email-george.cherian@ti.com> <53218944.7000102@ti.com> <53219970.6060002@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <53219970.6060002-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: balbi-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, anatol.pomozov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 03/13/2014 01:41 PM, George Cherian wrote:
> On 3/13/2014 4:02 PM, Roger Quadros wrote:
>> Hi George,
>>
>> On 03/07/2014 01:56 PM, George Cherian wrote:
>>> Add the compatible "ti,am437x-dwc3" for dwc3 glue driver.
>>>
>>> Signed-off-by: George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>
>>> ---
>>>   Documentation/devicetree/bindings/usb/omap-usb.txt | 4 +++-
>>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/usb/omap-usb.txt b/Documentation/devicetree/bindings/usb/omap-usb.txt
>>> index 38b2fae..38d9bb8 100644
>>> --- a/Documentation/devicetree/bindings/usb/omap-usb.txt
>>> +++ b/Documentation/devicetree/bindings/usb/omap-usb.txt
>>> @@ -44,7 +44,9 @@ Board specific device node entry
>>>   };
>>>     OMAP DWC3 GLUE
>>> - - compatible : Should be "ti,dwc3"
>>> + - compatible : Should be
>>> +    * "ti,dwc3" for OMAP5 and DRA7
>>> +    * "ti,am437x-dwc3" for AM437x
>> Why do you need a new compatible for am437x? Isn't "ti,dwc3" sufficient?
> 
> There is change in register offsets for AM437x as comapred to Omap5 and dra7x.
> The compatible is already added in dwc3-omap.c  This patch just updates the Documentation.

Oh ok. Then it is fine. You can add my.

Acked-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>

cheers,
-roger
>>
>>>    - ti,hwmods : Should be "usb_otg_ss"
>>>    - reg : Address and length of the register set for the device.
>>>    - interrupts : The irq number of this device that is used to interrupt the
>>>
>> cheers,
>> -roger
> 
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
