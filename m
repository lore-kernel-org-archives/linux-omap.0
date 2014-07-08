From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: DRA7: dts: clock data fixes
Date: Tue, 8 Jul 2014 01:17:39 -0700
Message-ID: <20140708081738.GD28884@atomide.com>
References: <53B59B22.5050903@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:26073 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753141AbaGHIRh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Jul 2014 04:17:37 -0400
Content-Disposition: inline
In-Reply-To: <53B59B22.5050903@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, Mike Turquette <mturquette@linaro.org>

* Tero Kristo <t-kristo@ti.com> [140703 11:05]:
> Hi Tony,
> 
> The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:
> 
>   Linux 3.16-rc1 (2014-06-15 17:45:28 -1000)
> 
> are available in the git repository at:
> 
>   git@github.com:t-kristo/linux-pm.git for-v3.16-rc/clk-dt-fixes
> 
> for you to fetch changes up to dd94324b983afe114ba9e7ee3649313b451f63ce:
> 
>   ARM: dts: dra7xx-clocks: Fix the l3 and l4 clock rates (2014-07-03
> 20:59:36 +0300)
> ----------------------------------------------------------------
> 
> One fix for 3.16-rc. Fixes wrong dividers for l3/l4 clock nodes on DRA7.
> 

Pulling this into omap-for-v3.16/fixes thanks.

Tony

> ----------------------------------------------------------------
> Rajendra Nayak (1):
>       ARM: dts: dra7xx-clocks: Fix the l3 and l4 clock rates
> 
>  arch/arm/boot/dts/dra7xx-clocks.dtsi |   10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
