From: "Rajendra Nayak" <rnayak@ti.com>
Subject: RE: [PATCH 1/4] 34XX: PM: Workaround to check wether any fck is active before entering sleep
Date: Thu, 21 Aug 2008 15:11:12 +0530
Message-ID: <00f101c90372$0d1a43f0$LocalHost@wipultra1382>
References: <00cb01c90366$50605d90$LocalHost@wipultra1382>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57090 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751618AbYHUJl1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Aug 2008 05:41:27 -0400
In-Reply-To: <00cb01c90366$50605d90$LocalHost@wipultra1382>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Jouni Hogander' <jouni.hogander@nokia.com>, linux-omap@vger.kernel.org

 
> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Rajendra Nayak
> Sent: Thursday, August 21, 2008 1:47 PM
> To: 'Jouni Hogander'; linux-omap@vger.kernel.org
> Subject: RE: [PATCH 1/4] 34XX: PM: Workaround to check wether 
> any fck is active before entering sleep
> 
> Jouni,
> 
> I am having some issues applying these patches. Any idea whats wrong?

Ok.. so I figured this out. It was some mail client issue at my end.. 
sorry for the trouble.

> 
> (Stripping trailing CRs from patch.)
> patching file arch/arm/mach-omap2/pm34xx.c
> patch: **** malformed patch at line 66:         return 1;
> 
> regards,
> Rajendra
>  
> 
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org 
> > [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of 
> Jouni Hogander
> > Sent: Friday, August 15, 2008 1:17 PM
> > To: linux-omap@vger.kernel.org
> > Subject: [PATCH 1/4] 34XX: PM: Workaround to check wether any 
> > fck is active before entering sleep
> > 
> > This workaround shouldn't be needed when all drivers are 
> > configuring their sysconfig registers properly and using 
> > their clocks properly.
> > 
> > Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
> > ---
> >  arch/arm/mach-omap2/pm34xx.c |   37 
> > +++++++++++++++++++++++++++++++++++++
> >  1 files changed, 37 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/pm34xx.c 
> > b/arch/arm/mach-omap2/pm34xx.c index a57cf41..f30fa9e 100644
> > --- a/arch/arm/mach-omap2/pm34xx.c
> > +++ b/arch/arm/mach-omap2/pm34xx.c
> > @@ -174,10 +174,47 @@ static void omap_sram_idle(void)
> >  	omap2_gpio_resume_after_retention();
> >  }
> >  
> > +/* XXX This workaround shouldn't be needed when all drivers are 
> > +configuring
> > + * their sysconfig registers properly and using their clocks
> > + * properly. */
> > +static int omap3_fclks_active(void)
> > +{
> > +	u32 fck_core1 = 0, fck_core3 = 0, fck_sgx = 0, fck_dss = 0,
> > +		fck_cam = 0, fck_per = 0, fck_usbhost = 0;
> > +
> > +	fck_core1 = cm_read_mod_reg(CORE_MOD,
> > +				    CM_FCLKEN1);
> > +	if (is_sil_rev_greater_than(OMAP3430_REV_ES1_0)) {
> > +		fck_core3 = cm_read_mod_reg(CORE_MOD,
> > +					    OMAP3430ES2_CM_FCLKEN3);
> > +		fck_sgx = cm_read_mod_reg(OMAP3430ES2_SGX_MOD,
> > +					  CM_FCLKEN);
> > +		fck_usbhost = cm_read_mod_reg(OMAP3430ES2_USBHOST_MOD,
> > +					      CM_FCLKEN);
> > +	} else
> > +		fck_sgx = cm_read_mod_reg(GFX_MOD,
> > +					  OMAP3430ES2_CM_FCLKEN3);
> > +	fck_dss = cm_read_mod_reg(OMAP3430_DSS_MOD,
> > +				  CM_FCLKEN);
> > +	fck_cam = cm_read_mod_reg(OMAP3430_CAM_MOD,
> > +				  CM_FCLKEN);
> > +	fck_per = cm_read_mod_reg(OMAP3430_PER_MOD,
> > +				  CM_FCLKEN);
> > +	if (fck_core1 | fck_core3 | fck_sgx | fck_dss |
> > +	    fck_cam | fck_per | fck_usbhost)
> > +		return 1;
> > +	return 0;
> > +}
> > +
> >  static int omap3_can_sleep(void)
> >  {
> >  	if (!enable_dyn_sleep)
> >  		return 0;
> > +	/* XXX This workaround shouldn't be needed when all drivers are
> > +	 * configuring their sysconfig registers properly and 
> > using their
> > +	 * clocks properly. */
> > +	if (omap3_fclks_active())
> > +		return 0;
> >  	if (atomic_read(&sleep_block) > 0)
> >  		return 0;
> >  	return 1;
> > --
> > 1.5.5
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe 
> > linux-omap" in the body of a message to 
> > majordomo@vger.kernel.org More majordomo info at  
> > http://vger.kernel.org/majordomo-info.html
> > 
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

