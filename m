From: "Lesly Arackal Manuel" <leslyam@ti.com>
Subject: RE: [PATCH v6 1/7] omap3: pm: fix for twl4030 script load
Date: Fri, 4 Jun 2010 12:58:17 +0530
Message-ID: <007301cb03b7$8248f8f0$e08818ac@apr.dhcp.ti.com>
References: <1274185973-23839-1-git-send-email-leslyam@ti.com> <87bpbsyr17.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37148 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752022Ab0FDH23 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 Jun 2010 03:28:29 -0400
In-Reply-To: <87bpbsyr17.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Kevin Hilman' <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, 'Lesly A M' <x0080970@ti.com>, 'Nishanth Menon' <nm@ti.com>, 'David Derrick' <dderrick@ti.com>, 'Samuel Ortiz' <sameo@linux.intel.com>

Hi Kevin,

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Thursday, June 03, 2010 10:47 PM
> To: Lesly A M
> Cc: linux-omap@vger.kernel.org; Lesly A M; Nishanth Menon; David Derrick;
> Samuel Ortiz
> Subject: Re: [PATCH v6 1/7] omap3: pm: fix for twl4030 script load
> 
> Lesly A M <leslyam@ti.com> writes:
> 
> > This patch will fix the TRITON sleep/wakeup sequence.
> >
> > Since the function to populate the sleep script is getting called always
> > irrespective of the flag "TWL4030_SLEEP_SCRIPT", other scripts data
> > is getting over written by the sleep script.
> 
> OK, this is a clear bug fix and should be a patch on its own.

OK, I will split the patch in the next version.

> 
> > Print warning if the sleep script is loaded before wakeup script.
> > Because there is a chance that the Power chip may go to sleep before
> > the wakeup script is completely loaded, which can cause a system hang.
> 
> OK, but your patch doesn't add this warning.  It's already  there.

The variable order is updated to '1' during wakeup script for P1_P2 is
populated, and the warning is printed while loading sleep script if order is
set to '1'(ie: warning is printed, if wakeup script is loaded before loading
the sleep script).

But actually we should print the warning, only if wakeup script is not
loaded before loading the sleep script. 

Regards,
Lesly A M
> 
> Kevin
> 
> > Signed-off-by: Lesly A M <x0080970@ti.com>
> > Cc: Nishanth Menon <nm@ti.com>
> > Cc: David Derrick <dderrick@ti.com>
> > Cc: Samuel Ortiz <sameo@linux.intel.com>
> > ---
> >  drivers/mfd/twl4030-power.c |    5 +++--
> >  1 files changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
> > index 7efa878..b4fc190 100644
> > --- a/drivers/mfd/twl4030-power.c
> > +++ b/drivers/mfd/twl4030-power.c
> > @@ -451,12 +451,13 @@ static int __init load_twl4030_script(struct
> twl4030_script *tscript,
> >  		if (err)
> >  			goto out;
> >  	}
> > -	if (tscript->flags & TWL4030_SLEEP_SCRIPT)
> > -		if (order)
> > +	if (tscript->flags & TWL4030_SLEEP_SCRIPT) {
> > +		if (!order)
> >  			pr_warning("TWL4030: Bad order of scripts (sleep "\
> >  					"script before wakeup) Leads to
boot"\
> >  					"failure on some boards\n");
> >  		err = twl4030_config_sleep_sequence(address);
> > +	}
> >  out:
> >  	return err;
> >  }
> > --
> > 1.7.0.4
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html

