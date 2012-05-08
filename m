From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v4 02/39] ARM: OMAP2+: gpmc: Adapt to HWMOD
Date: Tue, 8 May 2012 06:24:16 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E987902@DBDE01.ent.ti.com>
References: <cover.1335874494.git.afzal@ti.com>
 <e0cf9678cb9a44d2a16401383ab8496eb825c291.1335874494.git.afzal@ti.com>
 <4FA04A8C.4050703@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E98299B@DBDE01.ent.ti.com>
 <4FA4041D.9010000@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E987159@DBDE01.ent.ti.com>
 <4FA7F473.7060607@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46996 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751713Ab2EHGYj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 02:24:39 -0400
In-Reply-To: <4FA7F473.7060607@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "Hilman, Kevin" <khilman@ti.com>, "Balbi, Felipe" <balbi@ti.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "Menon, Nishanth" <nm@ti.com>, "grinberg@compulab.co.il" <grinberg@compulab.co.il>, "notasas@gmail.com" <notasas@gmail.com>, "artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>, "vimal.newwork@gmail.com" <vimal.newwork@gmail.com>, "dbaryshkov@gmail.com" <dbaryshkov@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>

Hi Jon,

On Mon, May 07, 2012 at 21:42:35, Hunter, Jon wrote:

> > Clk_prd is a platform data passed to the driver, so platform code
> > updates it, where else can it be done ?
> 
> The point is that you can pass what ever you like. You do not need to
> pass the frequency you can pass the clock handle instead.

As clk rate is required in platform code for timing calculation, and
already available, period was passed

> 
> What happens it the clk_get() of the gpmc_l3_clk fails during the init?

Thanks for bringing this point, invalid clk_prd has to be handled by driver.

> 
> In fact if you migrate to runtime pm then we should not have the clk_get
> in the gpmc_init any more.

Even if converted to RPM, to get clk rate, clk_get has to be done
somewhere, right ?

Regards
Afzal
