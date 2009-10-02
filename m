From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH v3 0/4] TWL6030 patch series
Date: Fri, 2 Oct 2009 12:03:40 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BAEE9190@dbde02.ent.ti.com>
References: <19F8576C6E063C45BE387C64729E73940436CF8BFA@dbde02.ent.ti.com>
 <87ocorc64e.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57879 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756816AbZJBGdu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Oct 2009 02:33:50 -0400
In-Reply-To: <87ocorc64e.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "Krishnamoorthy, Balaji T" <balajitk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nayak, Rajendra" <rnayak@ti.com>, "a.zummo@towertech.it" <a.zummo@towertech.it>, "p_gortmaker@yahoo.com" <p_gortmaker@yahoo.com>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "tony@atomide.com" <tony@atomide.com>


> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Friday, October 02, 2009 12:08 AM
> To: Krishnamoorthy, Balaji T
> Cc: linux-omap@vger.kernel.org; Shilimkar, Santosh; Nayak, Rajendra;
> a.zummo@towertech.it; p_gortmaker@yahoo.com; sameo@linux.intel.com;
> tony@atomide.com
> Subject: Re: [PATCH v3 0/4] TWL6030 patch series
> 
> "Krishnamoorthy, Balaji T" <balajitk@ti.com> writes:
> 
> > This patch series v3 incorporates comments received earlier[1].
> >
> > The upcoming TWL6030 is companion chip for OMAP4 like the current
> TWL4030
> > for OMAP3. This patch series adds support for TWL6030 irq framework, and
> > driver support for RTC and regulator.
> >
> > These patches has dependancy on TWL patch series[2]
> > 	[PATCH v3 01/04] OMAP4: PMIC: Add support for twl6030 irq framework
> > 	[PATCH v3 02/04] OMAP4: PMIC: Add support for twl6030 RTC
> > 	[PATCH v3 03/04] OMAP4: PMIC: Add support for twl6030 regulators
> > 	[PATCH v3 04/04] OMAP4: PMIC: Update TWL mfd driver to create
> twl6030
> > 				Regulators
> >
> > [1] http://marc.info/?l=linux-omap&m=125050037530307&w=2
> > [RFC][PATCH 0/4] TWL6030 patch series
> >
> > [2] http://marc.info/?l=linux-omap&m=125439874001377&w=2
> > [PATCH v3 0/4] TWL patch series
> 
> In the future, please report what platforms this was tested on and
> whether it was just compile tested, boot tested or actually
> functionally tested.
Yes. That information is necessary for such a change.
These patches were boot tested on 3430SDP, 4430SDP. Also some additional driver testing is done for I2C and RTC.


Regards,
Santosh
