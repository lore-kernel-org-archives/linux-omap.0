From: Tero Kristo <t-kristo@ti.com>
Subject: RE: [PATCH 2/3] ARM: OMAP3+: PM: introduce a central pmic control
Date: Mon, 7 May 2012 16:24:18 +0300
Message-ID: <1336397058.2149.257.camel@sokoban>
References: <1336139842-845-1-git-send-email-t-kristo@ti.com>
	 <1336139842-845-3-git-send-email-t-kristo@ti.com>
	 <ca56d8bf68a45af7436d206c4d13bc7f@mail.gmail.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45910 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756068Ab2EGNYZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 7 May 2012 09:24:25 -0400
In-Reply-To: <ca56d8bf68a45af7436d206c4d13bc7f@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath Sripathy <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>

On Mon, 2012-05-07 at 17:30 +0530, Vishwanath Sripathy wrote:
> Hi Tero,
> 
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of Tero Kristo
> > Sent: Friday, May 04, 2012 7:27 PM
> > To: linux-omap@vger.kernel.org; khilman@ti.com
> > Cc: linux-arm-kernel@lists.infradead.org; Nishanth Menon
> > Subject: [PATCH 2/3] ARM: OMAP3+: PM: introduce a central pmic
> > control
> >
> > From: Nishanth Menon <nm@ti.com>
> >
> > Since we are starting to use multiple PMICs in various combinations,
> > use the existing .omap_chip = OMAP_CHIP_INIT() to mark the
> > structures we are interested in using per OMAP device we
> > are currently running on. This mapping is based on the default
> > device recommendations from TI. Boards using custom PMICs now
> > have an opportunity to register their own custom mapping.
> >
> > With this we no longer need omap4_twl_init and omap3_twl_int
> > instead we introduce a registration mechanism which is PMIC
> > generic and move twl implementation to use the same. This allows
> > for future OMAP4460 support where there is a mixture of
> > PMIC combinations used.
> In this patch, you seem to be tying PMIC configuration with a OMAP version
> which I think is not quite appropriate. Rather it should be a board
> dependent parameter. We have many boards based on 4460 chip with different
> PMICs. This implementation will not be able to support all such
> configurations.

The ICS tree contains tweaks for this purpose, allowing the mapping to
be modified during init time by board files. This should only be the
default setup, and once support for boards that do not use default setup
is added, we should modify this.

However, if someone can provide me specs how the multi PMIC support
should actually work, I am willing to implement this.

-Tero


