From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH v2] OMAP2+: PM: omap_device: API for set/get MSTANDBY
 mode
Date: Fri, 12 Nov 2010 01:17:50 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1011110722530.28301@utopia.booyaka.com>
References: <1288095101-1294-1-git-send-email-manjugk@ti.com> <alpine.DEB.2.00.1011101548400.28301@utopia.booyaka.com> <E0D41E29EB0DAC4E9F3FF173962E9E9402DC1A8115@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33719 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752052Ab0KLIRv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Nov 2010 03:17:51 -0500
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E9402DC1A8115@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, "Gadiyar, Anand" <gadiyar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>

Hello Manju,

On Thu, 11 Nov 2010, G, Manjunath Kondaiah wrote:

> > -----Original Message-----
> > From: Paul Walmsley [mailto:paul@pwsan.com] 
> > Sent: Thursday, November 11, 2010 4:45 AM

> Requirement is - switch to no standby for short time and should be
> reverted back to original standby mode. 
> All the combinations are not required.

OK, good.

> > 2.  Rather than just using a single omap_device_mstandby() 
> > function call, 
> > I'd rather see something like omap_device_require_no_standby() and 
> > omap_device_release_no_standby(). 
> 
> s/standby/mstandby ?

Thanks, that makes more sense.

> > omap_device_require_no_standby() would 
> > force the initiator port into no-standby.  
> > omap_device_release_no_standby() would return the initiator port 
> > MSTANDBYMODE to whatever the state should be (this depends on whether 
> > HWMOD_SWSUP_MSTDBY is set). 
>  
> How do we get previous stand by state in this API since standby mode is 
> changed with "omap_device_require_no_standby"

I don't think it is needed.  The API is only valid while the hwmod is 
enabled, I think.  So *require_no_mstandby() would force the hwmod into 
no-MSTANDBY mode, and *release_no_mstandby() would place it into smart 
standby if HWMOD_SWSUP_MSTDBY is not set, and no standby if it is set.

- Paul
