From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH] omap: Add macros to evaluate cpu revision
Date: Thu, 22 Jul 2010 17:40:46 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E7D0A076@dbde02.ent.ti.com>
References: <1279725163-3481-1-git-send-email-premi@ti.com>
 <4C4710DB.6060901@ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0323B40084@dbde02.ent.ti.com>
 <4C481185.3090005@ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301E7C764FD@dbde02.ent.ti.com>
 <4C4821E9.6030405@ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301E7D0A002@dbde02.ent.ti.com>
 <4C482F8F.1090401@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38127 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752765Ab0GVMKu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Jul 2010 08:10:50 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o6MCAl3t009254
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 22 Jul 2010 07:10:49 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o6MCAlbU017600
	for <linux-omap@vger.kernel.org>; Thu, 22 Jul 2010 17:40:47 +0530 (IST)
In-Reply-To: <4C482F8F.1090401@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

 
<snip>---<snip>
> 
> > 
> > Here is a sample usage from one of the patch I am reworking
> > for submission here:
> > 
> > @@ -488,7 +494,9 @@ void omap_sram_idle(void)
> >         * of AUTO_CNT = 1 enabled. This takes care of errata 1.142.
> >         * Hence store/restore the SDRC_POWER register here.
> >         */
> > -       if (omap_rev() >= OMAP3430_REV_ES3_0 &&
> > +       if ((cpu_is_omap3630()
> > +               || cpu_is_omap3505() || cpu_is_omap3517()
> > +               || cpu_rev_ge(34xx, OMAP34XX_ES_3_0)) &&
> cpu_rev_ge(34xx, OMAP34XX_ES_3_0) -> this is the cause of my 
> comment on 
> dirty code - redundant OMAP34XX_ in the macro when I do say 
> it is 34xx 
> in the first parameter!
> 
> >             omap_type() != OMAP2_DEVICE_TYPE_GP &&
> >             core_next_state == PWRDM_POWER_OFF)
> >                 sdrc_pwr = sdrc_read_reg(SDRC_POWER);
> > 
> > Don't try to look more into the actual content of this example,
> > but try to use existing macros to re-implement this condition.
> > 
> > omap_rev() is always > OMAP3430_REV_ES3_0 for all OMAP35x devices;
> > even for OMAP3530 at ES2.1 level (0x35302034 > 0x34304034)
> > 
> > And the original condition doesn't hold good.
> > 
> > Try to visualize silicon revision viz. "2.1" for OMAP3505 requiring
> > the same example condition to be updated.
> 
> I see similar potential use in enabling quirks and features 
> (the above 
> code btw could be better handled with a single variable 
> errata which is 
> populated with a flag at pm_init time..
> 

Will have detailed response later...
But, 3530, 3505 and 3517 are not erratas. These are different silicons.
AND this patch has no relation to power management.

More and more silicons are going to be added to linux-omap tree as
they are based. They all will follow their own revision lifecycle.

I have no issues to go back and add the 2420 etc. but I don't have
much information on their revision history. If you provide me info,
I can update the patch OR you can submit a follow-up patch with
related changes. The macros don't change due to addition of additional
silicon revisions.

~sanjeev

> > 
> > ~sanjeev
> >> -- 
> >> Regards,
> >> Nishanth Menon
> 
> 
> -- 
> Regards,
> Nishanth Menon
> 