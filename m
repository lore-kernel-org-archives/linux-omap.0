From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: RE: Query on clock naming conventions in clockxxxx_data.c
Date: Fri, 24 Sep 2010 20:49:23 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C003C21EEBFA@dbde02.ent.ti.com>
References: <FCCFB4CDC6E5564B9182F639FC3560870311A2F3F2@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52301 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754181Ab0IXPT2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Sep 2010 11:19:28 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o8OFJPKt018161
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 24 Sep 2010 10:19:27 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o8OFJODT014013
	for <linux-omap@vger.kernel.org>; Fri, 24 Sep 2010 20:49:25 +0530 (IST)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC3560870311A2F3F2@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Taneja, Archit" <archit@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Guruswamy, Senthilvadivu" <svadivu@ti.com>

Archit,

> -----Original Message-----
> From: Taneja, Archit
> Sent: Friday, September 24, 2010 6:11 PM
> To: Nayak, Rajendra
> Cc: linux-omap@vger.kernel.org; Guruswamy, Senthilvadivu
> Subject: Query on clock naming conventions in clockxxxx_data.c
> 
> Hi,
> 
> I had a couple of queries regarding the clock structures in the clockxxxx_data.c files:
> 
> -I have seen that the name of the structure itself explains the name of the clock as
> given in the TRM.
> -The member "name" also tries to mimic the clock name.
> 
> The drivers get the clock struct using the "name" member in the clk_get() api. Is it
> okay if we can change the "name" member to a more generic string. So that the
> driver
> code stays more generic?
> 
> For example, the SYS_CLK which comes into DSS is called "dss2_alwon_fck" on
> omap3 and
> "dss_sys_clk" on omap4. This will make our driver need to have cpu_is_omap checks
> while
> calling clk_get().

The right way to use the clk_get api is by passing the dev pointer to identify the device
and a generic identifier like fck or ick to identify the type/functionality of the clock.
Its not advisable to hardcode clock names, the very reason being that it gets difficult to
maintain clock node names across processor families and eventually you end up with
cpu_is_* checks.

Doing this however requires the clkdev tables to be updated with the mapping of device 
names and generic clock identifiers to the actual clock node.

So if you today have something like
if (cpu_is_omap34xx())
	clk_get(NULL, " dss2_alwon_fck");
else
	clk_get(NULL, " dss_sys_clk");

It can very easily be replaced with a 
clk_get(dev, "fck");

with the clkdev table entry for omap3 like
CLK("dss-omap","fck", &dss2_alwon_fck...
and the clkdev table entry for omap4 having something like
CLK("dss-omap","fck", & dss_sys_clk...

Now, however since all drivers are using pm_runtime api's which hide the clk control from drivers, this might not have be needed anyway.

Regards,
Rajendra

> 
> Thanks,
> 
> Archit

