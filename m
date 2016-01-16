From: "Thang Q. Nguyen" <tqnguyen-qTEPVZfXA3Y@public.gmane.org>
Subject: Re: [PATCH v1 1/2] usb:dwc3: Enable support for 64-bit system
Date: Sat, 16 Jan 2016 11:00:31 +0700
Message-ID: <CAKrQpStE56vGFFJ0_Jj9FHQLcSmx7Tk7UbMLk8qf6aP9t+jjKA@mail.gmail.com>
References: <1452748125-31639-1-git-send-email-tqnguyen@apm.com>
	<1452748125-31639-2-git-send-email-tqnguyen@apm.com>
	<87h9ig9n88.fsf@ti.com>
	<CAKrQpStmh6NHY_eUTgU0op-cuuWRUutuVHLVXGN6YhCvzh70Cw@mail.gmail.com>
	<8760yu6w40.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <8760yu6w40.fsf-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Phong Vo <pvo-qTEPVZfXA3Y@public.gmane.org>, Loc Ho <lho-qTEPVZfXA3Y@public.gmane.org>, patches-qTEPVZfXA3Y@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Balbi,
Thanks for your review and feedback.
I will remove WARN_ON() as in your feedback. I will wait some days to
see if any more comments before sending out an updated patch.

Thanks,
Thang Q. Nguyen
On Sat, Jan 16, 2016 at 10:28 AM, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>
> Hi,
>
> "Thang Q. Nguyen" <tqnguyen-qTEPVZfXA3Y@public.gmane.org> writes:
>> Hi Balbi,
>>
>> On Thu, Jan 14, 2016 at 10:47 PM, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>>>
>>>
>>> Hi,
>>>
>>> "Thang Q. Nguyen" <tqnguyen-qTEPVZfXA3Y@public.gmane.org> writes:
>>> > Add 64-bit DMA operation support to the USB DWC3 driver.
>>> > First attempt to set the coherent DMA mask for 64-bit DMA.
>>> > If that failed, attempt again with 32-bit DMA.
>>> >
>>> > Signed-off-by: Thang Q. Nguyen <tqnguyen-qTEPVZfXA3Y@public.gmane.org>
>>> > ---
>>> >  drivers/usb/dwc3/core.c | 15 +++++++++++++++
>>> >  1 file changed, 15 insertions(+)
>>> >
>>> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>>> > index 22b47973..9818d6b 100644
>>> > --- a/drivers/usb/dwc3/core.c
>>> > +++ b/drivers/usb/dwc3/core.c
>>> > @@ -829,6 +829,21 @@ static int dwc3_probe(struct platform_device *pdev)
>>> >       dwc->mem = mem;
>>> >       dwc->dev = dev;
>>> >
>>> > +     /* Try to set 64-bit DMA first */
>>> > +     if (WARN_ON(!pdev->dev.dma_mask))
>>>
>>> why the WARN_ON() ?
>>
>> In my opinion, pdev->dev.dma_mask is expected to be set correctly. And
>
> sure is, but a WARN_ON() will print out a stack dump, which looks
> scary. Besides, if it's not set you're already fixing the problem.
>
>> the issue happen just in case of DT boot and CONFIG_DMA_CMA=n, the
>> pdev->dev.dma_mask value is not set. So, I set WARN_ON there to notify
>
> why isn't it set ?
>
>> that we expect pdev->dev.dma_mask set but not.
>
> why don't you fix that case, instead ?
>
> --
> balbi



-- 

Thang Q. Nguyen    | Staff SW Eng.

C: +849.7684.7606 | O: +848.3770.0640

F: +848.3770.0641  | tqnguyen-qTEPVZfXA3Y@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
