From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: RE: [PATCH v2 1/5] OMAP2xxx: hwmod: add I2C hwmods for OMAP2420,
 2430
Date: Tue, 21 Sep 2010 19:00:38 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C003C21EE253@dbde02.ent.ti.com>
References: <1284734229-16281-1-git-send-email-rnayak@ti.com>
 <1284734229-16281-2-git-send-email-rnayak@ti.com>
 <alpine.DEB.2.00.1009210101560.17727@utopia.booyaka.com>
 <0680EC522D0CC943BC586913CF3768C003C21EE0E9@dbde02.ent.ti.com>
 <alpine.DEB.2.00.1009210126260.17727@utopia.booyaka.com>
 <alpine.DEB.2.00.1009210200450.17727@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57334 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751767Ab0IUNao convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Sep 2010 09:30:44 -0400
In-Reply-To: <alpine.DEB.2.00.1009210200450.17727@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>



> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Tuesday, September 21, 2010 1:36 PM
> To: Nayak, Rajendra
> Cc: linux-omap@vger.kernel.org; Kevin Hilman
> Subject: RE: [PATCH v2 1/5] OMAP2xxx: hwmod: add I2C hwmods for OMAP2420,
> 2430
> 
> On Tue, 21 Sep 2010, Paul Walmsley wrote:
> 
> > My original comment was somewhat inaccurate.  Looking again at the 2430
> > TRM, it looks like the idlest_reg_id is correct, but that the prcm_reg_id
> > is not quite correct, at least for the FCLKEN register - not currently
> > used by hwmod.  We may have to add a workaround flag for the 2430 I2CHS
> > case.
> >
> > I can see why this didn't cause a problem in your testing.  The clock
> > framework writes to the correct FCLKEN bit, and the hwmod code currently
> > doesn't touch the FCLKEN bit.  And then the hwmod code checks the
> > correct IDLEST bit.
> >
> > It may be that the clock framework is also buggy for the 2430 I2CHS case -
> > that code will probably write to CM_ICLKEN2_CORE for 2430 I2CHS, but it
> > should write to CM_ICLKEN1_CORE.  sigh...
> 
> Just double-checked the clock code and data - it looks like the clock code
> is doing the right thing for 2430 I2CHS: it uses CM_ICLKEN1_CORE,
> CM_FCLKEN2_CORE, and CM_IDLEST1_CORE, despite the commit log comments on
> 3dc2197579089c5b74c7fba666c8ccf1a449afb4, which are wrong.
> 
> So, that issue that I raised was a false alarm.  But it would be good if
> you could drop a comment at the top of the two 2430 I2CHS hwmod
> structures, and simply note that the CM_FCLKEN* registers for those IP
> blocks don't follow the usual pattern.  That way, that knowledge won't be
> lost completely once the IDLEST handling is removed from the clock
> framework, which we'll do as soon as the I2C hwmod code is merged.

Sure, will add a note on this.

> 
> Sorry about the confusion,
> 
> - Paul
