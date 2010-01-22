From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2 0/6] omap3: pm: Update TRITON power scripts and making it generic
Date: Thu, 21 Jan 2010 16:12:38 -0800
Message-ID: <87hbqfdmkp.fsf@deeprootsystems.com>
References: <1263922193-13468-1-git-send-email-x0080970@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:57292 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755375Ab0AVAMl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Jan 2010 19:12:41 -0500
Received: by pwi21 with SMTP id 21so367290pwi.21
        for <linux-omap@vger.kernel.org>; Thu, 21 Jan 2010 16:12:40 -0800 (PST)
In-Reply-To: <1263922193-13468-1-git-send-email-x0080970@ti.com> (Lesly A. M.'s message of "Tue\, 19 Jan 2010 22\:59\:53 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lesly A M <x0080970@ti.com>
Cc: linux-omap@vger.kernel.org

Lesly A M <x0080970@ti.com> writes:

> map3: pm: Update TRITON power scripts and making it generic
>
> This series of patch implements a updated TRITON power scripts.
> Also moving the sleep, wakeup & warm_reset sequence to a generic script file,
> which can be used by different OMAP3 board with the power companion chip TWL4030.

Hi Lesly,

Overall, I like the overall direction you're going.  I appreciate your
efforts to combine the common code and simplify things.  Thank you
very much for your efforts.

I may have some specific comments on some of the patches, but rather
than comment in detail on each patch, I have some comments/opinions on
the overall approach.

First, I think the series should be done in a slightly different
order.  Currently, you create the common twl4030-script file at the
end of series.  I'd rather see this done earlier on.

In other words, rather than create/update the scripts/setuptimes for
Z2 and 3630SDP in their board files and then remove them in following
patches, why not create the common code earlier in the series and
do minimal changes to the board files?  That would cause a lot fewer
lines changed, and make the series as a whole more understandable.

Second, your series is making it clear we need some common VC init.
And this common VC init should be probably be separated from PMIC
init/setup.  So before we go much further with this, I think it's time
for some common VC infrastructure.

So here's a proposal off the top of my head:

- create new file(s): vc34xx.c, vc.h (or something like that)
- move the common prm_setup_times init and structs there
- move VC init from pm34xx.c (omap3_pm_init_vc, configure_vc, etc.)

We'll then have all the VC init/setup in a single place.  

Also, along the lines of keeping PMIC and VC details separated, I
think there should be separate calls to get the T2 scripts and the VC
values from T2.  IOW, board code should call one function to get T2
scripts, and a separate one to override the VC values with PMIC
specifics.  This will scale better to other PMICs as well. Something
like:

        int twl_get_scripts(struct twl4030_power_data *);
        int twl_get_vc_timings(struct prm_setup_vc *);

The common VC init code could have the default prm_setup_vc values for
34xx and 36xx as well (the ones that are not overridden by the PMIC),
so these values to no have to be defined/duplicated in the various
board files.

Ideally, a board file that just wants the defaults and is not doing
any overrides should not have to define its own prm_setup_vc.  The
defaults should come from vc.c with the PMIC related values coming
from the PMIC init.

Sorry to get so long winded on this one...

We've been needing some cleanup in this area for some time, so before
I merge any more changes in this area, I'd like to see some
reorg/cleanup along the lines above.  

Kevin




