From: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: Re: High CPU usage when video streaming on EHCI, 3.17.8 kernel with
 DMA enabled
Date: Mon, 18 May 2015 10:27:15 +0200
Message-ID: <20150518102715.34e29c33@perruche.parrot.biz>
References: <CALmG-ASRge4g6euyUEaxrLryvNR_tFSRexFSDZ5HNuzx_W4AyA@mail.gmail.com>
	<Pine.LNX.4.44L0.1505170956410.2774-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.aswsp.com ([193.34.35.150]:40232 "EHLO mail.aswsp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752794AbbERIcL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 May 2015 04:32:11 -0400
In-Reply-To: <Pine.LNX.4.44L0.1505170956410.2774-100000@netrider.rowland.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Tom Mises <tommises@gmail.com>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org

Hi,

last time I checked uvc driver, it was doing memcpy of video buffer : s=
ee uvc_video_decode_data.

It your video resolution is big, this can eat lot's of cpu.

Doing a trace should help you.

Matthieu




Le Sun, 17 May 2015 10:06:11 -0400,
Alan Stern <stern@rowland.harvard.edu> a =C3=A9crit :

> On Sun, 17 May 2015, Tom Mises wrote:
>=20
> > Hi,
> >=20
> > I posted this on linux-uvc-devel, but was told the data transfer pa=
rt
> > is handled by the USB driver.
> >=20
> > I am running 3.17.8 kernel with DMA enabled on TI DM3730 (Gumstix
> > Overo Firestorm-P COM). When streaming video frames in mmap or user=
ptr
> > mode, I am
> > seeing very high CPU usage, up to 70%. This CPU usage is reported t=
o
> > be in software interrupts. The captured frames are NOT corrupted.
> >=20
> > Interestingly, when running 3.5 kernel, with DMA enabled as well, t=
he
> > CPU usage is 30% and it is reported to be mostly in the user space.
> > So, it guess it suggests PIO not DMA is actually used here.
>=20
> EHCI always uses DMA.  It cannot use PIO.
>=20
> > Neither of these results are satisfactory, I hoped DMA would take c=
are
> > of the data transfer and the CPU resources would be available to ru=
n
> > data processing.
> >=20
> > I used the video capture example from the V4L2 API documentation. T=
his
> > behavior was tested and observed for two different cameras, one of
> > them working in isochronous mode, the other working in bulk mode.
> >=20
> > Interrupts showing activity during the streaming are:
> > omap-dma-engine,
> > ehci_hcd:usb1.
> >=20
> > I also ran another test with very low resolution and fps
> > settings, 160x90 5ps YUV422. In that case, on 3.5 kernel, CPU usage=
 was
> > very low. However, on 3.17.8 kernel, it was still similar as before=
,
> > around 60% and all in software interrupts; it was dropping to zero
> > intermittently this time.
> >=20
> > Perhaps, the problem is somewhere in the interaction between the UV=
C
> > driver and the DMA or USB driver. As far as I understand, the UVC
> > driver uses vmalloc(), which, again AFAIU, is not ideal for DMA
> > transfers. Is this known to work on other similar platforms?
>=20
> I haven't heard complaints about the UVC driver.
>=20
> > I am aware this is a somewhat vague
> > description unfortunately, but I am not sure what other detail woul=
d
> > be helpful. UVC debugging messages do not show anything unusual.
> > Beyond that, debugging these drivers on my own exceeds my expertise=
,
> > so I will welcome any suggestions.
>=20
> You might be able to learn more from ftrace.  See the instructions in
> Documentation/trace/ftrace.txt.  The "irqsoff" tracer may be the best
> one to try.
>=20
> > There is also the following error message from EDMA, I do not think=
 it
> > is related though.
> > [    0.557342] edma-dma-engine edma-dma-engine.0: Can't allocate Pa=
RAM
> > dummy slot
> > [    0.557434] edma-dma-engine: probe of edma-dma-engine.0 failed w=
ith error -22
>=20
> It seems unlikely to be related.
>=20
> Alan Stern
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
