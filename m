From: Greg Knight <g.knight@symetrica.com>
Subject: Re: Patch to parameterize DMA_MIN_BYTES for omap2-mcspi
Date: Thu, 19 Mar 2015 09:16:31 -0400
Message-ID: <CAAQQ3un3k-0nY8xaOXKbmCznOk69ZEhbWLd5ZZV1_=rQLOyspg@mail.gmail.com>
References: <1426741501.10003.6.camel@midgaarde>
	<550AC256.4070509@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from claranet-outbound-smtp02.uk.clara.net ([195.8.89.35]:42307 "EHLO
	claranet-outbound-smtp02.uk.clara.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754949AbbCSNQg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Mar 2015 09:16:36 -0400
In-Reply-To: <550AC256.4070509@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Greg Knight <g.knight@symetrica.com>, Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Will refer to that documentation and update the SPI docs before resubmi=
tting.

Re; Threshold of 160 is artificial: Believe me, I am more than aware
of this. SPI runs in any speed from low kHz to multi MHz. The only
reason I can fathom for having such a high DMA_MIN_BYTES is to
facilitate high-speed low-volume communication (eg read one byte at a
time from userspace without buffering.) The reason I'm looking at this
at all is because we're doing low-speed low-volume communication, for
which the burn in PIO mode causes severe performance degradation.
Internally we'd changed it to 20, but I might try 8. I originally
tried 0, but observed poor behavior for our use cases. DMA_MIN_BYTES
at 8 would be sensible for our application, but at 160 it is not.

The current solution is for everybody who needs to change their device
settings to churn that macro, just as 8b66c1474e16 did. Changing that
values incurs significant risk of excess CPU load (if increased) or
timing slop (if decreased) to all hardware using the McSPI. Moving the
param to DT allows those of us working on custom boards to modify the
value for some hardware without risking the entire ecosystem. Let's
please not keep a bad solution just because no perfect solution
exists...

I think the proper location for this patch might actually be in the
spidev nodes in DT, rather than at the mcspi level - but I don't
understand why this does not belong in DT. DT is, after all, where one
would normally describe the rest of the slave device bindings. A
sensible value for DMA_MIN_BYTES requires the user to know the CPU
clock speed alongside the SPI bus speed, and estimate acceptable
levels of slop in timing. I don't think userspace should need to do
these computations to avoid excess CPU load; could do it in kernel
space, or leave it up to DT or kernel parameters.

How about moving the speed to the spidev DT nodes?

Regards,
Greg


On Thu, Mar 19, 2015 at 8:34 AM, Peter Ujfalusi <peter.ujfalusi@ti.com>=
 wrote:
>
> On 03/19/2015 07:05 AM, Greg Knight wrote:
> > Hi, Mark,
> >
> > I've attached a patch which adds a device-tree field "ti,dma-min-by=
tes"
> > which replaces the macro DMA_MIN_BYTES. Adjusting this field addres=
ses
> > issues we've had where, in our particular use case, the usleep() in=
 the
> > SPI worker thread eats a full 20% of our CPU (AM3359).
> >
> > I opted to implement it as a device-tree parameter and keep the ori=
ginal
> > value (160) as the default, in order to avoid impacting anyone else=
=2E
> >
> > The patch is attached. Patches 1-2 are an unrelated McASP change (s=
ee my
> > other message).
> >
> > What is the process for getting this upstreamed?
>
> Please follow the guidelines in Documentation/SubmittingPatches. Patc=
hes as
> attachments are not preferred since it makes replying/commenting on t=
he
> patches hard.
>
> Strictly speaking the dma-min-bytes should not be in DT, it is a soft=
ware
> parameter for the Linux SPI driver implementation.
> Also, when changing DT bindings, please update the documentation as w=
ell (and
> CC the relevant lists with that).
>
> This threshold of 160 bytes in the omap2-mcspi driver is artificial a=
nyways it
> is changed from 8 to 160 by this commit:
> 8b66c13474e16 spi/omap2_mcspi: change default DMA_MIN_BYTES value to =
160
>
> It has been changed because of wl1271, but I'm not sure if banging by=
tes over
> the bus when the transfer is less then 160bytes is that great thing. =
I would
> guess that the sweet spot is at around the low tens.
>
> But if it is really like this that different devices perform better w=
ith
> different threshold for choosing between PIO or DMA transfer then thi=
s setting
> should come from the slave device and should only affect the transfer=
 setup
> when communicating with that device.
>
> Probably adding a parameter (optional) to spi_device struct, so drive=
rs can
> pass dma_over_poi_threshold?
> If it is not set, than just use whatever is the default.
>
> But I don't think this setting should be in the DT.
>
> --
> P=C3=A9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
