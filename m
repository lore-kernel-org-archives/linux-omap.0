From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH v5 0/12] dmtimer adaptation to platform_driver
Date: Tue, 7 Dec 2010 10:29:19 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03736F5022@dbde02.ent.ti.com>
References: <1291679059-13419-1-git-send-email-tarun.kanti@ti.com>
 <20101206162852.GA4924@manju-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37174 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752845Ab0LGE71 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Dec 2010 23:59:27 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id oB74xO7v028069
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 6 Dec 2010 22:59:26 -0600
In-Reply-To: <20101206162852.GA4924@manju-desktop>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: G, Manjunath Kondaiah [mailto:manjugk@ti.com]
> Sent: Monday, December 06, 2010 9:59 PM
> To: DebBarma, Tarun Kanti
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH v5 0/12] dmtimer adaptation to platform_driver
> 
> On Tue, Dec 07, 2010 at 05:14:07AM +0530, Tarun Kanti DebBarma wrote:
> > dmtimer adaptation to platform_driver.
> >
> > This patch series is adaptation of dmtimer code to platform driver
> > using omap_device and omap_hwmod abstraction.
> >
> > Tested on following platforms:
> > OMAP4430, OMAP3430, OMAP3630, OMAP2430
> > OMAP2420 -- Image with omap2plus_defconfig in too large to download on
> N800.
> 
> How about omap1? The mainline code happily compiles and boots on osk5912
> but this series is going to break omap1 build.
I have built and booted on OMAP1 during v3. This time I could not because
My OMAP1710 has gone bad. I am looking for one to test.
That's precisely the reason I have not mentioned OMAP1. 

> 
> As per Tony's comments for GPIO and DMA hwmod, the changes should build
> and
> boot for omap1 also.
Yes, I guess this is quite understood. Thanks anyways.

--
Tarun

