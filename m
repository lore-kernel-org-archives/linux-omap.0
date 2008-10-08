From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: Re: [PATCH 2/3] Adapt twl4030 power code to new twl4030 code
Date: Wed, 8 Oct 2008 09:49:13 +0300
Message-ID: <20081008064913.GA4542@codecarver.research.nokia.com>
References: <1223390050-11499-1-git-send-email-peter.de-schrijver@nokia.com> <1223390050-11499-2-git-send-email-peter.de-schrijver@nokia.com> <1223390050-11499-3-git-send-email-peter.de-schrijver@nokia.com> <200810070919.55138.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:40541 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469AbYJHGto (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Oct 2008 02:49:44 -0400
Content-Disposition: inline
In-Reply-To: <200810070919.55138.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

Hi David,

> 
> Your set of patches seems to have discarded support for quite
> a few platforms.  I don't quite know the details of what these
> PM scripts are doing ... could they be misbehaving on Beagle,
> so that they explain why "reboot" on RC8 fails?
> 
> 

It might. At least the warmreset script might cause problems on Beagle.
I'm not familiar enough with beagle to know for sure.

> > +static int __init twl4030_power_probe(struct platform_device *pdev)
> 
> Pretty much everything here is "init" code, which is fine;
> I like seeing smaller runtime images.  But:
> 
> 
> >  
> > @@ -340,4 +271,17 @@ static int __init twl4030_power_init(void)
> >  
> >  }
> >  
> > +static struct platform_driver twl4030_power = {
> > +	.probe		= twl4030_power_probe,
> > +	.driver		= {
> > +		.name = "twl4030_power",
> > +		.owner = THIS_MODULE,
> > +	},
> > +};
> > +
> > +static int __init twl4030_power_init(void)
> > +{
> > +	return platform_driver_register(&twl4030_power);
> 
> ... in that case, why not platform_driver_probe(), so there's
> not even a whiff of a notion that this driver remain init is
> done?
> 

That's correct. The 'driver' basically loads the scripts in the twl4030 and
that's it. The hw will then execute the scripts when necessary.

> And I can't help but wonder why this isn't just part of
> the twl4030-core code, without even a platform device/driver.

If you think all this script loading stuff can go into twl4030-core, I
can make a patch to move it there.

> 
> I didn't move it to drivers/mfd because it seemed almost all
> SDP-specific.  But to the extent that it's something generic
> and "part of the core", maybe that's where it should be.
> Not necessarily part of the same file.
> 

It's not SDP specific, but it is OMAP specific I think. At least I can't
see use cases outside OMAP2/3.

Cheers,

Peter.

-- 
goa is a state of mind
