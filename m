From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: RE: [PATCH] twl6030: regulator: Remove vsel tables and use formula
 for calculation
Date: Fri, 14 May 2010 10:00:15 +0100
Message-ID: <1273827615.3069.1.camel@odin>
References: <1271926112-7700-1-git-send-email-rnayak@ti.com>
	 <20100423111843.GB27232@rakim.wolfsonmicro.main>
	 <5A47E75E594F054BAF48C5E4FC4B92AB0322D7D6C8@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:61555 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499Ab0ENJAW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 May 2010 05:00:22 -0400
Received: by wwi18 with SMTP id 18so364105wwi.19
        for <linux-omap@vger.kernel.org>; Fri, 14 May 2010 02:00:20 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0322D7D6C8@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Samuel Ortiz <sameo@linux.intel.com>

On Fri, 2010-05-14 at 11:57 +0530, Nayak, Rajendra wrote:
> > -----Original Message-----
> > From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com] 
> > Sent: Friday, April 23, 2010 4:49 PM
> > To: Nayak, Rajendra
> > Cc: linux-omap@vger.kernel.org; Liam Girdwood; Samuel Ortiz
> > Subject: Re: [PATCH] twl6030: regulator: Remove vsel tables 
> > and use formula for calculation
> > 
> > On Thu, Apr 22, 2010 at 02:18:32PM +0530, Rajendra Nayak wrote:
> > > All twl6030 regulators can be programmed from 1.0v to 3.3v
> > > with 100mV steps.
> > > The below formula can be used to calculate the vsel values
> > > to be programmed in the VREG_VOLTAGE registers.
> > 
> > Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> 
> Liam,
> 
> Would you be queuing this up for the next merge window?
> 

Sorry, looks like I missed this one.

Now applied.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk

