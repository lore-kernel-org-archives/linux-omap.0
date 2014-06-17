From: Nishanth Menon <nm@ti.com>
Subject: Re: [RFC PATCH 0/7] ARM: OMAP4+: PRM: minor cleanups and dt support
 of interrupts
Date: Tue, 17 Jun 2014 10:38:48 -0500
Message-ID: <53A06108.9010108@ti.com>
References: <1402025761-16831-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58098 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933122AbaFQPjP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Jun 2014 11:39:15 -0400
In-Reply-To: <1402025761-16831-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?ISO-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On 06/05/2014 10:35 PM, Nishanth Menon wrote:
> 
> Hi,
> 
> The following series is a minimal set of cleanups and generalization
> in the direction of supporting daisychain wakeup on all OMAP4+
> platforms. We cannot still add IO_WAKEUP ability for OMAP5/DRA7/AM437x
> yet pending further pinctrl patches.
> 
> These do have a few cosmetic issues, but hope is to get a view about
> the approach. Also note that documentation of bindings for ti,dra7-prm
> etc are still pending.
> 
> Nishanth Menon (7):
>   ARM: OMAP4+: prminst: provide function to find prm_dev instance
>     offset
>   ARM: OMAP4: prm use the generic prm_inst to allow logic to be
>     abstracted
>   ARM: OMAP4+: PRM: remove "wkup" event
>   ARM: OMAP4+: PRM: register interrupt information from DT
>   ARM: dts: OMAP4: Add PRM interrupt
>   ARM: dts: OMAP5: add PRM interrupt
>   ARM: dts: DRA7: add PRM interrupt
> 
>  arch/arm/boot/dts/dra7.dtsi       |    1 +
>  arch/arm/boot/dts/omap4.dtsi      |    1 +
>  arch/arm/boot/dts/omap5.dtsi      |    1 +
>  arch/arm/mach-omap2/prm44xx.c     |   89 ++++++++++++++++++++++++++++++++-----
>  arch/arm/mach-omap2/prminst44xx.c |   41 ++++++++++-------
>  arch/arm/mach-omap2/prminst44xx.h |    3 ++
>  6 files changed, 111 insertions(+), 25 deletions(-)
> 
Gentle ping on this series? are we ok with this approach?

-- 
Regards,
Nishanth Menon
