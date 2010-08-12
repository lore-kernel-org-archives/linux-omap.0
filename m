From: "Basak, Partha" <p-basak2@ti.com>
Subject: RE: [PATCH 10/13 v5] OMAP: GPIO: Implement GPIO as a platform device
Date: Thu, 12 Aug 2010 17:40:55 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E8147180@dbde02.ent.ti.com>
References: <1281098065-24177-1-git-send-email-charu@ti.com>
 <1281098065-24177-2-git-send-email-charu@ti.com>
 <1281098065-24177-3-git-send-email-charu@ti.com>
 <1281098065-24177-4-git-send-email-charu@ti.com>
 <1281098065-24177-5-git-send-email-charu@ti.com>
 <1281098065-24177-6-git-send-email-charu@ti.com>
 <1281098065-24177-7-git-send-email-charu@ti.com>
 <1281098065-24177-8-git-send-email-charu@ti.com>
 <1281098065-24177-9-git-send-email-charu@ti.com>
 <1281098065-24177-10-git-send-email-charu@ti.com>
 <1281098065-24177-11-git-send-email-charu@ti.com>
 <878w4ffkth.fsf@deeprootsystems.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301E80AC400@dbde02.ent.ti.com>
 <alpine.DEB.2.00.1008102344440.27472@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33271 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753240Ab0HLMLD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Aug 2010 08:11:03 -0400
In-Reply-To: <alpine.DEB.2.00.1008102344440.27472@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "Varadarajan, Charulatha" <charu@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>



> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Wednesday, August 11, 2010 11:17 AM
> To: Basak, Partha
> Cc: Kevin Hilman; Varadarajan, Charulatha; linux-omap@vger.kernel.org;
> Cousson, Benoit; Nayak, Rajendra
> Subject: RE: [PATCH 10/13 v5] OMAP: GPIO: Implement GPIO as a platform
> device
> 
> On Tue, 10 Aug 2010, Basak, Partha wrote:
> 
> > As per our discussion with Paul & you during workshop, I believe,
> > optional clock control should be done using clock APIs. So, I would go
> > by your suggestion 1 of exposing an API to expose the optional clocks in
> > the hwmod, something like:
> >
> > struct omap_hwmod_opt_clk * omap_hwmod_get_opt_clks(struct omap_hwmod
> > *oh);
> >
> > If agreed, Charu will send updated patch.
> 
> This should be done by modifying the hwmod code to call clk_add_alias()
> for the clock names for the optional clocks.  I don't think any extra API
> is needed.
> 

Lets see, if I got it right:

Refer to the OMAP3 hwmod data-base (omap_hwmod_3xxx.c): 
static struct omap_hwmod_opt_clk gpio1_opt_clks[] = {
	{ .role = "dbclk", .clk = "gpio1_dbck", },
};
Clock database(Clock3xxx_data.c):
	CLK(NULL,	"gpio1_dbck",	&gpio1_dbck,	CK_3XXX),


Refer to the OMAP4 hwmod database(omap_hwmod_44xx.c): 
	static struct omap_hwmod_opt_clk gpio1_opt_clks[] = {
		{ .role = "dbclk", .clk = "sys_32k_ck" },

Clock database(Clock44xx_data.c):

CLK(NULL,	"sys_32k_ck",			&sys_32k_ck,	CK_443X),


/*int clk_add_alias(const char *alias, const char *alias_dev_name, char *id,
	struct device *dev);*/

I believe, you are suggesting to do the following in the hwmod framework, say _setup(?):

clk_add_alias ( <gpio1_>opt_clks.role,
			 oh->od.pdev.name, 
			<gpio1_>opt_clks.clk,
			NULL);

Then, from the driver, we can simply do a 
	clk_get(dev_ptr, 
			<role-->"dbclk">); /*hard-coded in the driver to be same 			as in the hwmod database*/

> 
> - Paul
