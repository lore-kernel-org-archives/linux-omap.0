From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 2/3] MFD: twl6040: Convert to i2c driver, and
 separate it from twl core
Date: Tue, 21 Feb 2012 10:43:53 -0800
Message-ID: <20120221184353.GP18185@atomide.com>
References: <1328868018-24668-1-git-send-email-peter.ujfalusi@ti.com>
 <1328868018-24668-3-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:28847 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753011Ab2BUSoD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Feb 2012 13:44:03 -0500
Content-Disposition: inline
In-Reply-To: <1328868018-24668-3-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Dmitry Torokhov <dtor@mail.ru>, Misael Lopez Cruz <misael.lopez@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [120210 01:29]:
> Complete the separation of the twl6040 from the twl core since
> it is a separate chip, not part of the twl6030 PMIC.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Reviewed-by: Mark Brown <broonie@opensource.wolfsonicro.com>

This should be OK to merge via the ASoC tree:

Acked-by: Tony Lindgren <tony@atomide.com>
