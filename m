From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: RE: [PATCH 08/13] OMAP4: hwmod: Enable omap_device build for OMAP4
Date: Fri, 25 Jun 2010 00:59:35 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB032366B13A@dbde02.ent.ti.com>
References: <1277336563-24988-1-git-send-email-khilman@deeprootsystems.com>
	<1277336563-24988-9-git-send-email-khilman@deeprootsystems.com>
	<alpine.DEB.2.00.1006232310110.1550@utopia.booyaka.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB032366B0A0@dbde02.ent.ti.com>
 <87hbkse2t9.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46147 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751249Ab0FXT3r convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jun 2010 15:29:47 -0400
In-Reply-To: <87hbkse2t9.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>



> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Thursday, June 24, 2010 12:52 PM
> To: Nayak, Rajendra
> Cc: Paul Walmsley; linux-omap@vger.kernel.org; Cousson, Benoit
> Subject: Re: [PATCH 08/13] OMAP4: hwmod: Enable omap_device build for OMAP4
> 
> "Nayak, Rajendra" <rnayak@ti.com> writes:
> 
> >> -----Original Message-----
> >> From: Paul Walmsley [mailto:paul@pwsan.com]
> >> Sent: Thursday, June 24, 2010 12:11 AM
> >> To: Nayak, Rajendra
> >> Cc: Kevin Hilman; linux-omap@vger.kernel.org; Cousson, Benoit
> >> Subject: Re: [PATCH 08/13] OMAP4: hwmod: Enable omap_device build for
> OMAP4
> >>
> >> Hi Rajendra
> >>
> >> On Wed, 23 Jun 2010, Kevin Hilman wrote:
> >>
> >> > From: Rajendra Nayak <rnayak@ti.com>
> >> >
> >>
> >> Please add a brief patch changelog entry here.  Maybe just say this is
> >> necessary for integration code using omap_device to work on OMAP4?
> >
> > Yes, will do, not sure how that got missed.
> 
> Rajendra,
> 
> If you just reply here with the changelog entry, I will update it in
> this series.

Ok, this one should do.

Enable omap_device layer support for OMAP4, so that drivers can
use them to enable/idle/shutdown devices.

> 
> This patch is needed in this series as the patch
> "OMAP: create omap_devices for MPU, DSP, L3"  depends on it.
> 
> Thanks,
> 
> Kevin
