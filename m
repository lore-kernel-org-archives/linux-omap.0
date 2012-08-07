From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH] ARM: AM33XX: board-generic: Add of_dev_auxdata to fix
 dev_id for CAN module
Date: Tue, 7 Aug 2012 15:53:08 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA88BDF@DBDE01.ent.ti.com>
References: <1344346636-28072-1-git-send-email-hvaibhav@ti.com>
 <50213214.7050505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39426 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753262Ab2HGPxW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Aug 2012 11:53:22 -0400
In-Reply-To: <50213214.7050505@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, Aug 07, 2012 at 20:49:48, Rob Herring wrote:
> On 08/07/2012 08:37 AM, Vaibhav Hiremath wrote:
> > If the module requires only one clocksource to function, then
> > driver can very well call clk_get() api with "con_id = NULL",
> > 
> >        clk = clk_get(dev, NULL);
> > 
> > And platform code should respect this and return valid clk handle.
> > That means, now the clk_get() api would rely on dev_id, and platform
> > code should either have clk node with matching dev_id (with con_id=NULL)
> > or return dummy clk node.
> > 
> > With DT support, we can fix the dev_id for particular module
> > using "struct of_dev_auxdata" to satisfy above clk framework requirement.
> > 
> > In case of AM33XX, we required this for the DCAN module, so this
> > patch adds "of_dev_auxdata" for both DCAN_0/1 instances.
> > 
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> > Cc: Benoit Cousson <b-cousson@ti.com>
> > Cc: Grant Likely <grant.likely@secretlab.ca>
> > ---
> > This patch is boot tested on BeagleBone platform, and checked for
> > clk_get() return value in d_can module driver.
> > 
> >  arch/arm/mach-omap2/board-generic.c |   18 +++++++++++++++++-
> >  1 files changed, 17 insertions(+), 1 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
> > index 6f93a20..c9b7903 100644
> > --- a/arch/arm/mach-omap2/board-generic.c
> > +++ b/arch/arm/mach-omap2/board-generic.c
> > @@ -37,11 +37,27 @@ static struct of_device_id omap_dt_match_table[] __initdata = {
> >  	{ }
> >  };
> > 
> > +/*
> > + * Lookup table for attaching a specific name and platform_data pointer to
> > + * devices as they get created by of_platform_populate(). Ideally this table
> > + * would not exist, but the current clock implementation depends on some devices
> > + * having a specific name OR to satisfy NULL con_id requirement from driver.
> > + */
> > +static const struct of_dev_auxdata am33xx_auxdata_lookup[] __initconst = {
> > +	OF_DEV_AUXDATA("bosch,d_can", 0x481cc000, "d_can.0", NULL),
> > +	OF_DEV_AUXDATA("bosch,d_can", 0x481d0000, "d_can.1", NULL),
> > +	{ },
> > +};
> 
> Adding an additional clkdev lookup accomplishes the same thing and is a
> cleaner solution.
> 

That is also required and I have submitted patch for the same -

http://www.spinics.net/lists/arm-kernel/msg187998.html


With DT support, I am getting dev_id as -

 - Without "reg" property: d_can.16 and d_can.17,
   (I believe it changes dynamically here)

 - With "reg" property: 481cc000.d_can and 481d0000.d_can

Which is not so intuitive, I would like to see them as per Spec/TRM, so 
doesn't this patch make sense?

Similar thing has already been done for other platforms too.

Thanks,
Vaibhav
