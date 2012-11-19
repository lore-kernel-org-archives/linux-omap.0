From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [RFC] dmaengine: omap-dma: Allow DMA controller to prefetch data
Date: Mon, 19 Nov 2012 11:00:15 +0100
Message-ID: <50AA032F.1010102@ti.com>
References: <20121018222046.GA28541@animalcreek.com> <20121018225540.GB28061@n2100.arm.linux.org.uk> <20121018232405.GA29064@animalcreek.com> <20121018233335.GC28061@n2100.arm.linux.org.uk> <50814B83.7090203@ti.com> <20121117113159.GM3332@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51381 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753315Ab2KSKBF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Nov 2012 05:01:05 -0500
In-Reply-To: <20121117113159.GM3332@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "Mark A. Greer" <mgreer@animalcreek.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jarkko Nikula <jarkko.nikula@bitmer.com>

On 11/17/2012 12:31 PM, Russell King - ARM Linux wrote:
> On Fri, Oct 19, 2012 at 02:45:55PM +0200, P=E9ter Ujfalusi wrote:
>> Hi,
>>
>> On 10/19/2012 01:33 AM, Russell King - ARM Linux wrote:
>>> I'm merely pointing out here that we need their feedback here befor=
e
>>> deciding if there's anything further that needs to happen.
>>
>> Thanks Russell, I'll take a look at the implication of the prefetch =
for audio.
>=20
> P=E9ter, any news?

Sorry, I was carried away with other things...
I did some testing with and without the dma prefetch for audio (on Beag=
leBoard
with mplayer: -ao alsa/pulse).
When we have prefetch enabled we tend to resume after pause from a slig=
htly
off place than when the prefetch is disabled.
I also remember that in n9 we have had some issue with the DMA prefetch=
=2E

So I would for sure enable the prefetch for non cyclic DMA.
=46or the cyclic I would not enable it for now. I need to dig a bit dee=
per in
DMA/McBSP to have better view on the issue.

I have one comment to the patch itself as well.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
