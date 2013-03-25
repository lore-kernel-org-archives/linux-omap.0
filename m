From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [alsa-devel] channel swapping issue on OMAP3/TWL4030 is back
Date: Mon, 25 Mar 2013 13:39:29 +0100
Message-ID: <51504581.10400@ti.com>
References: <alpine.DEB.2.01.1303220932150.7975@pmeerw.net> <alpine.DEB.2.01.1303221023070.7975@pmeerw.net> <514C2E5E.2040909@gmail.com> <alpine.DEB.2.01.1303221348250.7975@pmeerw.net> <514C56EA.7020304@ti.com> <20130322163506.GL30923@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44187 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757168Ab3CYMjy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Mar 2013 08:39:54 -0400
In-Reply-To: <20130322163506.GL30923@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Peter Meerwald <pmeerw@pmeerw.net>, Daniel Mack <zonque@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org

On 03/22/2013 05:35 PM, Russell King - ARM Linux wrote:
> On Fri, Mar 22, 2013 at 02:04:42PM +0100, Peter Ujfalusi wrote:
>> Russell: can we remove the tasklet use from dma-omap and start the D=
MA right
>> away in omap_dma_issue_pending()? This is the only way to prevent ch=
annel
>> swap when starting audio.
>=20
> What I fear is that we may run up against having too many DMA channel=
s
> tied up to the peripherals.  I structured the driver in this way to
> allow us to move the physical DMA channel allocation to that tasklet
> when that becomes a problem.
>=20
> Not only that but I was hoping to lift some more of this code out of
> DMA engine drivers, so DMA engine drivers had even less code in them.

Not sure what you mean by this. Move dmaengine core's issue_pending to =
a
tasklet or is only OMAP internal restructuring?

> I guess we could keep the tasklet, but mark the audio DMA channels as
> "pre-reserved" and arrange for pre-reserved channels to avoid the
> tasklet, rather than throwing the tasklet out completely.

Not sure if we really want to pre-reserve the DMA channels for audio:
on OMAP3 we have 5 McBSP -> 10 DMA channels
on OMAP4 we have 4 McBSP, one McPDM, one DMIC and one McASP + we have t=
he
AESS/ABE -> 8 + 2 + 1 + 1 + 8 (AESS/ABE).
Do we really want to pre-allocate DMA channel for all of these?

We could look omap_chan.cyclic which gives good indication that the cha=
nnel is
used for audio since only audio is using cyclic mode.

I have a patch which removes the tasklet from omap-dma.c and it is work=
ing
fine on my systems (OMAP3 Zoom2, BeagleBoard, OMAP4 PandBoard, OMAP4 Bl=
aze).

I can modify it to not remove the taskelt, but when the omap_chan.cycli=
c is
true we would instead of starting the tasklet we just start the DMA rig=
ht away.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
