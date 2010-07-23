From: "Taneja, Archit" <archit@ti.com>
Subject: RE: [PATCH 5/5] OMAP: DSS2: Context Save and Restore of Video3
 pipeline registers
Date: Fri, 23 Jul 2010 11:25:56 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560870305EEAA54@dbde02.ent.ti.com>
References: <1279540544-12682-1-git-send-email-archit@ti.com>
 <1279540544-12682-2-git-send-email-archit@ti.com>
 <1279540544-12682-3-git-send-email-archit@ti.com>
 <1279540544-12682-4-git-send-email-archit@ti.com>
 <1279540544-12682-5-git-send-email-archit@ti.com>
 <1279540544-12682-6-git-send-email-archit@ti.com>
 <19F8576C6E063C45BE387C64729E7394044ED62F6B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52683 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757313Ab0GWF4D convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Jul 2010 01:56:03 -0400
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044ED62F6B@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Janorkar, Mayuresh" <mayur@ti.com>, "Mittal, Mukund" <mmittal@ti.com>


> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap- 
> > owner@vger.kernel.org] On Behalf Of Taneja, Archit
> > Sent: Monday, July 19, 2010 5:26 PM
> > To: tomi.valkeinen@nokia.com
> > Cc: linux-omap@vger.kernel.org; Janorkar, Mayuresh; Mittal, Mukund; 
> > Taneja, Archit
> > Subject: [PATCH 5/5] OMAP: DSS2: Context Save and Restore of Video3 
> > pipeline registers
> > 
> > From: Mayuresh Janorkar <mayur@ti.com>
> > 
> > Context Save and Restore of Video3 pipeline registers.
> [Hiremath, Vaibhav] I still fill, we are un-necessary 
> dividing the patch here. This patch can very well be part of 
> another patch, 
> 
> [PATCH 2/5] OMAP: DSS2: Add Video 3 pipeline functionality in DISPC
> 
> In-fact, for me this should be consolidated single patch, 
> something like, 
> 
> OMAP: DSS2: Add Video-3 pipeline functionality
> 
> 
> I don't see any reason why we are fragmenting this into 
> multiple patches.
> 
> Thanks,
> Vaibhav
> 
> > 
[Archit] Okay, Does the following split sound good?:
-OMAP: DSS2: [1/2]Add Video-3 pipeline functionality in dispc
	- This patch will have all dispc related changes
-OMAP: DSS2: [2/2]Add Video-3 pipeline overlay object
	- This patch will add the new overlay and changes
	required in manager, irqs etc

Or does a single patch make more sense?

Thanks,

Archit