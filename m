From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2]   Adding LogicPD OMAP 3530 LV SOM and OMAP 35x
 Torpedo
Date: Tue, 6 Jul 2010 14:15:26 +0300
Message-ID: <20100706111526.GL3192@atomide.com>
References: <1274880936-23648-1-git-send-email-Jacob.Tanenbaum@logicpd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53500 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754368Ab0GFLPb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Jul 2010 07:15:31 -0400
Content-Disposition: inline
In-Reply-To: <1274880936-23648-1-git-send-email-Jacob.Tanenbaum@logicpd.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jacob Tanenbaum <Jacob.Tanenbaum@logicpd.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com

Hi,

* Jacob Tanenbaum <Jacob.Tanenbaum@logicpd.com> [100526 16:30]:
>         Adding LogicPD OMAP3 board support
> 
>         Adding support for LogicPD's OMAP 3530 LV SOM and
>         OMAP 35x Torpedo board.

Please update this patch to leave out the defconfig as we won't
be patching those any longer as requested by Linus.

Instead, please  just add default y for the board in
arch/arm/mach-omap2/Kconfig.

Please also test these patches with the linux-omap for-next
branch.

Regards,

Tony
