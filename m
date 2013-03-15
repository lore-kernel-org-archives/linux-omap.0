From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH V2 0/2] ASoC: OMAP2+: Update Audio IP with sDMA binding
 for DT boot
Date: Fri, 15 Mar 2013 15:27:58 +0100
Message-ID: <51432FEE.4060709@ti.com>
References: <1362988223-22455-1-git-send-email-s-guiriec@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47412 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754767Ab3COO20 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Mar 2013 10:28:26 -0400
In-Reply-To: <1362988223-22455-1-git-send-email-s-guiriec@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastien Guiriec <s-guiriec@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org

Hi Seb,

On 03/11/2013 08:50 AM, Sebastien Guiriec wrote:
> This patch serie is converting OMAP Audio IPs in order to use OMAP sDMA DT
> binding in case of DT boot on OMAP2+ platforms.
> 
> It is depending on the next patches:
> 
> [1] http://www.spinics.net/lists/arm-kernel/msg227836.html
> [2] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg84668.html

I've just applied it in my for_3.10/dts branch on top of Jon's series
that does add the SDMA binding.

Regards,
Benoit

> 
> It has been tested on:
> - OMAP5 (sEVM/panda)in DT boot (McPDM/DMIC).
> - OMAP4 (SDP4430/Panda) in both DT/non DT boot (McPDM/DMIC)
> - OMAP3 (Beagle XM) in both DT/non DT boot (McBSP)
> 
> Update since v1:
> - Put DTS patch in first.
> - Squash all OMAP IPs patch together.
> 
> Sebastien Guiriec (2):
>   ARM: dts: OMAP2+: Add SDMA Audio IPs bindings
>   ASoC: OMAP2+: Move McBSP, DMIC and McPDM to generic DMA DT binding
> 
>  arch/arm/boot/dts/omap2420.dtsi |    6 ++++++
>  arch/arm/boot/dts/omap2430.dtsi |   15 +++++++++++++++
>  arch/arm/boot/dts/omap3.dtsi    |   15 +++++++++++++++
>  arch/arm/boot/dts/omap4.dtsi    |   17 +++++++++++++++++
>  arch/arm/boot/dts/omap5.dtsi    |   14 ++++++++++++++
>  sound/soc/omap/mcbsp.c          |   26 ++++++++++++++++----------
>  sound/soc/omap/omap-dmic.c      |   15 +++++++++------
>  sound/soc/omap/omap-mcpdm.c     |   22 ++++++++++++++--------
>  sound/soc/omap/omap-pcm.c       |   12 ++++++++++--
>  sound/soc/omap/omap-pcm.h       |    1 +
>  10 files changed, 117 insertions(+), 26 deletions(-)
> 

