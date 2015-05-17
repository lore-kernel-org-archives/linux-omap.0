From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: High CPU usage when video streaming on EHCI, 3.17.8 kernel with
 DMA enabled
Date: Sun, 17 May 2015 10:06:11 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1505170956410.2774-100000@netrider.rowland.org>
References: <CALmG-ASRge4g6euyUEaxrLryvNR_tFSRexFSDZ5HNuzx_W4AyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CALmG-ASRge4g6euyUEaxrLryvNR_tFSRexFSDZ5HNuzx_W4AyA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tom Mises <tommises-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Sun, 17 May 2015, Tom Mises wrote:

> Hi,
> 
> I posted this on linux-uvc-devel, but was told the data transfer part
> is handled by the USB driver.
> 
> I am running 3.17.8 kernel with DMA enabled on TI DM3730 (Gumstix
> Overo Firestorm-P COM). When streaming video frames in mmap or userptr
> mode, I am
> seeing very high CPU usage, up to 70%. This CPU usage is reported to
> be in software interrupts. The captured frames are NOT corrupted.
> 
> Interestingly, when running 3.5 kernel, with DMA enabled as well, the
> CPU usage is 30% and it is reported to be mostly in the user space.
> So, it guess it suggests PIO not DMA is actually used here.

EHCI always uses DMA.  It cannot use PIO.

> Neither of these results are satisfactory, I hoped DMA would take care
> of the data transfer and the CPU resources would be available to run
> data processing.
> 
> I used the video capture example from the V4L2 API documentation. This
> behavior was tested and observed for two different cameras, one of
> them working in isochronous mode, the other working in bulk mode.
> 
> Interrupts showing activity during the streaming are:
> omap-dma-engine,
> ehci_hcd:usb1.
> 
> I also ran another test with very low resolution and fps
> settings, 160x90 5ps YUV422. In that case, on 3.5 kernel, CPU usage was
> very low. However, on 3.17.8 kernel, it was still similar as before,
> around 60% and all in software interrupts; it was dropping to zero
> intermittently this time.
> 
> Perhaps, the problem is somewhere in the interaction between the UVC
> driver and the DMA or USB driver. As far as I understand, the UVC
> driver uses vmalloc(), which, again AFAIU, is not ideal for DMA
> transfers. Is this known to work on other similar platforms?

I haven't heard complaints about the UVC driver.

> I am aware this is a somewhat vague
> description unfortunately, but I am not sure what other detail would
> be helpful. UVC debugging messages do not show anything unusual.
> Beyond that, debugging these drivers on my own exceeds my expertise,
> so I will welcome any suggestions.

You might be able to learn more from ftrace.  See the instructions in
Documentation/trace/ftrace.txt.  The "irqsoff" tracer may be the best
one to try.

> There is also the following error message from EDMA, I do not think it
> is related though.
> [    0.557342] edma-dma-engine edma-dma-engine.0: Can't allocate PaRAM
> dummy slot
> [    0.557434] edma-dma-engine: probe of edma-dma-engine.0 failed with error -22

It seems unlikely to be related.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
