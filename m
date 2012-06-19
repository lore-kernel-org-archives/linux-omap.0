From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v2 2/3] ARM: OMAP2+: onenand: prepare for gpmc driver
 migration
Date: Tue, 19 Jun 2012 05:57:57 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E99C502@DBDE01.ent.ti.com>
References: <cover.1339828867.git.afzal@ti.com>
 <1414767dd444d4ab3998adf957e77ff4f3394f92.1339828867.git.afzal@ti.com>
 <4FDF50EA.4080506@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57183 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752767Ab2FSF6F convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Jun 2012 01:58:05 -0400
In-Reply-To: <4FDF50EA.4080506@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Jon,

On Mon, Jun 18, 2012 at 21:31:46, Hunter, Jon wrote:

> > @@ -95,10 +89,6 @@ static int omap2_onenand_set_async_mode(int cs, void __iomem *onenand_base)
> >  	if (err)
> >  		return err;
> >  
> > -	/* Ensure sync read and sync write are disabled */
> > -	reg = readw(onenand_base + ONENAND_REG_SYS_CFG1);
> > -	reg &= ~ONENAND_SYS_CFG1_SYNC_READ & ~ONENAND_SYS_CFG1_SYNC_WRITE;
> > -	writew(reg, onenand_base + ONENAND_REG_SYS_CFG1);
> 
> Sorry if I was not clear, but I was still thinking that we keep the
> above instance of setting async mode.
:
> >  static int gpmc_onenand_setup(void __iomem *onenand_base, int *freq_ptr)
> >  {
> >  	struct device *dev = &gpmc_onenand_device.dev;
> > +	u32 reg;
> > +
> > +	/* Ensure sync read and sync write are disabled */
> > +	reg = readw(onenand_base + ONENAND_REG_SYS_CFG1);
> > +	reg &= ~ONENAND_SYS_CFG1_SYNC_READ & ~ONENAND_SYS_CFG1_SYNC_WRITE;
> > +	writew(reg, onenand_base + ONENAND_REG_SYS_CFG1);
> 
> ... and here we should just call omap2_onenand_set_async_mode(), ...

If omap2_onenand_set_async_mode is called from gpmc_onenand_setup & removed
from gpmc_onenand_init, when using new gpmc driver interface, i.e. using
gpmc_onenand_update [1], we lost opportunity to provide gpmc driver with
configuration details for async mode causing a big warning about each
timings & configurations that was left by bootloader (which is meant only
for cases where Kernel can't configure GPMC). Of course, we can put
omap2_onenand_set_async_mode in gpmc_onenand_update too, but then
unnecessarily, omap2_onenand_sey_async_mode would be called twice.

Please note that gpmc_onenand_setup is a callback by onenand driver.

Regards
Afzal

> >  
> > +	omap2_onenand_set_async_mode(gpmc_onenand_data->cs);
> > +
> 
> ...  then remove the above call.

[1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg69919.html

