From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 0/2] Remove unused voltagedomain data for AM33xx
Date: Fri, 14 Jun 2013 08:14:57 -0500
Message-ID: <20130614131457.GA7569@kahuna>
References: <1371118124-15910-1-git-send-email-rnayak@ti.com>
 <alpine.DEB.2.02.1306140243380.5514@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56593 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752163Ab3FNNPX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Jun 2013 09:15:23 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1306140243380.5514@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>, khilman@linaro.org, hvaibhav@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 02:46-20130614, Paul Walmsley wrote:
> cc Kevin, Vaibhav
> 
> On Thu, 13 Jun 2013, Rajendra Nayak wrote:
> 
> > The powerdomain framework today expects to always have a voltagedomain
> > associated with a given powerdomain. We already have AM33xx which
> > has no Voltage Controller/Voltage Processor as part of PRCM.
> > There are more SoCs' to follow starting with AM437x and DRA7xx
> > which do not have VC/VP.
> > 
> > Instead of adding dummy voltage domain data files, make the powerdomain
> > framework aware of the fact that some SoCs' might not really have
> > scalable voltage domains.
> 
> Fine with me in principle if AM335x doesn't support voltage scaling.  
> Vaibhav, if this is okay for you, please ack it.  
just a nitpick :)
There is no VFSM auto scaling to retention voltage, nor is VC-VP IP
available here, but that does not mean DVFS voltage scaling does not
exist - it is done with traditional regulator framework using regular
shared I2C.

We now seem to be moving to a generation of SoCs where VC-VP has been
dumped in favor of allowing integration with PMIC which may talk SPI/I2C
over standard interfaces - this allows us to reach better product
options, but gives up on extreme low power scenarios we had seen in the
past on OMAP.
Overall, I love this idea.
Acked-by: Nishanth Menon <nm@ti.com>
> 
> Then, in terms of merging, probably Kevin would be the right person for 
> this since he's done much of the voltagedomain work.
-- 
Regards,
Nishanth Menon
