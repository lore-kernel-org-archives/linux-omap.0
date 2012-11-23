From: Tero Kristo <t-kristo@ti.com>
Subject: Re: OMAP4430 produces boot warnings
Date: Fri, 23 Nov 2012 11:34:38 +0200
Message-ID: <1353663278.25248.4.camel@sokoban>
References: <20121121230337.GR3332@n2100.arm.linux.org.uk>
	 <50AE1DC0.3030002@ti.com>  <50AE2BB6.8080406@ti.com>
	 <1353594842.786.45.camel@sokoban>  <50AE3A5B.5040603@ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45301 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759091Ab2KWJfI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 Nov 2012 04:35:08 -0500
In-Reply-To: <50AE3A5B.5040603@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Archit Taneja <archit@ti.com>, Rajendra Nayak <rnayak@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

On Thu, 2012-11-22 at 16:44 +0200, Tomi Valkeinen wrote:
> On 2012-11-22 16:34, Tero Kristo wrote:
> 
> > I guess you checked that DSS pwrdm is switching between RET and ON in
> > your setup?
> 
> Yes:
> 
> # cat /debug/pm_debug/count |grep dss
> [   35.356567] pwrdm state mismatch(l3init_pwrdm) 3 != 1
> [   35.361938] pwrdm state mismatch(cam_pwrdm) 3 != 0
> [   35.366973] pwrdm state mismatch(ivahd_pwrdm) 3 != 1
> [   35.372253] pwrdm state mismatch(tesla_pwrdm) 3 != 1
> [   35.377532] pwrdm state mismatch(abe_pwrdm) 3 != 1
> dss_pwrdm (RET),OFF:1,RET:11,INA:0,ON:11,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
> l3_dss_clkdm->dss_pwrdm (0)
> 
> then I load and unload the dss modules, and then:
> 
> # cat /debug/pm_debug/count |grep dss
> [   60.813629] pwrdm state mismatch(l3init_pwrdm) 3 != 1
> [   60.819000] pwrdm state mismatch(cam_pwrdm) 3 != 0
> [   60.824127] pwrdm state mismatch(ivahd_pwrdm) 3 != 1
> [   60.829376] pwrdm state mismatch(tesla_pwrdm) 3 != 1
> [   60.834625] pwrdm state mismatch(abe_pwrdm) 3 != 1
> dss_pwrdm (ON),OFF:1,RET:21,INA:0,ON:22,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
> l3_dss_clkdm->dss_pwrdm (0)
> 
> >> Does the pwrdm mistakenly think that in RET state the DSS still keeps
> >> the register contents?
> > 
> > This might be the case, however the pwrdm code should be generic and
> > handle all domains properly. What is the tree / branch / commit you are
> > using for testing this stuff? I can take a look at this also.
> 
> arm-soc/for-next

I guess this is caused because some of the patches are still not in the
for-next branch, it looks like at least this is missing:

https://patchwork.kernel.org/patch/1608901/

...or the latest update done by Paul to that one.

The patch I posted appears to have a small merge induced bug, it is
registering the context loss soc_ops for am33xx when it should actually
register those for omap4. This might explain another bug I've been
looking at in a different branch recently... The update Paul posted does
not seem to have this problem, but I haven't tested it myself.

-Tero


