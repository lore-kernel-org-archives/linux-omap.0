From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [RFC] Common mechanism to identify Si revision
Date: Thu, 3 Sep 2009 16:19:35 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DD610004@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DD60FFF2@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47499 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754181AbZICKto convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Sep 2009 06:49:44 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n83AneGv018810
	for <linux-omap@vger.kernel.org>; Thu, 3 Sep 2009 05:49:46 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n83Andk8012675
	for <linux-omap@vger.kernel.org>; Thu, 3 Sep 2009 16:19:39 +0530 (IST)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DD60FFF2@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Premi, Sanjeev
> Sent: Thursday, September 03, 2009 4:14 PM
> To: linux-omap@vger.kernel.org
> Subject: [RFC] Common mechanism to identify Si revision
> 
> Hi,
> 
> Currently there are multiple mechanisms for identifying the 
> si revisions.
> 
> Most places the comparison is against omap_rev() as a whole 
> number. Example:
> 
> arch/arm/mach-omap2/board-3430sdp.c:695:    if (omap_rev() > 
> OMAP3430_REV_ES1_0)
> arch/arm/mach-omap2/board-3430sdp.c:728:    if (omap_rev() > 
> OMAP3430_REV_ES1_0)
> 
> Then, there are custom macros. Example (cpu.h):
> 
> #define CHIP_GE_OMAP3430ES3_1		(CHIP_IS_OMAP3430ES3_1)
> #define CHIP_GE_OMAP3430ES3		(CHIP_IS_OMAP3430ES3_0 | \
> 					 CHIP_GE_OMAP3430ES3_1)
> #define CHIP_GE_OMAP3430ES2		(CHIP_IS_OMAP3430ES2 | \
> 					 CHIP_GE_OMAP3430ES3)
> 
> The problem with comparing against a whole number is that 
> comparison is invalid
> for another processor series. E.g. OMAP3430 and OMAP3517.
> 
> Here, I am proposing a common mechanism to identify the si 
> revision; that focuses
> on the revision bits alone. (See code below)
> 
> The usage would then be (example):
> 
>    if (omap_rev() > OMAP3430_REV_ES1_0)
> 
> To
> 
>    if (cpu_is_omap34xx() && OMAP_REV_GT(OMAP_ES_1_0)
> 
> 
> Though I have not looked at the OMAP1 directory, I am 
> assuming similar case there.
> Since there aren't any new devices in the OMAP1 category, 
> this may not appear as
> a need. But consistency could help.
> 
> Few items that I feel need to be looked at:
> - Possible differences in the MASK defined for Si revision.
>   Irrespective of (possible) difference in the HW, the bits 
> in 'omap_revision' can
>   be same.
> 
> - How to phase in the change - one shot OR in steps.
> 
> I am not sending this as patch, for now; just to get the 
> discussion started.
> 
> Best regards,
> Sanjeev
> 

[sp] sorry, missed the return statement in the inline functions below:
     ... perils of writing code in mail :)

~sanjeev

> 
> (cpu.h)
> 
> /*
>  * Identify silicon revision.
>  */
> #define OMAP_REV_MASK		0x0000ff00
> 
> #define OMAP_ES_1_0		0x00
> #define OMAP_ES_2_0		0x10
> #define OMAP_ES_2_1		0x20
> #define OMAP_ES_3_0		0x30
> #define OMAP_ES_3_1		0x40
> 
> #define OMAP_REV_IS(revid)					
> 	\
> static inline u8 omap_rev_is_ ##revid (void)			
> 	\
> {								
> 	\
> 	(((omap_rev() & OMAP_REV_MASK) >> 8) == revid) ? 1 : 0 
> ;	\
> }
> 
> #define OMAP_REV_LT(revid)					
> 	\
> static inline u8 omap_rev_lt_ ##revid (void)			
> 	\
> {								
> 	\
> 	(((omap_rev() & OMAP_REV_MASK) >> 8) < revid) ? 1 : 0 ;	\
> }
> 
> #define OMAP_REV_LE(revid)					
> 	\
> static inline u8 omap_rev_le_ ##revid (void)			
> 	\
> {								
> 	\
> 	(((omap_rev() & OMAP_REV_MASK) >> 8) <= revid) ? 1 : 0 
> ;	\
> }
> 
> #define OMAP_REV_GE(revid)					
> 	\
> static inline u8 omap_rev_ge_ ##revid (void)			
> 	\
> {								
> 	\
> 	(((omap_rev() & OMAP_REV_MASK) >> 8) >= revid) ? 1 : 0 
> ;	\
> }
> 
> #define OMAP_REV_GT(revid)					
> 	\
> static inline u8 omap_rev_gt_ ##revid (void)			
> 	\
> {								
> 	\
> 	(((omap_rev() & OMAP_REV_MASK) >> 8) > revid) ? 1 : 0 ;	\
> }
> 
> OMAP_REV_IS(OMAP_ES_1_0)
> OMAP_REV_LT(OMAP_ES_1_0)
> OMAP_REV_LE(OMAP_ES_1_0)
> OMAP_REV_GT(OMAP_ES_1_0)
> OMAP_REV_GE(OMAP_ES_1_0)
> 
> OMAP_REV_IS(OMAP_ES_2_0)
> OMAP_REV_LT(OMAP_ES_2_0)
> OMAP_REV_LE(OMAP_ES_2_0)
> OMAP_REV_GT(OMAP_ES_2_0)
> OMAP_REV_GE(OMAP_ES_2_0)
> 
> OMAP_REV_IS(OMAP_ES_2_1)
> OMAP_REV_LT(OMAP_ES_2_1)
> OMAP_REV_LE(OMAP_ES_2_1)
> OMAP_REV_GT(OMAP_ES_2_1)
> OMAP_REV_GE(OMAP_ES_2_1)
> 
> OMAP_REV_IS(OMAP_ES_3_0)
> OMAP_REV_LT(OMAP_ES_3_0)
> OMAP_REV_LE(OMAP_ES_3_0)
> OMAP_REV_GT(OMAP_ES_3_0)
> OMAP_REV_GE(OMAP_ES_3_0)
> 
> OMAP_REV_IS(OMAP_ES_3_1)
> OMAP_REV_LT(OMAP_ES_3_1)
> OMAP_REV_LE(OMAP_ES_3_1)
> OMAP_REV_GT(OMAP_ES_3_1)
> OMAP_REV_GE(OMAP_ES_3_1)
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 