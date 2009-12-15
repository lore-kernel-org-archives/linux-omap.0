From: "Pagare, Abhijit" <abhijitpagare@ti.com>
Subject: RE: [PATCH 0/5] OMAP4 Power Domain Framework Support
Date: Tue, 15 Dec 2009 19:31:14 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BC240747@dbde02.ent.ti.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02BC14194C@dbde02.ent.ti.com>
 <alpine.DEB.2.00.0912141628300.12561@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54432 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753971AbZLOOB0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Dec 2009 09:01:26 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Cousson, Benoit" <b-cousson@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>

Paul,

> thanks.  One other thing that I noticed: in the first powerdomain patch,in > arch/arm/plat-omap/include/plat/cpu.h, in struct omap_chip_id, the 'oc' 
> field needs to be a u16, rather than a u8.

Thanks, it has been taken care of.


> -----Original Message-----
> From: Pagare, Abhijit
> Sent: Tuesday, December 15, 2009 11:06 AM
> To: 'Paul Walmsley'
> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> Cousson, Benoit; Nayak, Rajendra
> Subject: RE: [PATCH 0/5] OMAP4 Power Domain Framework Support
> 
> Paul,
> 	There is one Fix patch for OMAP3 on top of which these patches
> should go in cleanly. I will post the fix patch and the rebased and tested
> patch-set soon.
> 
> Best Regards,
> Abhijit Pagare
> 
> > -----Original Message-----
> > From: Paul Walmsley [mailto:paul@pwsan.com]
> > Sent: Tuesday, December 15, 2009 5:00 AM
> > To: Pagare, Abhijit
> > Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > Cousson, Benoit; Nayak, Rajendra
> > Subject: Re: [PATCH 0/5] OMAP4 Power Domain Framework Support
> >
> > Hello Abhijit,
> >
> > On Fri, 11 Dec 2009, Pagare, Abhijit wrote:
> >
> > > This patch series adds support for OMAP4 power domain framework.
> >
> > Just tried applying these -- looks like this series (and probably the
> > clockdomain series also) needs to be refreshed to apply cleanly against
> > the current linux-omap head.  Could you please rebase, retest if needed,
> > and repost?

I have posted the patches rebased against the linux-omap head. Keep me updated with your inputs.

> >
> >
> > thanks,
> >
> > - Paul


Regards,
Abhijit

