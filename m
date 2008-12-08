From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/1] Relocating struct regulator_dev to include/linux/regulator/driver.h.
Date: Mon, 8 Dec 2008 10:55:21 +0000
Message-ID: <20081208105520.GA5159@sirena.org.uk>
References: <1228729009-6796-1-git-send-email-mani.pillai@ti.com> <20081208094024.GA7114@sirena.org.uk> <19F8576C6E063C45BE387C64729E739403E90E7851@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:2357 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751566AbYLHKz0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Dec 2008 05:55:26 -0500
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E739403E90E7851@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pillai, Manikandan" <mani.pillai@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>

On Mon, Dec 08, 2008 at 04:12:30PM +0530, Pillai, Manikandan wrote:

> Did not see the rdev_get_drvdata() ?

It's declared in include/linux/regulator/driver.h.

> -----Original Message-----
> From: Mark Brown [mailto:broonie@sirena.org.uk] 
> Sent: Monday, December 08, 2008 3:10 PM
> To: Pillai, Manikandan

Note that the standard in the Linux community is not to top quote; doing
so is generally considered bad form.
