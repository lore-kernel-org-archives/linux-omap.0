From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/2] Add support for TPS6235x support
Date: Wed, 4 Feb 2009 11:51:12 +0000
Message-ID: <20090204115110.GA29849@sirena.org.uk>
References: <1233723366-13053-1-git-send-email-mani.pillai@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:1696 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468AbZBDLvO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Feb 2009 06:51:14 -0500
Content-Disposition: inline
In-Reply-To: <1233723366-13053-1-git-send-email-mani.pillai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Manikandan Pillai <mani.pillai@ti.com>
Cc: linux-omap@vger.kernel.org

On Wed, Feb 04, 2009 at 10:26:06AM +0530, Manikandan Pillai wrote:
> The patch has been fixed for comments given by David Brownell
> and Mark Brown for adding TPS6235x support on OMAP3 EVM.
> Comments fixed include
> moving Makefile changes to this patch
> dev_err used
> removed the extra configuration option from Kconfig

> Signed-off-by: Manikandan Pillai <mani.pillai@ti.com>

This looks fine from a regulator API point of view.
