From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH v2] OMAP2+: PM: omap_device: API for set/get MSTANDBY
 mode
Date: Thu, 11 Nov 2010 13:33:42 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402DC1A8115@dbde02.ent.ti.com>
References: <1288095101-1294-1-git-send-email-manjugk@ti.com>
 <alpine.DEB.2.00.1011101548400.28301@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55203 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757812Ab0KKIDv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Nov 2010 03:03:51 -0500
In-Reply-To: <alpine.DEB.2.00.1011101548400.28301@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, "Gadiyar, Anand" <gadiyar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>


Hi Paul,

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com] 
> Sent: Thursday, November 11, 2010 4:45 AM
> To: G, Manjunath Kondaiah
> Cc: linux-omap@vger.kernel.org; Kevin Hilman; Gadiyar, Anand; 
> Cousson, Benoit
> Subject: Re: [PATCH v2] OMAP2+: PM: omap_device: API for 
> set/get MSTANDBY mode
> 
> Hello Manju,
[...]

> Nice patch description.  A few comments:
> 
> 1.  Is it the case that the MSTANDBYMODE only needs to switch between 
> (smart standby/force standby) and no standby?  Or will it 
> need to switch 
> between all three?

Requirement is - switch to no standby for short time and should be
reverted back to original standby mode. 
All the combinations are not required.

> 
> 2.  Rather than just using a single omap_device_mstandby() 
> function call, 
> I'd rather see something like omap_device_require_no_standby() and 
> omap_device_release_no_standby(). 

s/standby/mstandby ?
 
> omap_device_require_no_standby() would 
> force the initiator port into no-standby.  
> omap_device_release_no_standby() would return the initiator port 
> MSTANDBYMODE to whatever the state should be (this depends on whether 
> HWMOD_SWSUP_MSTDBY is set). 
 
How do we get previous stand by state in this API since standby mode is 
changed with "omap_device_require_no_standby"

> I'd rather not have the drivers 
> manage the 
> contents of the MSTANDBYMODE bits directly.  Then you should 
> be able to 
> drop _get_master_standbymode() and 
> omap_hwmod_get_master_idlemode() also.  
> Can you please make these changes?
> 
> 3. I have a few other comments below:
> 
> > 
> > Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
[...]
> > +int omap_hwmod_set_master_standbymode(struct omap_hwmod 
> *oh, u32 midlemode)
> > +{
> > +	u32 v;
> > +	int retval = 0;
> > +
> > +	if (!oh)
> > +		return -EINVAL;
> > +
> 
> I guess this needs to take the hwmod's mutex.
ok.
> 
> > +	v = oh->_sysc_cache;
> > +
> > +	retval = _set_master_standbymode(oh, midlemode, &v);
> > +	if (!retval)
> > +		_write_sysconfig(v, oh);
> 
> And release it here.
ok.

-Manjunath
