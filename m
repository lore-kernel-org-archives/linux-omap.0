From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [Resend/PATCH 0/5] omap4/5: i2c/spi: device tree data
Date: Mon, 11 Mar 2013 15:32:01 +0100
Message-ID: <513DEAE1.1050606@ti.com>
References: <1363009486-19430-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36621 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872Ab3CKOcR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Mar 2013 10:32:17 -0400
In-Reply-To: <1363009486-19430-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sourav Poddar <sourav.poddar@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, santosh.shilimkar@ti.com, Andrew Morton <akpm@osdl.org>

Hi Sourav,

On 03/11/2013 02:44 PM, Sourav Poddar wrote:
> Hi Tony/Benoit,
> 
> These patches had been sent couple of times before, but there were no comments on it.

Sorry for that. I got a big flu in Jan and was in Linaro Connect last week.
Patches look good, I just have to check that they apply nicely to the
dts/for_3.9 I already prepared.

I still have to rebase that branch on top of a recent master branch and
then check your branch.

> If there are no comments, Can these be picked ? 

> 
> Cc: Andrew Morton <akpm@osdl.org>
>  
> The following changes since commit f6161aa153581da4a3867a2d1a7caf4be19b6ec9:
> 
>   Linux 3.9-rc2 (2013-03-10 16:54:19 -0700)
> 
> are available in the git repository at:
>   git@gitorious.org:linux-connectivity/linux-connectivity.git omap_i2c_spi_dts_data
> 
> Felipe Balbi (1):
>       arm: dts: omap5: add SPI devices to OMAP5 DeviceTree file
> 
> Sourav Poddar (4):
>       arm: dts: omap4-sdp: Add I2c pinctrl data
>       arm: dts: omap5-evm: Add I2c pinctrl data
>       arm: dts: omap4-panda: Add I2c pinctrl data
>       arm: dts: omap5-evm: Add mcspi data

Thanks,
Benoit

