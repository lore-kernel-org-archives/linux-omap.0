From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 0/4] Add I2C support to AM3517EVM
Date: Thu, 7 Jan 2010 23:10:33 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044A397EDD@dbde02.ent.ti.com>
References: <hvaibhav@ti.com>
	<1262614597-21685-1-git-send-email-hvaibhav@ti.com>
 <87vdfe94h4.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51717 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752012Ab0AGRlU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jan 2010 12:41:20 -0500
In-Reply-To: <87vdfe94h4.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>


> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Thursday, January 07, 2010 5:22 AM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org; tony@atomide.com
> Subject: Re: [PATCH 0/4] Add I2C support to AM3517EVM
> 
> hvaibhav@ti.com writes:
> 
> > From: Vaibhav Hiremath <hvaibhav@ti.com>
> >
> > This series of patchset adds support for I2C bus interface along
> with
> > respective slave devices -
> > 	- RTC-S35390A
> > 	- TSC2004
> > 	- TVP5146 decoder along with VPFE-capture
> >
> > Vaibhav Hiremath (4):
> >   AM3517EVM: Enable I2C Support
> >   AM3517: Add support for TSC2004 driver
> >   AM3517: Add RTC-S35390A support
> >   AM3517: Add VPFE Capture driver support
> >
> >  arch/arm/mach-omap2/board-am3517evm.c |  249
> +++++++++++++++++++++++++++++++++
> >  1 files changed, 249 insertions(+), 0 deletions(-)
> 
> Please add some more detailed changelogs in this series.
> 
[Hiremath, Vaibhav] Will update description and post is again.

Thanks,
Vaibhav

> Thanks,
> 
> Kevin
