From: Nishanth Menon <nm@ti.com>
Subject: Re: [RFC][PATCH 7/9] OMAP4: powerdomain: Update MPU powerdomain
 for 4460
Date: Thu, 26 May 2011 07:30:22 -0700
Message-ID: <20110526143020.GC2082@olorun>
References: <1306375016-707-1-git-send-email-nm@ti.com>
 <1306375016-707-8-git-send-email-nm@ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB593024D177F92@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:46010 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757878Ab1EZOa2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 May 2011 10:30:28 -0400
Received: by mail-yi0-f44.google.com with SMTP id 13so430289yic.31
        for <linux-omap@vger.kernel.org>; Thu, 26 May 2011 07:30:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024D177F92@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "Nayak, Rajendra" <rnayak@ti.com>

On 14:22-20110526, Premi, Sanjeev wrote:
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org 
> > [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Menon, Nishanth
> > Sent: Thursday, May 26, 2011 7:27 AM
> > To: linux-omap
> > Cc: Nayak, Rajendra
> > Subject: [RFC][PATCH 7/9] OMAP4: powerdomain: Update MPU 
> > powerdomain for 4460
> > 
> > From: Rajendra Nayak <rnayak@ti.com>
> > 
> > The 4460 platform has changes in the MPU powerdomain,
> > hence model a new powerdomain for it and identify
> > is using the CHIP_IS_OMAP446X macro.
> > Also move all the common powerdomains to use
> > CHIP_IS_44XX so they are reused on OMAP4460.
> > 
> [snip]...[snip]
> 
> > +static struct powerdomain mpu_446x_pwrdm = {
> > +	.name		  = "mpu_pwrdm",
> > +	.prcm_offs	  = OMAP4430_PRM_MPU_INST,
> > +	.prcm_partition	  = OMAP4430_PRM_PARTITION,
> > +	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4460),
> 
> [sp] This change doesn't go with the description above.
>      Shouldn't this be CHIP_IS_OMAP44XX or CHIP_IS_OMAP446X
>      to be more future safe?
hmm.. similar to Vikram's comment as well. Will switch to using 6X
and 3X instead of 60 and 30 if there are no contrary opinions.
-- 
Regards,
Nishanth Menon
