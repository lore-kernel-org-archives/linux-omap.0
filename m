From: "Ujfalusi, Peter" <peter.ujfalusi@ti.com>
Subject: Re: Audio support on OMAP 3430LDP or 4430SDP boards
Date: Fri, 27 Apr 2012 18:53:39 +0300
Message-ID: <CAPo=G1ze3Yfr5FyQG_nByT3b5k=+Ux+6aupg=dD1Qe-Zx1RiqQ@mail.gmail.com>
References: <20120427135802.GA28062@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:38101 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932294Ab2D0Pxl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Apr 2012 11:53:41 -0400
Received: by yhoo21 with SMTP id o21so778279yho.4
        for <linux-omap@vger.kernel.org>; Fri, 27 Apr 2012 08:53:39 -0700 (PDT)
In-Reply-To: <20120427135802.GA28062@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

Hi Russell,

On Fri, Apr 27, 2012 at 4:58 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Can someone please hint on what audio is supported on these two OMAP
> boards? =A0From what I can tell, the answer is either "nothing" or "h=
dmi",
> both of which are useless to me if someone wants me to convert the OM=
AP
> ASoC driver to DMA engine.
>
> From what I can see on the 4430SDP, there's a 3.5mm headset jack,
> microphones and speakers on the board, so the board does have audio
> hardware. =A0However, it seems (as, I'm afraid to say, seems to be pr=
etty
> much standard practice with OMAP) there's a total lack of software
> support in mainline.

3.4-rc have audio support for SDP4430/Blaze, PandaBoard4430,
PandaBoardES (4460).
OMAP3 support is there for a long time, not sure about 3430LDP, but
the omap3-SDP,
BeagleBoards, Nokia n900, Pandora have at least ASoC machine driver.

> This kind'a prevents me testing changes to the DMA support for OMAP
> ASoC...

The ASoC driver for DMA: sound/soc/omap/omap-pcm.c
We also have dma engine support in the ASoC core:
sound/soc/soc-dmaengine-pcm.c
It provides some level of abstraction for us to use DMA engine with aud=
io.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
