From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v5 02/14] ARM: OMAP2+: gpmc: Adapt to HWMOD
Date: Tue, 12 Jun 2012 06:53:06 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E997DD6@DBDE01.ent.ti.com>
References: <cover.1339419492.git.afzal@ti.com>
 <fb739c3c5383806f78cee3666f7c74d61bed6427.1339419492.git.afzal@ti.com>
 <4FD64D6D.3020401@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46513 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751323Ab2FLGxU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Jun 2012 02:53:20 -0400
In-Reply-To: <4FD64D6D.3020401@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Jon,

On Tue, Jun 12, 2012 at 01:26:29, Hunter, Jon wrote:

> > +	pdev = omap_device_build(name, -1, oh, pdata,
> > +					sizeof(*pdata), NULL, 0, 0);
> > +	if (IS_ERR(pdev)) {
> > +		WARN(1, "Can't build omap_device for %s:%s.\n",
> > +						name, oh->name);
> > +		return PTR_ERR(pdev);
> > +	}
> > +
> > +	gpmc_l3_clk = clk_get(NULL, oh->main_clk);
> > +	if (IS_ERR(gpmc_l3_clk)) {
> > +		pr_err("Could not get GPMC clock\n");
> > +		return PTR_ERR(gpmc_l3_clk);
> > +	}
> 
> My preference would be to store gpmc_l3_clk in the pdata and pass to
> probe via the pdata. The aim would be to remove the global gpmc_l3_clk
> altogether.

For timing calculation by platform outside of driver, we need clk rate

> Also we should attempt to get the clk before calling omap_device_build
> which is registering the driver.

omap_device_build registers only device, but I agree that clk should
be obtained before it as driver can get probed at that point

Regards,
Afzal
