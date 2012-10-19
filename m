From: =?ISO-8859-1?Q?P=E9ter_Ujfalusi?= <peter.ujfalusi@ti.com>
Subject: Re: [RFC] dmaengine: omap-dma: Allow DMA controller to prefetch data
Date: Fri, 19 Oct 2012 14:45:55 +0200
Message-ID: <50814B83.7090203@ti.com>
References: <20121018222046.GA28541@animalcreek.com> <20121018225540.GB28061@n2100.arm.linux.org.uk> <20121018232405.GA29064@animalcreek.com> <20121018233335.GC28061@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44469 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758601Ab2JSMqp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Oct 2012 08:46:45 -0400
In-Reply-To: <20121018233335.GC28061@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "Mark A. Greer" <mgreer@animalcreek.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jarkko Nikula <jarkko.nikula@bitmer.com>

Hi,

On 10/19/2012 01:33 AM, Russell King - ARM Linux wrote:
> I would suggest getting some feedback from the ASoC people first, bef=
ore
> trying to invent new APIs to work around this stuff.  If they can liv=
e
> with having prefetch enabled on OMAP then there isn't an issue here. =
 If
> not, we need a solution to this.
>=20
> I do not believe that precisely stopping and starting playback across=
 a
> suspend/resume event is really necessary (it's desirable but the worl=
d
> doesn't collapse if you miss a few samples.)  It could be more of an
> issue for pause/resume though, but as I say, that's for ASoC people t=
o
> comment on.

There is another issue with the prefetch in audio:
we tend to like to know the position of the DMA and also to know how mu=
ch data
we have stored in buffers, FIFOs. This information is used by userspace=
 to do
echo cancellation and also used by PA for example to do runtime mixing
directly in the audio buffer. We have means to extract this information=
 from
McBSP for example (and from tlv320dac33 codec) but AFAIK this informati=
on can
not be retrieved from sDMA.
We could assume that the sDMA FIFO is kept full and report that as a 'd=
elay'
or do not account this information.

=46or now I think the cyclic mode should not set the prefetch. If I rec=
all right
the cyclic mode is only used by audio at the moment.

> I'm merely pointing out here that we need their feedback here before
> deciding if there's anything further that needs to happen.

Thanks Russell, I'll take a look at the implication of the prefetch for=
 audio.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
