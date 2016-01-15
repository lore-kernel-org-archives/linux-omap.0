From: "Thang Q. Nguyen" <tqnguyen@apm.com>
Subject: Re: [PATCH v1 1/2] usb:dwc3: Enable support for 64-bit system
Date: Fri, 15 Jan 2016 10:50:15 +0700
Message-ID: <CAKrQpStmh6NHY_eUTgU0op-cuuWRUutuVHLVXGN6YhCvzh70Cw@mail.gmail.com>
References: <1452748125-31639-1-git-send-email-tqnguyen@apm.com>
	<1452748125-31639-2-git-send-email-tqnguyen@apm.com>
	<87h9ig9n88.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87h9ig9n88.fsf@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>
Cc: Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm@lists.infradead.org, Phong Vo <pvo@apm.com>, Loc Ho <lho@apm.com>, patches@apm.com
List-Id: linux-omap@vger.kernel.org

Hi Balbi,

On Thu, Jan 14, 2016 at 10:47 PM, Felipe Balbi <balbi@kernel.org> wrote:
>
>
> Hi,
>
> "Thang Q. Nguyen" <tqnguyen@apm.com> writes:
> > Add 64-bit DMA operation support to the USB DWC3 driver.
> > First attempt to set the coherent DMA mask for 64-bit DMA.
> > If that failed, attempt again with 32-bit DMA.
> >
> > Signed-off-by: Thang Q. Nguyen <tqnguyen@apm.com>
> > ---
> >  drivers/usb/dwc3/core.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > index 22b47973..9818d6b 100644
> > --- a/drivers/usb/dwc3/core.c
> > +++ b/drivers/usb/dwc3/core.c
> > @@ -829,6 +829,21 @@ static int dwc3_probe(struct platform_device *pdev)
> >       dwc->mem = mem;
> >       dwc->dev = dev;
> >
> > +     /* Try to set 64-bit DMA first */
> > +     if (WARN_ON(!pdev->dev.dma_mask))
>
> why the WARN_ON() ?

In my opinion, pdev->dev.dma_mask is expected to be set correctly. And
the issue happen just in case of DT boot and CONFIG_DMA_CMA=n, the
pdev->dev.dma_mask value is not set. So, I set WARN_ON there to notify
that we expect pdev->dev.dma_mask set but not.

>
> > +             /* Platform did not initialize dma_mask */
> > +             ret = dma_coerce_mask_and_coherent(&pdev->dev,
> > +                                                DMA_BIT_MASK(64));
> > +     else
> > +             ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> > +
> > +     /* If seting 64-bit DMA mask fails, fall back to 32-bit DMA mask */
> > +     if (ret) {
>
> this will try 32-bit if 32-bit fails too.
There are 2 cases for dma_mask: 32-bit and 64-bit. In case the system
is 64-bit, the setting of 64-bit will return 0. Otherwise, setting
32-bit dma_mask should work.
This change is similar to commit
0ebbe398f68be0d9bbd41dcfb57319e697756b37 on
drivers/usb/host/xhci-plat.c.
>
> > +             ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> >       res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> >       if (!res) {
> >               dev_err(dev, "missing IRQ\n");
> > --
> > 2.2.0
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> --
> balbi




-- 

Thang Q. Nguyen    | Staff SW Eng.

C: +849.7684.7606 | O: +848.3770.0640

F: +848.3770.0641  | tqnguyen@apm.com
