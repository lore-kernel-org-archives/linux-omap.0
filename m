From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm/dts: remove MMC/SD and SPI related entries from
 am33xx.dtsi
Date: Mon, 9 Jul 2012 02:14:31 -0700
Message-ID: <20120709091431.GE1122@atomide.com>
References: <1341815049-3947-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:54443 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752546Ab2GIJOf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Jul 2012 05:14:35 -0400
Content-Disposition: inline
In-Reply-To: <1341815049-3947-1-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: AnilKumar Ch <anilkumar@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* AnilKumar Ch <anilkumar@ti.com> [120708 23:29]:
> The MMC/SD and SPI entries in this file are not tested yet. They
> inadvertently came into the patch because of some work in progress
> stuff I had in my repo.
> 
> These entries should not have been sent out in the first place and
> I am sorry for the trouble and will be extra careful in future.
> 
> Since the offending commit is not sent upstream yet, I hope this can
> be merged into the commit 5fc0b42a98556bd9f01cecc6a64fcbd15ec363f0
> (arm/dts: Add initial DT support for AM33XX SoC family) on the devel-dt
> branch of linux-omap tree.

Thanks applying into omap devel-dt branch.

Tony
