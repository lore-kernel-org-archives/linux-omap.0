From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v2] PM / Runtime: let rpm_resume() succeed if RPM_ACTIVE, even when disabled
Date: Sat, 22 Sep 2012 21:42:50 +0200
Message-ID: <201209222142.51183.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1209221131320.7497-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:39911 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752564Ab2IVTgT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 22 Sep 2012 15:36:19 -0400
In-Reply-To: <Pine.LNX.4.44L0.1209221131320.7497-100000@netrider.rowland.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Nishanth Menon <nm@ti.com>

On Saturday, September 22, 2012, Alan Stern wrote:
> On Sat, 22 Sep 2012, Rafael J. Wysocki wrote:
> 
> > On Saturday, September 22, 2012, Kevin Hilman wrote:
> 
> > OK, this looks good to me, thanks!
> > 
> > Alan, what do you think?
> > 
> > Rafael
> 
> > > --- a/drivers/base/power/runtime.c
> > > +++ b/drivers/base/power/runtime.c
> > > @@ -509,6 +509,9 @@ static int rpm_resume(struct device *dev, int rpmflags)
> > >   repeat:
> > >  	if (dev->power.runtime_error)
> > >  		retval = -EINVAL;
> > > +	else if (dev->power.disable_depth == 1 && dev->power.is_suspended
> > > +		 && dev->power.runtime_status == RPM_ACTIVE)
> > > +		retval = 1;
> > >  	else if (dev->power.disable_depth > 0)
> > >  		retval = -EACCES;
> > >  	if (retval)
> 
> Well, I'd prefer the indentation on the continuation line to be 
> different from the indentation of the following line, and I'd prefer 
> to have a comment explaining the reason for the exception.
> 
> But these are only matters of taste; the implementation itself looks 
> good.

Thanks!

I've applied the patch as v3.7 material (and fixed up the white space).

Rafael
