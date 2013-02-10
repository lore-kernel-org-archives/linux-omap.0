From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] ARM: OMAP4: Add OMAP4 Blaze Tablet support
Date: Sat, 9 Feb 2013 18:52:26 -0800
Message-ID: <20130210025225.GB4801@atomide.com>
References: <1360352269-14922-1-git-send-email-ruslan.bilovol@ti.com>
 <1360352269-14922-2-git-send-email-ruslan.bilovol@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:58069 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760956Ab3BJCwb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 9 Feb 2013 21:52:31 -0500
Content-Disposition: inline
In-Reply-To: <1360352269-14922-2-git-send-email-ruslan.bilovol@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ruslan Bilovol <ruslan.bilovol@ti.com>
Cc: linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

* Ruslan Bilovol <ruslan.bilovol@ti.com> [130208 11:41]:
> The OMAP4 Blaze Tablet is TI OMAP4 processor-based
> development platform in a tablet formfactor.
> The platform contains many of the features found in
> present-day handsets (such as audio, video, wireless
> functions and user interfaces) and in addition
> contains features for software development and test.
> 
> This patch adds initial support for the OMAP4 Blaze
> Tablet development platform. Additional functionality
> depends on different drivers and code modifications that
> are not upstreamed yet so will be added later.

Nice that you have it working, however, we're not adding
any more board-*.c files as we're moving things to device
tree based booting.

Care to try to get the basic .dts file done for this?
You will probably need to add CONFIG_ARM_APPENDED_DTB=y
and CONFIG_ARM_ATAG_DTB_COMPAT=y to omap2plus_defconfig
and append the .dtb file to zImage and run mkimage then
manually to boot it. But you should get serial and MMC
at least working to start with :)

Regards,

Tony
