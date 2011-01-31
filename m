From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 12/13] ASoC: McBSP: get hw params from McBSP driver
Date: Mon, 31 Jan 2011 17:16:28 +0000
Message-ID: <20110131171628.GJ5123@opensource.wolfsonmicro.com>
References: <1296485437-12806-1-git-send-email-kishon@ti.com>
 <1296485437-12806-13-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:49509 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751404Ab1AaRQb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 31 Jan 2011 12:16:31 -0500
Content-Disposition: inline
In-Reply-To: <1296485437-12806-13-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk, paul@pwsan.com, charu@ti.com, shubhrajyoti@ti.com, b-cousson@ti.com, khilman@deeprootsystems.com, p-basak2@ti.com, Jarkko Nikula <jhnikula@gmail.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>

On Mon, Jan 31, 2011 at 08:20:36PM +0530, Kishon Vijay Abraham I wrote:
> Removed the use of macros to obtain base address and DMA channel number.
> Instead use the McBSP driver API's that passes base address and DMA
> channel number to the client driver.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Jarkko Nikula <jhnikula@gmail.com>
> Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
