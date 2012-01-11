From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-V2 1/3] arm:omap:omap4: Remove hardcoded reg-offs for
 PWRSTCTRL & PWRSTST
Date: Wed, 11 Jan 2012 16:21:06 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A8317A107A@DBDE01.ent.ti.com>
References: <1326017894-7632-1-git-send-email-hvaibhav@ti.com>
	<1326017894-7632-2-git-send-email-hvaibhav@ti.com> <87y5tfpgy3.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36669 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753324Ab2AKQVN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Jan 2012 11:21:13 -0500
In-Reply-To: <87y5tfpgy3.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Nayak, Rajendra" <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>

On Tue, Jan 10, 2012 at 23:39:56, Hilman, Kevin wrote:
> Vaibhav Hiremath <hvaibhav@ti.com> writes:
> 
> > This patch removes the existing hard-coded way of providing
> > offset to omap4_prminst_xxx API's and instead use offsets
> > provided in powerdomainsxxxx_data.
> >
> > Very much required for the new device AM33XX, where,
> >
> > PRM module in AM33XX is closer to OMAP4 PRM module, so it makes
> > complete sense to reuse all the code from existing OMAP4 implementation.
> > Having said that, ther is a catch here with respect to AM33XX device,
> >
> > The register offset in PRM module is not consistent
> > across (crazy IP integration), for example,
> >
> > PRM_XXX         PWRSTCTRL PWRSTST RSTCTRL RSTST
> > ===============================================
> > PRM_PER_MOD:    0x0C,     0x08,   0x00,   0x04
> > PRM_WKUP_MOD:   0x04,     0x08,   0x00,   0x0C
> > PRM_MPU_MOD:    0x00,     0x04,   0x08,   NA
> > PRM_DEVICE_MOD: NA,       NA,     0x00,   0x08
> >
> > So in order to reuse the existing OMAP4 code, we have to add
> > seperate entry for register offsets, especially
> > PWRSTCTRL & PWRSTST.
> >
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > Cc: Kevin Hilman <khilman@ti.com>
> > Cc: Rajendra Nayak <rnayak@ti.com>
> 
> Reviewed-by: Kevin Hilman <khilman@ti.com>
> 
Thanks Kevin,

> Minor nit below, but after that, looks OK to me, but this should be
> reviewed/merged by Paul/Benoit also.
> 
Paul/Benoit,

Can you also please review the patch series and let me know your comments?

Thanks,
Vaibhav
> [...]
> 
> >  void __init omap44xx_powerdomains_init(void)
> >  {
> > +	int i;
> > +
> >  	pwrdm_register_platform_funcs(&omap4_pwrdm_operations);
> > +	/* Initialise PRM reg offs to default value */
> > +	for (i = 0; powerdomains_omap44xx[i] != NULL; i++) {
> > +		struct powerdomain *pwrdm = powerdomains_omap44xx[i];
> 
> insert blank line here
> 

I will wait for Paul and Benoit comments and will fix it in next series.

Thanks,
Vaibhav

> > +		pwrdm->pwrstctrl_offs = OMAP4_PM_PWSTCTRL;
> > +		pwrdm->pwrstst_offs = OMAP4_PM_PWSTST;
> > +	}
> >  	pwrdm_register_pwrdms(powerdomains_omap44xx);
> >  	pwrdm_complete_init();
> >  }
> 
> Kevin
> 

