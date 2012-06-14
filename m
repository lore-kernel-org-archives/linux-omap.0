From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v5 11/14] ARM: OMAP2+: gpmc: handle connected peripherals
Date: Thu, 14 Jun 2012 08:40:43 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E999694@DBDE01.ent.ti.com>
References: <cover.1339419492.git.afzal@ti.com>
 <5b3939381db2b7ac29d9df1e817af2ce80016007.1339419492.git.afzal@ti.com>
 <4FD8B23C.4020900@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56590 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755323Ab2FNIlM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jun 2012 04:41:12 -0400
In-Reply-To: <4FD8B23C.4020900@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Jon,

On Wed, Jun 13, 2012 at 21:01:08, Hunter, Jon wrote:
> On 06/11/2012 09:27 AM, Afzal Mohammed wrote:

> > +static __devinit int gpmc_setup_cs(struct gpmc_peripheral *g_per,
> > +				struct gpmc_cs_data *cs, struct resource *res) {
> > +	int num, ret;
> > +
> > +	num = gpmc_setup_cs_mem(cs, res);
> > +	if (IS_ERR_VALUE(num))
> > +		return num;
> > +
> > +	ret = gpmc_setup_cs_config_timing(g_per, cs);
> > +	if (IS_ERR_VALUE(ret))
> > +		return ret;
> > +
> > +	num += gpmc_setup_cs_irq(cs, res + num);
> 
> 
> What happens if the above function returns an error?

That has been deliberately done as that implies user has not
specified irq flag & hence is not an error.

But it seems, I should print error information if user tries to use an
interrupt and if driver does not want/unable to use gpmc interrupt.

Regards
Afzal
