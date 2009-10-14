From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: FEATURES prints
Date: Wed, 14 Oct 2009 09:54:18 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BB2551EA@dbde02.ent.ti.com>
References: <4ACE39CC.1070906@ti.com> <87ws2zge60.fsf@deeprootsystems.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301DDE20C25@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41125 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751414AbZJNEY7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Oct 2009 00:24:59 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DDE20C25@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Menon, Nishanth" <nm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Sanjeev,

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Premi, Sanjeev
> Sent: Wednesday, October 14, 2009 3:26 AM
> To: Kevin Hilman; Menon, Nishanth
> Cc: linux-omap@vger.kernel.org
> Subject: RE: FEATURES prints
> 
> 
> > -----Original Message-----
> > From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> > Sent: Wednesday, October 14, 2009 3:17 AM
> > To: Menon, Nishanth
> > Cc: Premi, Sanjeev; linux-omap@vger.kernel.org
> > Subject: Re: FEATURES prints
> >
> > Nishanth Menon <nm@ti.com> writes:
> >
> > > Folks,
> > >
> > > With the addition of FEATURES in l-o, the following prints:
> > >  - l2cache : Y
> > >  - iva : Y
> > >  - sgx : Y
> > >  - neon : Y
> > >  - isp : Y
> > >
> > > comes up on SDP3430 -> now that we will introduce half a dozen
> > > features here and there, we will soon clutter this up. we should
> > > introduce a sysfs entry + remove the above noise..
> > >
> >
> > Like Nishanth, I don't like the multi-line noise here.  The patch
> > below results in a single line output like this instead
> >
> > OMAP3430/3530 ES3.0 (l2cache iva sgx neon isp )
> >
> > Not sure why we need to dump features that are not there, but if that
> > s considered important, maybe prefixing each feature with a '+' or '-'
> > would still allow this to be collapsed into a single line.
> >
> > Even with this, I think adding the display of these features into an
> > OMAP-specific section of /proc/cpuinfo would be even better.
> >
> 
> [sp] Single line prints look good. We can also add details in cpuinfo.

If you are ok with proc entry then we don't even need this noise at all in the boot. It's just that adding proc entries is discouraged to some extent.

Regards,
Santosh
