From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] ARM: dts: dra7-evm: Fixes for 3.17
Date: Wed, 3 Sep 2014 14:43:01 -0700
Message-ID: <20140903214300.GM11766@atomide.com>
References: <1409743052-632-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:23621 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756079AbaICVnE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Sep 2014 17:43:04 -0400
Content-Disposition: inline
In-Reply-To: <1409743052-632-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: nm@ti.com, linux-omap@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [140903 04:18]:
> Hi Tony,
> 
> These patches fix  I2C3 bus pinmux and frequency as well as
> NAND partition name on dra7-evm.
> 
> cheers,
> -roger
> 
> ---
> Roger Quadros (2):
>   ARM: dts: dra7-evm: Fix i2c3 pinmux and frequency
>   ARM: dts: dra7-evm: Fix 8th NAND partition's name
> 
>  arch/arm/boot/dts/dra7-evm.dts | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applying into omap-for-v3.17/fixes-v2 thanks.

Tony
