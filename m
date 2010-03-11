From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-Fix] OMAP: Add DSI regulator supply to OMAP3EVM board
	file
Date: Thu, 11 Mar 2010 19:03:56 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044DD32C53@dbde02.ent.ti.com>
References: <hvaibhav@ti.com>
 <1268297717-8062-1-git-send-email-hvaibhav@ti.com>
 <20100311124806.GD11135@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39400 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756833Ab0CKNeK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Mar 2010 08:34:10 -0500
In-Reply-To: <20100311124806.GD11135@sirena.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Tomi.Valkeinen@nokia.com" <Tomi.Valkeinen@nokia.com>


> -----Original Message-----
> From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com]
> Sent: Thursday, March 11, 2010 6:18 PM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org; tony@atomide.com; Tomi.Valkeinen@nokia.com
> Subject: Re: [PATCH-Fix] OMAP: Add DSI regulator supply to OMAP3EVM board
> file
> 
> On Thu, Mar 11, 2010 at 02:25:17PM +0530, hvaibhav@ti.com wrote:
> 
> > +static struct regulator_consumer_supply omap3_evm_vpll2_supplies[] = {
> > +	{
> > +		.supply		= "vdvi",
> > +		.dev		= &omap3_evm_lcd_device.dev,
> > +	},
> 
> Please use dev_name for new code.
[Hiremath, Vaibhav] Ok, will change and submit it again shortly.

Thanks,
Vaibhav
