From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 0/6] ARM: dts: cm-t54: enable video out, touchscreen
 and USB3.0
Date: Thu, 18 Sep 2014 09:08:26 -0700
Message-ID: <20140918160826.GE14505@atomide.com>
References: <1410885322-5928-1-git-send-email-lifshitz@compulab.co.il>
 <1410955808-2174-1-git-send-email-lifshitz@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:46760 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756150AbaIRQIl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Sep 2014 12:08:41 -0400
Content-Disposition: inline
In-Reply-To: <1410955808-2174-1-git-send-email-lifshitz@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dmitry Lifshitz <lifshitz@compulab.co.il>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Dmitry Lifshitz <lifshitz@compulab.co.il> [140917 05:10]:
> Add CM-T54 DT nodes:
> 
> * enable HDMI/DVI/LCD video output support
> * add ADS7846 touchscreen support
> * enchance DWC3 setup to enable power supply for USB3.0 OTG port
> 
> v2: * Fixed comment style issue for mux mode.
>       Follow the convention mode0_name.modeX_name for pins
>       which mux mode differs from MUX_MODE0
> 
>     * Moved aliases node to the top of dts file
> 
> Dmitry Lifshitz (6):
>   ARM: dts: sbc-t54: fix mux mode comment style
>   ARM: dts: cm-t54: fix mux mode comment style
>   ARM: dts: cm-t54: add HDMI/DVI display data
>   ARM: dts: cm-t54: add Startek LCD support
>   ARM: dts: cm-t54: add ADS7846 touchscreen support
>   ARM: dts: cm-t54: setup omap_dwc3
> 
>  arch/arm/boot/dts/omap5-cm-t54.dts  |  272 ++++++++++++++++++++++++++++++++++-
>  arch/arm/boot/dts/omap5-sbc-t54.dts |    4 +-
>  2 files changed, 272 insertions(+), 4 deletions(-)

Applying all into omap-for-v3.18/dt thanks.

Tony
