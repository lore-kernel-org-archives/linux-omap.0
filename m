From: "Pillai, Manikandan" <mani.pillai@ti.com>
Subject: RE: [PATCH 1/1] Relocating struct regulator_dev to
	include/linux/regulator/driver.h.
Date: Mon, 8 Dec 2008 16:12:30 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403E90E7851@dbde02.ent.ti.com>
References: <1228729009-6796-1-git-send-email-mani.pillai@ti.com>
 <20081208094024.GA7114@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44767 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751509AbYLHKm7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Dec 2008 05:42:59 -0500
In-Reply-To: <20081208094024.GA7114@sirena.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>

Hi Mark,

Looks like I don't need this change. I just am testing my changes without this
patch.

Did not see the rdev_get_drvdata() ?

Regards
Mani

-----Original Message-----
From: Mark Brown [mailto:broonie@sirena.org.uk] 
Sent: Monday, December 08, 2008 3:10 PM
To: Pillai, Manikandan
Cc: linux-omap@vger.kernel.org; lrg@slimlogic.co.uk
Subject: Re: [PATCH 1/1] Relocating struct regulator_dev to include/linux/regulator/driver.h.

On Mon, Dec 08, 2008 at 03:06:49PM +0530, Manikandan Pillai wrote:
> The struct regulator_dev declaration has been moved from
> driver/regulator/core.c to include/linux/regulator/driver.h for
> supporting new regulators.

> Signed-off-by: Manikandan Pillai <mani.pillai@ti.com>

Why do you want to do this?  I've seen one driver which appeared to be
using this only to open code rdev_get_drvdata().  If other details of
the contents are required are accessor functions not sufficient?

