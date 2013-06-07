From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL v2] ARM: dts: OMAP fixes for 3.10-rc5
Date: Fri, 7 Jun 2013 15:07:07 -0700
Message-ID: <20130607220706.GO3331@atomide.com>
References: <51ACA9FA.9000308@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:25621 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755822Ab3FGWHK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jun 2013 18:07:10 -0400
Content-Disposition: inline
In-Reply-To: <51ACA9FA.9000308@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Kevin Hilman <khilman@linaro.org>, Lars Poeschel <poeschel@lemonage.de>, Suman Anna <s-anna@ti.com>

* Benoit Cousson <b-cousson@ti.com> [130603 07:42]:
> Hi Tony,
> 
> Please pull three DTS fixes for the next -rc.

Thanks pulling into omap-for-v3.10/fixes.

Regards,

Tony
 
> The following changes since commit d683b96b072dc4680fc74964eca77e6a23d1fa6e:
>   Linus Torvalds (1):
>         Linux 3.10-rc4
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git dts-fixes-for-3.10
> 
> Kevin Hilman (1):
>       ARM: dts: omap4-panda|sdp: Fix mux for twl6030 IRQ pin and msecure line
> 
> Lars Poeschel (1):
>       ARM: dts: AM33xx: Fix properties on gpmc node
> 
> Suman Anna (1):
>       ARM: dts: OMAP5: Fix missing PWM capability to timer nodes
> 
>  arch/arm/boot/dts/am33xx.dtsi             |    4 ++--
>  arch/arm/boot/dts/omap4-panda-common.dtsi |   20 ++++++++++++++++++++
>  arch/arm/boot/dts/omap4-sdp.dts           |   20 ++++++++++++++++++++
>  arch/arm/boot/dts/omap5.dtsi              |    3 +++
>  4 files changed, 45 insertions(+), 2 deletions(-)
