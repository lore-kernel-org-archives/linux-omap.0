From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] omap fixes against v4.1-rc1
Date: Thu, 7 May 2015 18:26:29 +0200
Message-ID: <201505071826.29224.arnd@arndb.de>
References: <20150505154423.GD21061@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:50429 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751297AbbEGQ1B (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 May 2015 12:27:01 -0400
In-Reply-To: <20150505154423.GD21061@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, arm@kernel.org, linux-omap@vger.kernel.org

On Tuesday 05 May 2015, Tony Lindgren wrote:
> The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:
> 
>   Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.1/fixes-rc1
> 
> for you to fetch changes up to e7309c2673a389a495fcfad70376d3bae8b9bc89:
> 
>   bus: omap_l3_noc: Fix master id address decoding for OMAP5 (2015-05-04 10:21:01 -0700)
> 
> ----------------------------------------------------------------
> Fixes for omaps, mostly a fix for power power consumption
> creeping up during idle, and two l3-noc device fixes:
> 
> - Fix power consumption creeping up with I2C4 staying on
> - Fix n900 microphone bias voltages
> - Fix dra7 l3-noc for host clock
> - Fix omap5 l3-noc id address decoding
> 
> The rest are all just minor dts fixes:
> 
> - Fix changed EXTCON_USB_GPIO_USB in defconfig
> - Fix missing isp and iva #iommu-cells property
> - Various beagle x15 dts fixes for pre-production changes
> - Fix am437x-sk display dts entries

Pulled into fixes branch, thanks!

	Arnd
