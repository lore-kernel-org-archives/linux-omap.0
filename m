From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/2] usb: dwc3: drop FIFO resizing logic
Date: Wed, 10 Feb 2016 15:47:17 +0530
Message-ID: <56BB0E2D.1030600@ti.com>
References: <1454588282-14383-1-git-send-email-balbi@kernel.org>
 <56B4C8B0.9070909@ti.com> <87h9hgswjw.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87h9hgswjw.fsf-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nm-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Wednesday 10 February 2016 03:43 PM, Felipe Balbi wrote:
> 
> Hi,
> 
> Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org> writes:
>> Hi Felipe,
>>
>> On Thursday 04 February 2016 05:48 PM, Felipe Balbi wrote:
>>> That FIFO resizing logic was added to support OMAP5
>>> ES1.0 which had a bogus default FIFO size. I can't
>>> remember the exact size of default FIFO, but it was
>>> less than one bulk superspeed packet (<1024) which
>>> would prevent USB3 from ever working on OMAP5 ES1.0.
>>>
>>> However, OMAP5 ES1.0 support has been dropped by
>>> commit aa2f4b16f830 ("ARM: OMAP5: id: Remove ES1.0
>>> support") which renders FIFO resizing unnecessary.
>>>
>>> Signed-off-by: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>>
>> tested this series on both dra7-evm and dra72-evm using mass storage gadget and
>> msc.sh
> 
> both HS and SS ?

yes.. but the logs here were for only SS.
> 
>> dra72-evm: http://pastebin.ubuntu.com/14887997/
>> dra7-evm: http://pastebin.ubuntu.com/14887975/
>>
>> Tested-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
>>
>> Let me know if you want me to do any other testing on dra7.
> 
> yeah, run testusb for a week or so, that usually catches odd bugs.

Okay. I'll start the test before I go for vacation next week.

Thanks
Kishon
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
