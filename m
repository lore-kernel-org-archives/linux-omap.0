From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [RFC] OMAP3 : PM : Handle variable length OPP tables
Date: Fri, 11 Sep 2009 14:21:50 -0700
Message-ID: <87eiqd5g9d.fsf@deeprootsystems.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DD6C43CA@dbde02.ent.ti.com>
	<87my528xgv.fsf@deeprootsystems.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301DD7D0A9A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f189.google.com ([209.85.216.189]:49519 "EHLO
	mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751923AbZIKVVu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Sep 2009 17:21:50 -0400
Received: by pxi27 with SMTP id 27so1083394pxi.15
        for <linux-omap@vger.kernel.org>; Fri, 11 Sep 2009 14:21:53 -0700 (PDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DD7D0A9A@dbde02.ent.ti.com> (Sanjeev Premi's message of "Fri\, 11 Sep 2009 11\:42\:36 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Premi, Sanjeev" <premi@ti.com> writes:

>> -----Original Message-----
>> From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
>> Sent: Friday, September 11, 2009 12:00 AM
>> To: Premi, Sanjeev
>> Cc: linux-omap@vger.kernel.org
>> Subject: Re: [RFC] OMAP3 : PM : Handle variable length OPP tables
>> 
>> "Premi, Sanjeev" <premi@ti.com> writes:
>> 
>> > Hi all,
>> >
>> > There is no generic function to translate an OPP to FREQ 
>> and vice versa.
>> > Came across the problem while trying to submit a follow-up 
>> to earlier
>> > patch for change in mpurate via bootargs. 
>> >
>> > The function get_opp in resource34xx.c, but it is always 
>> called with an
>> > explicit addition of MAX_VDDn_OPP e.g.
>> >
>> >   opp = get_opp(mpu_opps + MAX_VDD1_OPP, clk->rate);
>> >   opp = get_opp(l3_opps + MAX_VDD2_OPP, clk->rate);
>> >
>> > This is 'addition' is required as there is no encapsulation of the
>> > MIN and MAX VDDs associated to the table.
>> >
>> > The patch below fixes this issue; buy creating a 'table' object with
>> > necessary information. It can also help in getting rid of the
>> > empty {0, 0, 0} at index 0 of each OPP table.
>> >
>> > At the moment, it does not break any functionality in 
>> resource34xx.c;
>> > migration to this encapsulation can be taken as next step.
>> >
>> > This code is bare 'git-diff' for early comments. Formal 
>> patch to follow...
>> >
>> > Best regards,
>> > Sanjeev
>> 
>> Is the goal of the min and max fields so you could have some OPPs
>> in the table that aren't valid for some SoCs?  IOW, the 'max' value
>> might be higher on newer SoCs with higher OPPs.
>
> The goal is to have get_*() functions where caller shouldn't be aware
> of the MAX_ for the table. Considering table as an object, it should
> be able to provide its own length.
>
> Reason to use min and max was to maintain current functionality as is.
> Else, simple 'length' should be sufficient.
>
>> 
>> What if you want a list of OPPs, but want to remove one from the
>> middle of the list?  The min/max approach doesn't work here.
>> 
>> What about a also extending the struct omap_opp to have some sort of
>> valid field.
>
> This doesn't help in eliminating the addition of MAX value for each
> function call.

No it doesn't.  I'm just thinking about the next step of having a more flexible list of OPPs.

Kevin

>> 
>> >
>> > diff --git a/arch/arm/plat-omap/include/mach/omap-pm.h 
>> b/arch/arm/plat-omap/include/mach/omap-pm.h
>> > index 583e540..2357784 100644
>> > --- a/arch/arm/plat-omap/include/mach/omap-pm.h
>> > +++ b/arch/arm/plat-omap/include/mach/omap-pm.h
>> > @@ -33,6 +33,20 @@ struct omap_opp {
>> >         u16 vsel;
>> >  };
>> >  
>> > +/* struct omap_opp_table - View OPP table as an object
>> > + * @min: Minimum OPP id
>> > + * @max: Maximim OPP id
>> > + * @opps: Pointer to array defining the OPPs.
>> > + *
>> > + * An OPP table has varied length. Knowing minimum and maximum
>> > + * OPP ids allow easy traversal.
>> > + */
>> > +struct omap_opp_table {
>> > +       u8      min;
>> > +       u8      max;
>> > +       struct omap_opp* opps;
>> > +};
>> > +
>> >  extern struct omap_opp *mpu_opps;
>> >  extern struct omap_opp *dsp_opps;
>> >  extern struct omap_opp *l3_opps;
>> > diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
>> > index fec7d00..c90b1af 100644
>> > --- a/arch/arm/mach-omap2/pm.c
>> > +++ b/arch/arm/mach-omap2/pm.c
>> > @@ -33,6 +33,7 @@
>> >  #include <mach/powerdomain.h>
>> >  #include <mach/resource.h>
>> >  #include <mach/omap34xx.h>
>> > +#include <mach/omap-pm.h>
>> >  
>> >  #include "prm-regbits-34xx.h"
>> >  #include "pm.h"
>> > @@ -281,3 +282,50 @@ static int __init omap_pm_init(void)
>> >         return error;
>> >  }
>> >  late_initcall(omap_pm_init);
>> > +
>> > +/*
>> > + * Get frequency corresponding to an OPP
>> > + */
>> > +int opp_to_freq(unsigned int* freq, struct omap_opp_table* 
>> table, u8 opp)
>> > +{
>> > +        int i, found=0;
>> > +
>> > +        if (table && table->opps) {
>> > +                for (i=table->min;  table->opps[i].opp_id 
>> <= table->max; i++)
>> > +                        if (table->opps[i].opp_id == opp) {
>> > +                                found = 1;
>> > +                                break;
>> > +                        }
>> > +
>> > +                if (found) {
>> > +                        *freq = table->opps[i].rate;
>> > +                        return 1;
>> > +                }
>> > +        }
>> > +
>> > +        return 0;
>> > +}
>> > +
>> > +/*
>> > + * Get OPP corresponding to a frequency
>> > + */
>> > +int freq_to_opp(u8* opp, struct omap_opp_table* table, 
>> unsigned long freq)
>> > +{
>> > +        int i, found=0;
>> > +
>> > +        if (table && table->opps) {
>> > +                for (i=table->min;  table->opps[i].opp_id 
>> <= table->max; i++)
>> > +                        if (table->opps[i].rate == freq) {
>> > +                                found = 1;
>> > +                                break;
>> > +                        }
>> > +
>> > +                if (found) {
>> > +                        *opp = table->opps[i].opp_id;
>> > +                        return 1;
>> > +                }
>> > +        }
>> > +
>> > +        return 0;
>> > +}
>> > +
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe 
>> linux-omap" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> 
>> 
