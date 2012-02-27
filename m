From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [GIT PULL] ARM: OMAP: DTS updates
Date: Mon, 27 Feb 2012 17:34:42 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A8317E051A@DBDE01.ent.ti.com>
References: <4F480A60.6070208@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58898 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753324Ab2B0Ret convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Feb 2012 12:34:49 -0500
In-Reply-To: <4F480A60.6070208@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>, tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Grant Likely <grant.likely@secretlab.ca>

On Sat, Feb 25, 2012 at 03:38:32, Cousson, Benoit wrote:
> Hi Tony,
> 
> Here are a couple of DTS files updates for 3.4.
> 
> Vaibhav sent a couple more DTS but they are still pending Grant's Acked-by.
> 

Grant,

Can you please ack the patches I had submitted, so that Benoit can queue it?

arm/dts: Add support for TI AM3517/05 EVM board
arm/dts: omap3-evm: Add i2c and twl4030 support
arm/dts: Add support for TI AM335x EVM board
ARM: OMAP2+: board-generic: Add DT support for AM33xx devices

Thanks,
Vaibhav

> Thanks,
> Benoit
> 
> 
> The following changes since commit b01543dfe67bb1d191998e90d20534dc354de059:
>   Linus Torvalds (1):
>         Linux 3.3-rc4
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git for_3.4/dts_updates
> 
> Benoit Cousson (3):
>       arm/dts: OMAP4: Add i2c controller nodes
>       arm/dts: OMAP3: Add i2c controller nodes
>       arm/dts: OMAP4: Update DTS file with new GIC bindings
> 
> Vaibhav Hiremath (1):
>       arm/dts: Add support for TI OMAP3 EVM board
> 
>  arch/arm/boot/dts/omap3-evm.dts |   20 ++++++++++++++++++++
>  arch/arm/boot/dts/omap3.dtsi    |   21 +++++++++++++++++++++
>  arch/arm/boot/dts/omap4.dtsi    |   30 +++++++++++++++++++++++++++++-
>  3 files changed, 70 insertions(+), 1 deletions(-)
>  create mode 100644 arch/arm/boot/dts/omap3-evm.dts
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

