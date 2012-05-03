From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v4 02/39] ARM: OMAP2+: gpmc: Adapt to HWMOD
Date: Thu, 3 May 2012 08:37:05 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E98299B@DBDE01.ent.ti.com>
References: <cover.1335874494.git.afzal@ti.com>
 <e0cf9678cb9a44d2a16401383ab8496eb825c291.1335874494.git.afzal@ti.com>
 <4FA04A8C.4050703@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50153 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754559Ab2ECIh2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 May 2012 04:37:28 -0400
In-Reply-To: <4FA04A8C.4050703@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "Hilman, Kevin" <khilman@ti.com>, "Balbi, Felipe" <balbi@ti.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "Menon, Nishanth" <nm@ti.com>, "grinberg@compulab.co.il" <grinberg@compulab.co.il>, "notasas@gmail.com" <notasas@gmail.com>, "artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>, "vimal.newwork@gmail.com" <vimal.newwork@gmail.com>, "dbaryshkov@gmail.com" <dbaryshkov@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>

Hi Jon,

On Wed, May 02, 2012 at 02:11:48, Hunter, Jon wrote:
> > +
> > +	pdata->clk_prd = gpmc_get_fclk_period();
> 
> Does this need to be done here? May be this should be done in the probe
> function. You could store the handle to the main clk in the pdata.

This is done so that migration of gpmc driver to the drivers folder
would be smooth, remember that this function will still live here.
 
> > +		pr_err("error: clk_get on %s\n", oh->main_clk);
> > +		return -EINVAL;
> >  	}
> >  
> >  	clk_enable(gpmc_l3_clk);
> 
> I would have thought we should be able to remove the gpmc_init function
> completely by now. Most of the code should be moved to the probe function.
> 
> Also now with hwmod in place, we should be able to remove the
> clk_enable/disable functions and use the pm_runtime APIs instead.

There was no plan to add rpm in this series, but now that you have
brought it up, I will adapt the driver to rpm.

Regards
Afzal
