From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 2/2] Add and build TPS6235x based PR785 board support
Date: Tue, 3 Feb 2009 11:57:29 +0000
Message-ID: <20090203115724.GB23827@sirena.org.uk>
References: <1233638880-32652-1-git-send-email-mani.pillai@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:4308 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751472AbZBCL5b (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Feb 2009 06:57:31 -0500
Content-Disposition: inline
In-Reply-To: <1233638880-32652-1-git-send-email-mani.pillai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Manikandan Pillai <mani.pillai@ti.com>
Cc: linux-omap@vger.kernel.org

On Tue, Feb 03, 2009 at 10:58:00AM +0530, Manikandan Pillai wrote:
> Change in this patch include
> comments fix from David Brownell and Mark

>  arch/arm/plat-omap/i2c.c               |    4 +-
>  drivers/regulator/tps6235x-regulator.c |    8 ++--

Please address the issues previously raised with the changes in these
files.
