From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH 0/9]
Date: Tue, 24 Jun 2014 20:09:39 -0500
Message-ID: <53AA2153.1010906@ti.com>
References: <1403658065-54614-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58532 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753189AbaFYBKE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jun 2014 21:10:04 -0400
In-Reply-To: <1403658065-54614-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, Dave Gerlach <d-gerlach@ti.com>, Jassi Brar <jaswinder.singh@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On 06/24/2014 08:00 PM, Suman Anna wrote:
> Hi Tony, Paul,

Please ignore this, resent the same message and the series with the
proper subject.

regards
Suman

> 
> This patch series adds the minimal mailbox DT nodes for the SoCs that are
> currently missing them (OMAP4, AM335x, DRA7). It also limits the legacy
> mailbox platform device creation only for non-DT boot, and cleans up the
> legacy hwmod addresses and attributes used for creating the sub-mailbox
> devices. The sub-mailboxes in DT boot are not created until the OMAP
> mailbox DT adoption series, and is not an issue since some of the other
> required hwmod data for using legacy-mode devices have already been
> cleaned up.
> 
> The patches are based on 3.16-rc2. The series do not have any order
> dependencies with the OMAP mailbox cleanup series [1], and can be applied
> in any order. The following shows the boot logs on various OMAP platforms
> with just these patches on top of 3.16-rc2:
>   OMAP2 (SDP2430)           : http://slexy.org/view/s21gGdJxXP
>   OMAP3 (BeagleXM)          : http://slexy.org/view/s2n8Pc83Rp
>   OMAP4 (PandaBoard)        : http://slexy.org/view/s21StNWKPz
>   OMAP5 (OMAP5 uEVM)        : http://slexy.org/view/s2y3t6HZtk
>   DRA7  (DRA7 EVM)          : http://slexy.org/view/s2qY23Mt97
>   AM33xx (BeagleBone Black) : http://slexy.org/view/s2ce8jj35O
>   AM43xx (AM437x GP EVM)    : http://slexy.org/view/s2nttmOLSq
> 
> [1] http://marc.info/?l=linux-omap&m=140365705821115&w=2
> 
> Suman Anna (9):
>   ARM: dts: OMAP4: Add mailbox node
>   ARM: dts: AM33xx: Add mailbox node
>   ARM: dts: AM4372: Correct mailbox node data
>   ARM: dts: DRA7: Add mailbox nodes
>   ARM: DRA7: hwmod_data: Add mailbox hwmod data
>   ARM: OMAP2+: Avoid mailbox legacy device creation for DT-boot
>   ARM: OMAP2: hwmod_data: Remove legacy mailbox data and addrs
>   ARM: OMAP4: hwmod_data: Remove legacy mailbox addrs
>   ARM: AM33xx: hwmod_data: Remove legacy mailbox addrs
> 
>  arch/arm/boot/dts/am33xx.dtsi                      |   7 +
>  arch/arm/boot/dts/am4372.dtsi                      |   7 +-
>  arch/arm/boot/dts/dra7.dtsi                        |  91 ++++++
>  arch/arm/boot/dts/omap4.dtsi                       |   7 +
>  arch/arm/mach-omap2/devices.c                      |   2 +-
>  arch/arm/mach-omap2/omap_hwmod_2420_data.c         |  14 -
>  arch/arm/mach-omap2/omap_hwmod_2430_data.c         |  13 -
>  .../omap_hwmod_2xxx_3xxx_interconnect_data.c       |   9 -
>  .../omap_hwmod_33xx_43xx_interconnect_data.c       |  10 -
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |  10 -
>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c          | 305 +++++++++++++++++++++
>  arch/arm/mach-omap2/omap_hwmod_common_data.h       |   1 -
>  12 files changed, 412 insertions(+), 64 deletions(-)
> 

