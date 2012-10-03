From: Matt Porter <mporter@ti.com>
Subject: Re: [PATCH v2 0/7] uio_pruss cleanup and platform support
Date: Wed, 3 Oct 2012 11:00:58 -0400
Message-ID: <20121003150058.GB11180@beef>
References: <1348861072-14507-1-git-send-email-mporter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:39002 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754629Ab2JCPAd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Oct 2012 11:00:33 -0400
Content-Disposition: inline
In-Reply-To: <1348861072-14507-1-git-send-email-mporter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Hans J. Koch" <hjk@hansjkoch.de>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Sekhar Nori <nsekhar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux DaVinci Kernel List <davinci-linux-open-source@linux.davincidsp.com>

On Fri, Sep 28, 2012 at 03:37:45PM -0400, Matt Porter wrote:
> Changes since v1:
> 	- Replaced uio_pruss private SRAM API use with genalloc
> 	- Added DA850 platform device and clock support
> 	- Added DA850 L3 RAM gen_pool support
> 	- Split out DT binding
> 
> This series enables uio_pruss on both DA850 and AM33xx. The driver
> previously was not enabled by any platform and the private SRAM API
> was accessing an invalid SRAM bank for use on DA850. For AM33xx,
> DT, pinctrl, and runtime PM support are added since AM33xx only
> boots via DT.

I'm dropping AM33xx/OMAP support from v3 for this series since the
focus has turned to fixing Davinci SRAM to provide genalloc support
and the associated use of that in the driver.

I'll have a separate series with AM33xx support since dealing cleanly
with external resets on OMAP is a bigger issue.

-Matt
