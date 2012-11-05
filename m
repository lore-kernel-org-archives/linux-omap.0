From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH V2 0/3] ARM: dts: omap5: EMIF and LPDDR2 device tree data
Date: Mon, 5 Nov 2012 11:28:25 +0530
Message-ID: <50975581.7010508@ti.com>
References: <1349959669-16366-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48609 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750961Ab2KEF6n (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Nov 2012 00:58:43 -0500
In-Reply-To: <1349959669-16366-1-git-send-email-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: b-cousson@ti.com
Cc: Lokesh Vutla <lokeshvutla@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

Hi,
On Thursday 11 October 2012 06:17 PM, Lokesh Vutla wrote:
> This patch series adds Device tree data for the EMIF
> sdram controllers in OMAP5 and LPDDR2 memory devices
> in OMAP5-evm board.
>
> Testing:
> - Boot tested on OMAP5430 evm.
> - Built EMIF as a module.
>
> Changes from v1:
> * Created a seperate dtsi file for Samsung LPDDR2 memory device
>    used in OMAP5-evm.
> * Passing reg and interrupt fields from dt for EMIF1 and EMIF2.
Gentle ping on this series.

Thanks
Lokesh
>
> Lokesh Vutla (3):
>    ARM: dts: omap5-evm: Fix size of memory defined for EVM
>    ARM: dts: omap5: EMIF device tree data for OMAP5 boards
>    ARM: dts: omap5-evm: LPDDR2 memory device details for EVM
>
>   arch/arm/boot/dts/omap5-evm.dts           |   13 +++++-
>   arch/arm/boot/dts/omap5.dtsi              |   24 +++++++++++
>   arch/arm/boot/dts/samsung_k3pe0e000b.dtsi |   67 +++++++++++++++++++++++++++++
>   3 files changed, 103 insertions(+), 1 deletion(-)
>   create mode 100644 arch/arm/boot/dts/samsung_k3pe0e000b.dtsi
>

