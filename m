From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP3: quick clock dts fix for 3.17-rc
Date: Wed, 3 Sep 2014 14:38:36 -0700
Message-ID: <20140903213835.GJ11766@atomide.com>
References: <5406CEC3.5000601@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:33502 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755510AbaICVin (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Sep 2014 17:38:43 -0400
Content-Disposition: inline
In-Reply-To: <5406CEC3.5000601@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Tero Kristo <t-kristo@ti.com> [140903 01:18]:
> Hi Tony,
> 
> The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:
> 
>   Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)
> 
> are available in the git repository at:
> 
>   git@github.com:t-kristo/linux-pm.git for-v3.17-rc/ti-clk-dt
> 
> for you to fetch changes up to adf5b4dcc0cf50715f74f49f3c7af0c80467f55f:
> 
>   ARM: dts: set 'ti,set-rate-parent' for dpll4_m5x2 clock (2014-08-21
> 18:01:35 +0300)
> 
> ----------------------------------------------------------------
> Stefan Herbrechtsmeier (1):
>       ARM: dts: set 'ti,set-rate-parent' for dpll4_m5x2 clock
> 
>  arch/arm/boot/dts/omap3xxx-clocks.dtsi |    1 +
>  1 file changed, 1 insertion(+)

Thanks applying into omap-for-v3.17/fixes-v2.

Tony 
