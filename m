From: "Avinash.H.M." <avinashhm@ti.com>
Subject: Re: [PATCH 1/2] OMAP2/3: hwmod: fix the i2c-reset timeout during
 bootup
Date: Tue, 5 Apr 2011 12:10:46 +0530
Message-ID: <20110405064046.GA19445@avinash-laptop>
References: <1301672047-31903-1-git-send-email-avinashhm@ti.com>
 <1301672047-31903-2-git-send-email-avinashhm@ti.com>
 <alpine.DEB.2.00.1104011423220.27897@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:42595 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751883Ab1DEGlB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Apr 2011 02:41:01 -0400
Received: by mail-gx0-f180.google.com with SMTP id 10so24911gxk.39
        for <linux-omap@vger.kernel.org>; Mon, 04 Apr 2011 23:40:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1104011423220.27897@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>

Hi Paul ,

Thanks for the review. 

> > +/* In register I2C_CON, Bit 15 is the I2C enable bit */
> > +#define I2C_EN				BIT(15)
> > +#define I2C_CON_OFFSET			0x24
> 
> This stuff, along with omap_i2c_reset(), doesn't belong in omap_hwmod.c, 
> which is common code that is not I2C-specific.  Please put it in 
> mach-omap2/i2c.c instead.

I agree. I ll move these I2C specific things from omap_hwmod.c to
mach-omap2/i2c.c.


[...]


> > + */
> > +int omap_i2c_reset(struct omap_hwmod *oh)
> > +{
> > +	u32 v = 0;
> 
> no need to initialize this to 0
> 
> > +	int ret = 0, c = 0;
> 
> no need to initialize ret to 0

OK . I ll remove initialization of 'v'.

Since now i am moving the function to i2c.c, i can't call _set_softreset
and _write_sysconfig(static functions in omap_hwmod.c). Instead, i ll
set the SOFTRESET bit and write into SYSC register directly. So i do not
need 'ret'. I ll remove it.

Just curios. I understand there is no use of initializing 'v' to 0
here. But by programming practice, i usually initialize local variables
to '0'. Is there anything wrong in doing this ? Any negative impact ?


[...]


> >  int omap_hwmod_register(struct omap_hwmod **ohs);
> > +int omap_i2c_reset(struct omap_hwmod *oh);
> 
> This should go into plat-omap/include/plat/i2c.h

Sure. I will move this change to plat/i2c.h. 

I ll send out the v2 of this shortly after testing.

thanks ,

- avinash

> 
> > +
> >  struct omap_hwmod *omap_hwmod_lookup(const char *name);
> >  int omap_hwmod_for_each(int (*fn)(struct omap_hwmod *oh, void *data),
> >  			void *data);
> > -- 
> > 1.7.1
> > 
> 
> 
> - Paul
