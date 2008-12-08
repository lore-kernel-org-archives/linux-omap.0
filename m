From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/1] Relocating struct regulator_dev to
	include/linux/regulator/driver.h.
Date: Mon, 8 Dec 2008 09:40:25 +0000
Message-ID: <20081208094024.GA7114@sirena.org.uk>
References: <1228729009-6796-1-git-send-email-mani.pillai@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:3659 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751058AbYLHJkf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Dec 2008 04:40:35 -0500
Content-Disposition: inline
In-Reply-To: <1228729009-6796-1-git-send-email-mani.pillai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Manikandan Pillai <mani.pillai@ti.com>
Cc: linux-omap@vger.kernel.org, lrg@slimlogic.co.uk

On Mon, Dec 08, 2008 at 03:06:49PM +0530, Manikandan Pillai wrote:
> The struct regulator_dev declaration has been moved from
> driver/regulator/core.c to include/linux/regulator/driver.h for
> supporting new regulators.

> Signed-off-by: Manikandan Pillai <mani.pillai@ti.com>

Why do you want to do this?  I've seen one driver which appeared to be
using this only to open code rdev_get_drvdata().  If other details of
the contents are required are accessor functions not sufficient?
