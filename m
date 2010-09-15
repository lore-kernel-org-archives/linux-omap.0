From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: RE: [v4 6/6] OMAP: WDT: Use PM runtime APIs instead of clk FW APIs
Date: Wed, 15 Sep 2010 11:01:02 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02CD25F989@dbde02.ent.ti.com>
References: <1284390809-11519-1-git-send-email-charu@ti.com>
	<1284390809-11519-7-git-send-email-charu@ti.com>
 <87zkvknqv4.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52396 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750774Ab0IOFbK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Sep 2010 01:31:10 -0400
In-Reply-To: <87zkvknqv4.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "wim@iguana.be" <wim@iguana.be>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Basak, Partha" <p-basak2@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Tuesday, September 14, 2010 11:35 PM
> To: Varadarajan, Charulatha
> Cc: tony@atomide.com; wim@iguana.be; linux-watchdog@vger.kernel.org;
> paul@pwsan.com; Cousson, Benoit; Nayak, Rajendra; Basak, Partha; linux-
> omap@vger.kernel.org
> Subject: Re: [v4 6/6] OMAP: WDT: Use PM runtime APIs instead of clk FW
> APIs
> 
> "Varadarajan, Charulatha" <charu@ti.com> writes:
> 
> > Call runtime pm APIs pm_runtime_put_sync() and pm_runtime_get_sync()
> > for enabling/disabling the clocks, sysconfig settings instead of using
> > clock FW APIs.
> >
> > Signed-off-by: Charulatha V <charu@ti.com>
> 
> Looks mostly good, one minor comment
> 
> [...]
> 
> > +static int wdt_runtime_suspend(struct device *dev)
> > +{
> > +	return 0;
> > +}
> > +
> > +static int wdt_runtime_resume(struct device *dev)
> > +{
> > +	return 0;
> > +}
> > +
> > +static const struct dev_pm_ops gpio_pm_ops = {
> > +	.runtime_suspend = wdt_runtime_suspend,
> > +	.runtime_resume	 = wdt_runtime_resume,
> > +};
> > +
> 
> This isn't needed anymore for 2.6.37, a fix for the return values in the
> generic runtime PM calls has been queued for 2.6.37[1]

Thanks. I've removed runtime_suspend/resume hooks from watchdog driver and
sent the next version of the series.

> 
> Kevin
> 
> [1] https://lists.linux-foundation.org/pipermail/linux-pm/2010-
> September/028466.html
