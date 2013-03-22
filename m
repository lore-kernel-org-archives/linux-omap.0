From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [alsa-devel] channel swapping issue on OMAP3/TWL4030 is back
Date: Fri, 22 Mar 2013 14:04:42 +0100
Message-ID: <514C56EA.7020304@ti.com>
References: <alpine.DEB.2.01.1303220932150.7975@pmeerw.net> <alpine.DEB.2.01.1303221023070.7975@pmeerw.net> <514C2E5E.2040909@gmail.com> <alpine.DEB.2.01.1303221348250.7975@pmeerw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45494 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751698Ab3CVNFH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Mar 2013 09:05:07 -0400
In-Reply-To: <alpine.DEB.2.01.1303221348250.7975@pmeerw.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Meerwald <pmeerw@pmeerw.net>, Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Daniel Mack <zonque@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org

Hi,

On 03/22/2013 01:49 PM, Peter Meerwald wrote:
>=20
>>>> I'm running Linux 3.7 on a beagle-xm and observe very reproducible=
 stereo=20
>>>> channel swapping issue on playback of a stereo stream (one channel=
 has a=20
>>>> sine, the other is zero); the channel swap occurs on starting the =
playback
>>>
>>>> it appears that the swapping issue is back, probably due to the DM=
A rework=20
>>>> in recent kernel?
>>>
>>> kernel 3.4 does not have the issue
>>
>> Well, then, I guess, you'll have to bisect it down.
>=20
> here it is:
> 946cc36ae550ea52adee0f42ac5034a34b5393be is the first bad commit
> commit 946cc36ae550ea52adee0f42ac5034a34b5393be
> Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Date:   Fri Sep 14 15:05:58 2012 +0300
>=20
>     ASoC: omap-pcm: Convert to use dmaengine
>    =20
>     Original author: Russell King <rmk+kernel@arm.linux.org.uk>
>    =20
>     Switch the omap-pcm to use dmaengine.
>     Certain features are not supported by after dmaengine conversion:
>     1. No period wakeup mode
>        DMA engine has no way to communicate this information through
>        standard channels.
>    =20
>     Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>     Tested-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
>     Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Yes the issue surfaced again with the dmaengine conversion. But at the =
end it
boils down to the OMAP dmaengine implementation.
=46or audio to work correctly we expect that the DMA _is_ started after=
 the
omap_dma_issue_pending() call, but it is not true for OMAP.

omap_dma_issue_pending() will start a tasklet which is in charge to sta=
rt the DMA.

In audio case this is how the call chain looks like:

beagle-gentoo ~ # aplay media/2ch-left-since.wav -q
[  473.128753] omap-dma-engine omap-dma-engine: allocating channel for =
33
[  473.139587] omap_mcbsp_dai_set_dai_fmt
[  473.148345] omap_mcbsp_dai_hw_params:
[  473.155822] omap_mcbsp_config:
[  473.160369] omap_pcm_trigger: start
[  473.164062] omap_dma_prep_dma_cyclic (dma_ch: 2)
[  473.173828] omap_dma_issue_pending (dma_ch: 2)
[  473.177795] omap_mcbsp_dai_trigger: start
[  473.182006] omap_mcbsp_start
[  473.189025] omap_dma_sched
[  473.191864] omap_dma_start_sg (dma_ch: 2)

You can see that McBSP is started before the DMA because of the tasklet=
 in
drivers/dma/dma-omap.c

Russell: can we remove the tasklet use from dma-omap and start the DMA =
right
away in omap_dma_issue_pending()? This is the only way to prevent chann=
el swap
when starting audio.
Other devices might not care if the DMA is not started at the time we t=
ell it
to start, but for audio we need to make sure it is.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
