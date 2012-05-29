From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [GIT PULL] ARM: OMAP2+: Add AM335x and AM3517/05 EVM DT support
Date: Tue, 29 May 2012 06:16:39 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA39262@DBDE01.ent.ti.com>
References: <4FAD0A71.80201@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57751 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751291Ab2E2GQn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 May 2012 02:16:43 -0400
In-Reply-To: <4FAD0A71.80201@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, May 11, 2012 at 18:17:45, Cousson, Benoit wrote:
> Hi Tony,
> 
> Here are some remaining DT patches I was not able to push at 3.4 due to some missing dependency.
> It applies now fine on top of lo/dt branch.
> 
> Regards,
> Benoit
> 
> 
> The following changes since commit 40364b9f5a4d167d97bb6a76cd239ca8cfff056a:
>   Benoit Cousson (1):
>         arm/dts: omap4-panda: Add LEDs support
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git for_3.5/dts/am33xx
> 
> Vaibhav Hiremath (3):
>       arm/dts: Add support for TI AM335x EVM board
>       arm/dts: omap3-evm: Add i2c and twl4030 support
>       arm/dts: Add support for TI AM3517/05 EVM board
> 
>  arch/arm/boot/dts/am335x-evm.dts |   39 ++++++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/am3517-evm.dts |   32 +++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/omap3-evm.dts  |   28 +++++++++++++++++++++++++++
>  3 files changed, 99 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/boot/dts/am335x-evm.dts
>  create mode 100644 arch/arm/boot/dts/am3517-evm.dts
> 


Tony (and Benoit),

Can this patch merged into your "dt" branch??? And into "master" as well, so that we can be sure that, it goes in next merge window.

Thanks,
Vaibhav

