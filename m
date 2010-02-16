From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: RE: [PATCH 0/2 RFC]OMAP3430: hwmod FW for GPIO
Date: Tue, 16 Feb 2010 20:35:17 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C3CF809A@dbde02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB031E80D99F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43226 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755570Ab0BPPF0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Feb 2010 10:05:26 -0500
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB031E80D99F@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>



> -----Original Message-----
> From: Nayak, Rajendra
> Sent: Monday, February 15, 2010 12:25 PM
> To: Paul Walmsley; Varadarajan, Charulatha
> Cc: linux-omap@vger.kernel.org; tony@atomide.com;
> khilman@deeprootsystems.com
> Subject: RE: [PATCH 0/2 RFC]OMAP3430: hwmod FW for GPIO
> 
> 
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org
> > [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Paul Walmsley
> > Sent: Saturday, February 13, 2010 3:31 AM
> > To: Varadarajan, Charulatha
> > Cc: linux-omap@vger.kernel.org; tony@atomide.com;
> > khilman@deeprootsystems.com
> > Subject: Re: [PATCH 0/2 RFC]OMAP3430: hwmod FW for GPIO
> >
> > By the way:
> >
> > On Fri, 12 Feb 2010, Varadarajan, Charulatha wrote:
> >
> > > They are boot tested on SDP 3430 and compile tested
> > > for OMAP 2420 and 2430.
> >
> > This part is really offensively misleading.  It does not
> > matter whether
> > the code has been compile-tested on OMAP24xx if it could
> > never actually
> > run on OMAP24xx.
> 
> Charu,
> 
> You can mention explicitely in the cover letter that these patches
> would break omap2 functionality, since no hwmod struct's are added
> for omap2. I agree with Paul that saying they are compile tested might
> mislead someone in believing that these patches are tested on omap2.
> 

Rajendra & Paul, 
Ok. I will do the needful while sending out next version of the patch series.

> regards,
> Rajendra
> 
> >
> >
> > - Paul
> > --
> > 
