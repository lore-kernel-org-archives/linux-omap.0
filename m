From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH 04/11] OMAP3: DMA: HWMOD: Add hwmod data structures
Date: Wed, 4 Aug 2010 22:54:25 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402708B4F1B@dbde02.ent.ti.com>
References: <1280397545-27323-1-git-send-email-manjugk@ti.com>
	<1280397545-27323-5-git-send-email-manjugk@ti.com>
 <87eiefnyvs.fsf@deeprootsystems.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E9402708B48E3@dbde02.ent.ti.com>
 <4C593C11.5040600@ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C641E1E6@dbde02.ent.ti.com>
 <4C593F92.4070707@ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C641E209@dbde02.ent.ti.com>
 <4C594296.30706@ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C641E22C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58776 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755490Ab0HDRYc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Aug 2010 13:24:32 -0400
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C641E22C@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, "Sawant, Anand" <sawant@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Basak, Partha" <p-basak2@ti.com>, "Varadarajan, Charulatha" <charu@ti.com>





> -----Original Message-----
> From: Shilimkar, Santosh 
> Sent: Wednesday, August 04, 2010 4:08 PM
> To: Cousson, Benoit
> Cc: G, Manjunath Kondaiah; Kevin Hilman; 
> linux-omap@vger.kernel.org; Paul Walmsley; Tony Lindgren; 
> Sawant, Anand; Nayak, Rajendra; Basak, Partha; Varadarajan, Charulatha
> Subject: RE: [PATCH 04/11] OMAP3: DMA: HWMOD: Add hwmod data 
> structures
> 
> 
> 
> > -----Original Message-----
> > From: Cousson, Benoit
> > Sent: Wednesday, August 04, 2010 4:06 PM
> > To: Shilimkar, Santosh
> > Cc: G, Manjunath Kondaiah; Kevin Hilman; 
> linux-omap@vger.kernel.org; Paul
> > Walmsley; Tony Lindgren; Sawant, Anand; Nayak, Rajendra; 
> Basak, Partha;
> > Varadarajan, Charulatha
> > Subject: Re: [PATCH 04/11] OMAP3: DMA: HWMOD: Add hwmod 
> data structures
> > 
> <snip>
> > >>
> > >> The point is to "enable" the device when at least one 
> channel is in use
> > >> and "disable" it when every channel are released. We do 
> have only one
> > >> DMA IP that managed several channels, since pm_runtime is doing
> > >> reference counting, we can call get for each channel 
> request and put
> > for
> > >> each release.
> > >> Did I miss something?
> > > We are saying same thing more or less :)
> > 
> > That was my impression as well, but I was not sure :-)
> > 
> > > Since it's one IP, and say have one clock, then doing per channel
> > runtime
> > > get/put is redundant, No?
> > 
> > If the DMA driver is already counting the number of channel in use,
> > you're right we can avoid that. It is already the case today?
> > 
> Yes. That's the case I was refrering
> 

Agreed. I will incorporate this comment in next version.

-Manjunath