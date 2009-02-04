From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 2/2] Add and build TPS6235x based PR785 board support
Date: Wed, 4 Feb 2009 12:02:36 +0000
Message-ID: <20090204120235.GC29849@sirena.org.uk>
References: <1233723384-13212-1-git-send-email-mani.pillai@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:1233 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752645AbZBDMCj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Feb 2009 07:02:39 -0500
Content-Disposition: inline
In-Reply-To: <1233723384-13212-1-git-send-email-mani.pillai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Manikandan Pillai <mani.pillai@ti.com>
Cc: linux-omap@vger.kernel.org

On Wed, Feb 04, 2009 at 10:26:24AM +0530, Manikandan Pillai wrote:

> TPS6235x chip based PR785 power modules are from Texas Instruments
> for OMAP3 EVM boards. This patch supports the PR785 card
> and provides the driver support for the TPS devices.
> 
> For compilation, the LCD and MMC drivers are modified and will not
> work. Further patches will be provided for support of LCD and MMC
> with PR785 boards.
> 
> Signed-off-by: Manikandan Pillai <mani.pillai@ti.com>

This looks OK from a regulator API point of view.
