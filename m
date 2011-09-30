From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH-V3 2/4] arm:omap:am33xx: Update common OMAP machine
 specific sources
Date: Fri, 30 Sep 2011 17:39:27 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB5930257840691@dbde02.ent.ti.com>
References: <hvaibhav@ti.com>
	<1316529142-27564-3-git-send-email-hvaibhav@ti.com> <87fwjjcfbt.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48946 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755742Ab1I3MJo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Sep 2011 08:09:44 -0400
In-Reply-To: <87fwjjcfbt.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Mohammed, Afzal" <afzal@ti.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Hilman, Kevin
> Sent: Tuesday, September 27, 2011 12:16 AM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org; paul@pwsan.com; 
> tony@atomide.com; linux-arm-kernel@lists.infradead.org; 
> Mohammed, Afzal
> Subject: Re: [PATCH-V3 2/4] arm:omap:am33xx: Update common 
> OMAP machine specific sources
> 
> <hvaibhav@ti.com> writes:
> 
> > From: Afzal Mohammed <afzal@ti.com>
> >
> > This patch updates the common machine specific source files for
> > support for AM33XX/AM335x with cpu type, macros for 
> identification of
> > AM33XX/AM335X device.
> >
> > Signed-off-by: Afzal Mohammed <afzal@ti.com>
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> 
> [...]
> 
> > @@ -3576,7 +3579,8 @@ int __init omap3xxx_clk_init(void)
> >  	 * Lock DPLL5 -- here only until other device init code can
> >  	 * handle this
> >  	 */
> > -	if (!cpu_is_ti816x() && (omap_rev() >= OMAP3430_REV_ES2_0))
> > +	if (!cpu_is_ti816x() && !cpu_is_am33xx() &&
> > +			(omap_rev() >= OMAP3430_REV_ES2_0))
> >  		omap3_clk_lock_dpll5();
> 
> This is getting ugly.  
> 
> Instead of continuing to expand this if-list, I think it's time for a
> new feature-flag for whether or not an SoC has DPLL5 instead.

I agree that the code is really getting ugly here. But, isn't
feature-flag going to be over-used with this and similar features?

Just thinking ahead, for these possible cases:
1) An soc adds DPLL6.
2) An soc uses DPLL5, but mechanism to lock is different.

Wouldn't it be better to have a scheme like this:
1) Define a simple structure for DPLLs.
2) Initialize the unused DPLLs to be null/ -1 early
   in arch/soc specific init.
3) The DPLL functions check for corresponding flag on
   entry.

~sanjeev

> 
> Kevin
> 
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 