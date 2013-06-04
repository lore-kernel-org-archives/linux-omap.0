From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/1] USB: ehci-omap: Reset dma_mask pointer on probe
Date: Tue, 4 Jun 2013 12:48:05 +0300
Message-ID: <51ADB7D5.8070708@ti.com>
References: <Pine.LNX.4.44L0.1305231009230.1459-100000@iolanthe.rowland.org> <519E2BD4.9020906@ti.com> <20130603175108.GA11188@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130603175108.GA11188-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 06/03/2013 08:51 PM, Greg KH wrote:
> On Thu, May 23, 2013 at 05:46:44PM +0300, Roger Quadros wrote:
>> On 05/23/2013 05:11 PM, Alan Stern wrote:
>>> On Thu, 23 May 2013, Roger Quadros wrote:
>>>
>>>> Device tree probed devices don't get dma_mask set. Previously
>>>> we were setting the dma_mask pointer only if it was NULL.
>>>> However, the address of 'omap_ehci_dma_mask' would change
>>>> each time the module is unloaded and loaded back thus causing
>>>> the devices dma_mask pointer to be invalid on the next load.
>>>>
>>>> This will cause page faults if any driver tries to access the
>>>> old dma_mask pointer.
>>>>
>>>> Unconditionally re-setting the dma_mask pointer fixes this problem.
>>>
>>>> diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
>>>> index 3d1491b..b33e306 100644
>>>> --- a/drivers/usb/host/ehci-omap.c
>>>> +++ b/drivers/usb/host/ehci-omap.c
>>>> @@ -146,8 +146,7 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
>>>>  	 * Since shared usb code relies on it, set it here for now.
>>>>  	 * Once we have dma capability bindings this can go away.
>>>>  	 */
>>>> -	if (!pdev->dev.dma_mask)
>>>> -		pdev->dev.dma_mask = &omap_ehci_dma_mask;
>>>> +	pdev->dev.dma_mask = &omap_ehci_dma_mask;
>>>
>>> Is this the solution that people have agreed on?  There has been a lot 
>>> of discussion on this topic.  In particular, there has been talk about 
>>> fixing it in the DT core.
>>
>> Fixing it in DT core would be best.
> 
> Then please do that.
>

It seems [1] went into 3.10-rc3 so this issue is fixed for 3.10.

[1] https://patchwork.kernel.org/patch/2537021/

cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
