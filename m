From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH v2 0/8] ARM/dts: OMAP audio related updates for OMAP2/3/4/5
Date: Mon, 3 Sep 2012 16:51:57 +0200
Message-ID: <5044C40D.4060406@ti.com>
References: <1346247067-9632-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45129 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932200Ab2ICOwd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Sep 2012 10:52:33 -0400
In-Reply-To: <1346247067-9632-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

Hi Peter,

On 08/29/2012 03:30 PM, Peter Ujfalusi wrote:
> Hello,
> 
> I have extended and rebased the previous set:
> 'ARM/dts: omap McBSP and audio support for BeagleBoard'
> 
> Changes since v1:
> - Rebased on current l-o:devel-dt branch
> - Two new patch, one for OMAP4 to add reg-names for the mem areas, one for OMAP5
>   to add McPDM and DMIC section
> 
> The rest of the series remaind the same: adds the McBSP sections to OMAP2/3/4/5
> and also enable the audio support for BeagleBoard when booting with DT.

Beside the OMAP 2&3 interrupt comment, the series looks good to me.

If you can repost, I'll queue it for Tony for 3.7 along with Sourav's one.

BTW, do you have any dependency with ASoC series?

Thanks,
Benoit


> 
> Regards,
> Peter
> ---
> Peter Ujfalusi (8):
>   ARM/dts: OMAP2: Add McBSP entries for OMAP2420 and OMAP2430 SoC
>   ARM/dts: omap2420-h4: Include omap2420.dtsi file instead the common
>     omap2
>   ARM/dts: OMAP3: Add McBSP entries
>   ARM/dts: OMAP4: Add McBSP entries
>   ARM/dts: OMAP5: Add McBSP entries
>   ARM/dts: omap3-beagle: Enable audio support
>   ARM/dts: omap4: Add reg-names for McPDM and DMIC
>   ARM/dts: omap5: Add McPDM and DMIC section to the dtsi file
> 
>  arch/arm/boot/dts/omap2420-h4.dts  |    2 +-
>  arch/arm/boot/dts/omap2420.dtsi    |   39 +++++++++++++++++
>  arch/arm/boot/dts/omap2430.dtsi    |   83 ++++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/omap3-beagle.dts |   14 ++++++
>  arch/arm/boot/dts/omap3.dtsi       |   69 ++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/omap4.dtsi       |   49 +++++++++++++++++++++
>  arch/arm/boot/dts/omap5.dtsi       |   56 ++++++++++++++++++++++++
>  7 files changed, 311 insertions(+), 1 deletions(-)
>  create mode 100644 arch/arm/boot/dts/omap2420.dtsi
>  create mode 100644 arch/arm/boot/dts/omap2430.dtsi
> 

