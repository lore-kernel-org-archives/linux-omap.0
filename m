From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC PATCH v2 0/6] TI81XX: Add clock and hwmod data
Date: Wed, 14 Sep 2011 17:33:25 -0700
Message-ID: <20110915003325.GD30941@atomide.com>
References: <1314119594-22647-1-git-send-email-hemantp@ti.com>
 <alpine.DEB.2.00.1108301246170.26173@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:45338 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751719Ab1IOAd2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Sep 2011 20:33:28 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1108301246170.26173@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Hemant Pedanekar <hemantp@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>

* Paul Walmsley <paul@pwsan.com> [110830 11:13]:
> On Tue, 23 Aug 2011, Hemant Pedanekar wrote:
> 
> > This patch set is the v2 of TI816X clock and hwmods patches sent earlier.
> > 
> > The clock data is currently added only for TI816X, while minimal hwmod data
> > common for TI816X and TI814X is added.
> > 
> > This patch set depends on following patches:
> > 	TI81XX: Prepare for addition of TI814X support
> > 	TI814X: Add cpu type macros and detection support
> > 	TI814X: Create board support and enable build for TI8148 EVM
> > 
> > Please note that CHIP_IS_TI816X/CHIP_IS_TI814X are still being used and I will
> > send update once SoC list usage is available.	
> 
> Thanks - am working away on these patches & hope to have them out soon.

Hemant, can you please rebase your patches on Paul's CHIP_IS
removal branch?

It's available at:

git://git.pwsan.com/linux-2.6 omap_chip_remove_cleanup_3.2

Regards,

Tony
