From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL 1/2] omap device tree changes for v3.15, part 3
Date: Mon, 17 Mar 2014 15:14:06 +0100
Message-ID: <201403171514.07194.arnd@arndb.de>
References: <20140313200135.GA5981@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.24]:62589 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932471AbaCQOOe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Mar 2014 10:14:34 -0400
In-Reply-To: <20140313200135.GA5981@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: arm@kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Thursday 13 March 2014, Tony Lindgren wrote:
> Hi,
> 
> Resending these two, looks like my updated scripts have some issues hitting
> the mailing lists..
> 
> The following changes since commit 18c49af3ee9e32a535413a949672bea726699f04:
> 
>   ARM: dts: am335x-evmsk: enable dual_emac mode (2014-03-05 11:53:36 -0800)
> 
> are available in the git repository at:
>   
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.15/dt-part3
> 
> for you to fetch changes up to e1902bbe44844597a38c8cbae30ca895f6e126ee:
> 
>   ARM: dts: Add MMC2/SDIO/WLAN support for cm-t3530 (2014-03-12 10:40:37 -0700)
> 
> ----------------------------------------------------------------
> Device tree related changes to the omap iommu driver as that
> is finally getting updated. Also few trivial board related
> .dts updates to add more devices.

Pulled into next/dt, thanks!

I haven't really been following the iommu discussions, so I have to trust
you are doing the right thing here. What is the status on iommu
support through DT? Do we have or require a generic binding for iommus?
Are you following that, or will you have to do incompatible changes to
do that?

	Arnd
