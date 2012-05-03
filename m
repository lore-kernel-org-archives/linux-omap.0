From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v4 04/39] ARM: OMAP2+: gpmc: Acquire NAND CS value
Date: Thu, 3 May 2012 08:42:11 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E9829B0@DBDE01.ent.ti.com>
References: <cover.1335874494.git.afzal@ti.com>
 <10220de398d22fad5de783d8f58fc55ebac85338.1335874494.git.afzal@ti.com>
 <4FA05292.7030902@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38614 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754619Ab2ECImf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 May 2012 04:42:35 -0400
In-Reply-To: <4FA05292.7030902@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "Hilman, Kevin" <khilman@ti.com>, "Balbi, Felipe" <balbi@ti.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "Menon, Nishanth" <nm@ti.com>, "grinberg@compulab.co.il" <grinberg@compulab.co.il>, "notasas@gmail.com" <notasas@gmail.com>, "artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>, "vimal.newwork@gmail.com" <vimal.newwork@gmail.com>, "dbaryshkov@gmail.com" <dbaryshkov@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>

Hi Jon,

On Wed, May 02, 2012 at 02:46:02, Hunter, Jon wrote:
> > Some boards depend on bootloader to update chip select value for NAND.
> > It is felt that Kernel should not depend on bootloader to get CS, as
> > for a particular board CS is hardwired and is fixed, hence this can
> > directly be updated in Kernel. But as CS value for boards that depend
> > on this behaviour is not available, educate gpmc driver to acquire
> > chip select value for NAND. this ideally should be removed once CS
> > for those boards are available.
> 
> Do you know how many boards require this? If so which are those boards?

devkit8000, beagle board, omap3touchbook, overo.

Beagle board, found out to be zero.

> Should this code be marked with a FIXME?

Will let Tony decide it.

Regards
Afzal
