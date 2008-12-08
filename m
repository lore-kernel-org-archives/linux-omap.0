From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: RE: [PATCH 1/1] Relocating struct regulator_dev to
 include/linux/regulator/driver.h.
Date: Mon, 08 Dec 2008 10:55:41 +0000
Message-ID: <1228733741.8961.44.camel@vega.slimlogic.co.uk>
References: <1228729009-6796-1-git-send-email-mani.pillai@ti.com>
	 <20081208094024.GA7114@sirena.org.uk>
	 <19F8576C6E063C45BE387C64729E739403E90E7851@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from slimlogic.co.uk ([89.16.172.20]:49985 "EHLO slimlogic.co.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751228AbYLHLZE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Dec 2008 06:25:04 -0500
In-Reply-To: <19F8576C6E063C45BE387C64729E739403E90E7851@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pillai, Manikandan" <mani.pillai@ti.com>
Cc: Mark Brown <broonie@sirena.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, 2008-12-08 at 16:12 +0530, Pillai, Manikandan wrote:
> Hi Mark,
> 
> Looks like I don't need this change. I just am testing my changes without this
> patch.
> 
> Did not see the rdev_get_drvdata() ?
> 

Btw, do you have any other regulator patches ? (there may be a merge
window soon).

Thanks

Liam 

