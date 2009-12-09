From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH v3 0/4] TWL patch series
Date: Wed, 9 Dec 2009 18:40:36 +0100
Message-ID: <20091209174035.GB6051@sortiz.org>
References: <19F8576C6E063C45BE387C64729E73940436CF8BF5@dbde02.ent.ti.com>
 <19F8576C6E063C45BE387C64729E73940437210696@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga12.intel.com ([143.182.124.36]:53175 "EHLO
	azsmga102.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753617AbZLIRiz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Dec 2009 12:38:55 -0500
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E73940437210696@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Krishnamoorthy, Balaji T" <balajitk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "a.zummo@towertech.it" <a.zummo@towertech.it>, "p_gortmaker@yahoo.com" <p_gortmaker@yahoo.com>, "tony@atomide.com" <tony@atomide.com>

Hi Balaji,

On Wed, Dec 09, 2009 at 11:09:33AM +0530, Krishnamoorthy, Balaji T wrote:
> Hi Samuel,
> 
> This patch is not merged. Please let me know if I am missing something
> so that i can post the patches rebased on the latest 2.6.32.
I'd appreciate if you could rebase your patches, and also address Amit's
concern on patch #3.

I'll merge these patches then.

Cheers,
Samuel.


> Thanks and Regards,
> Balaji T K
> 
> > -----Original Message-----
> > From: Krishnamoorthy, Balaji T
> > Sent: Thursday, October 01, 2009 5:35 PM
> > To: linux-omap@vger.kernel.org
> > Cc: Krishnamoorthy, Balaji T; Shilimkar, Santosh; Nayak, Rajendra;
> > a.zummo@towertech.it; p_gortmaker@yahoo.com; sameo@linux.intel.com;
> > tony@atomide.com
> > Subject: [PATCH v3 0/4] TWL patch series
> > 
> > This patch series v3 incorporates comments received earlier[1].
> > 
> > The upcoming TWL6030 is companion chip for OMAP4 like the current TWL4030
> > for OMAP3. The common modules like RTC, Regulator creates opportunity
> > to re-use the most of the code from twl4030.
> > 
> > 	[PATCH v3 01/04] ARM: OMAP: Rename twl4030* driver files to enable re-
> > use
> > 	[PATCH v3 02/04] ARM: OMAP: Rename all twl4030_i2c*.
> > 	[PATCH v3 03/04] ARM: OMAP: Rename twl4030_ in rtc-twl.c to make it
> > 				generic rtc
> > 	[PATCH v3 04/04] ARM: OMAP: Rename twl4030_ to twl_ in twl-regulator.c
> > to
> > 				make it generic reg
> > 
> > [1] http://marc.info/?l=linux-omap&m=124757921417187&w=2
> >   [PATCH 0/4] TWL patch series

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
