From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: RE: [PATCH] twl6030: regulator: Remove vsel tables and use formula
 for calculation
Date: Fri, 14 May 2010 11:57:09 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0322D7D6C8@dbde02.ent.ti.com>
References: <1271926112-7700-1-git-send-email-rnayak@ti.com>
 <20100423111843.GB27232@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60142 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753214Ab0ENG1T convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 May 2010 02:27:19 -0400
In-Reply-To: <20100423111843.GB27232@rakim.wolfsonmicro.main>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Samuel Ortiz <sameo@linux.intel.com>


> -----Original Message-----
> From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com] 
> Sent: Friday, April 23, 2010 4:49 PM
> To: Nayak, Rajendra
> Cc: linux-omap@vger.kernel.org; Liam Girdwood; Samuel Ortiz
> Subject: Re: [PATCH] twl6030: regulator: Remove vsel tables 
> and use formula for calculation
> 
> On Thu, Apr 22, 2010 at 02:18:32PM +0530, Rajendra Nayak wrote:
> > All twl6030 regulators can be programmed from 1.0v to 3.3v
> > with 100mV steps.
> > The below formula can be used to calculate the vsel values
> > to be programmed in the VREG_VOLTAGE registers.
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Liam,

Would you be queuing this up for the next merge window?

regards,
Rajendra
> 