From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] staging: tidspbridge: enable watchdog by default
Date: Fri, 10 Feb 2012 08:16:57 -0800
Message-ID: <20120210161657.GA4162@kroah.com>
References: <20120201034445.GA2979@kroah.com>
 <CAMP44s2FNFwvjv=f7WvJG7qXpYVqq0i53FzPcPTAB2g1mUk1Fw@mail.gmail.com>
 <20120209173528.GA31726@kroah.com>
 <CAMP44s3jvYMSmQfvhKEzTz9iYq-dabLJ6qniFsjw9vZLqgP0Ng@mail.gmail.com>
 <20120209185923.GB10284@kroah.com>
 <CAMP44s3r1-rt6HqgmVuB_Kjd1LSo-75m=6GERUt+ATewBaFw-Q@mail.gmail.com>
 <CAB-zwWj0z9N_2RRHBBNcHPLYWRii2T8q+gMgBnA3+ux8Ojg9JA@mail.gmail.com>
 <20120210051849.GE1565@kroah.com>
 <20120210073554.e9047c25c3fff71028f03fb2@gmail.com>
 <CAMP44s29yn-vYThbr6cDsvvFgKVELW1nA=onkkVHwp4h2yi_hQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:34402 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756957Ab2BJQRH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Feb 2012 11:17:07 -0500
Received: by pbcun15 with SMTP id un15so2539873pbc.19
        for <linux-omap@vger.kernel.org>; Fri, 10 Feb 2012 08:17:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAMP44s29yn-vYThbr6cDsvvFgKVELW1nA=onkkVHwp4h2yi_hQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: "Justin P. Mattock" <justinmattock@gmail.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, Jiri Kosina <jkosina@suse.cz>, Felipe Contreras <felipe.contreras@nokia.com>, linux-omap@vger.kernel.org

On Fri, Feb 10, 2012 at 06:05:59PM +0200, Felipe Contreras wrote:
> > From 5c7ad6c00d051d5444474007cdbecdf14bf3d0cb Mon Sep 17 00:00:00 2001
> > From: "Justin P. Mattock" <justinmattock@gmail.com>
> > Date: Fri, 10 Feb 2012 07:19:45 -0800
> > Subject: [PATCH] Add dependency TIDSBRIDGE_WDT3 to TIDSBRIDGE.
> >
> > This would add the missing _dependency_ to tidsbridge to prevent a warning from happening.
> >
> > Note: my Kconfig skills are not the greatest so the below may or may not work.
> > I can't test this because I dont have the hardware.
> 
> Your patch *always* turns on TIDSPBRIDGE_WDT3, which is not what we
> want. Depending on the firmware, some people might want it off.

What firmware?  Why not document this properly somewhere in the help
entries?  Why not detect this automatically in the kernel based on the
firmware version?

> Basically, right now on the typical firmware, people have to either
> manually turn TIDSPBRIDGE_WDT3 on, or they will see the warning.

So, for the "typical" firmware, you do want this on, so the patch makes
sense.

How about the code be fixed so that it doesn't generate this type of
warning when using the "typical" firmware, instead of having to rely on
confusing Kconfig entries.

Still confused,

greg k-h
