From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 00/11] OMAP: PRCM/powerdomain/clockdomain patches for
 2.6.38,part two
Date: Tue, 14 Dec 2010 20:57:58 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012142057030.15971@utopia.booyaka.com>
References: <20101208061657.30541.79824.stgit@twilight.localdomain> <a52218d5bcff8d959b86230ce9a7ca89@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51762 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754097Ab0LOD56 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Dec 2010 22:57:58 -0500
In-Reply-To: <a52218d5bcff8d959b86230ce9a7ca89@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Jarkko Nikula <jhnikula@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>

On Tue, 14 Dec 2010, Rajendra Nayak wrote:

> Boot tested on 2430/3430/4430SDP. Tested RET/OFF mode in suspend
> on 3430SDP with minimal config (omap3_pm_defconfig).

Thanks for testing this.  Would you like me to add Tested-by:'s ?

Also, I still plan to make that change that you proposed to cause the 
prminst, cminst functions to read/write directly to the registers... 
soon...


- Paul
