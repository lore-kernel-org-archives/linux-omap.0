From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 0/5] ARM: OMAP2/3/4: Reclaim the kernel IO address space
Date: Fri, 28 Aug 2009 22:17:40 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BA61646E@dbde02.ent.ti.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02BA29C203@dbde02.ent.ti.com>
 <87vdk8ywnl.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34611 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751714AbZH1Qrt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Aug 2009 12:47:49 -0400
In-Reply-To: <87vdk8ywnl.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


Thanks Kevin for review!!

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Friday, August 28, 2009 5:32 PM
> To: Shilimkar, Santosh
> Cc: Tony Lindgren; linux-omap@vger.kernel.org
> Subject: Re: [PATCH 0/5] ARM: OMAP2/3/4: Reclaim the kernel IO address
> space
> 
> "Shilimkar, Santosh" <santosh.shilimkar@ti.com> writes:
> 
> > This patch series is intended to free up the kernel IO address space for
> OMAP2XXX, OMAP3XXX and OMAP4430. It is generated against Tony's
> > "omap-headers "(2.6.31-rc6) branch and boot tested on OMAP3430 SDP and
> OMAP4430 platform.
> >
> > Some more combinations are possible but to make it uniform across
> > OMAP2, OMAP3 and OMAP4, these io combinations are chosen.
> >
> > If needed documentation entry can be created to ease up reading and
> debugging information.
> > 	Like "Documentation/arm/omap/io_map.txt"
> 
> Yes, this would be very helpful.
> 
> Otherwise, this series looks OK with me.
> 
> Acked-by: Kevin Hilman <khilman@deeprootsystems.com>

Will create the doc entry.

Regards,
Santosh
