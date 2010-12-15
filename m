From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH v5 0/12] dmtimer adaptation to platform_driver
Date: Wed, 15 Dec 2010 10:29:32 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037395BFDB@dbde02.ent.ti.com>
References: <1291679059-13419-1-git-send-email-tarun.kanti@ti.com>
 <874oafn61h.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43515 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754954Ab0LOE7l convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Dec 2010 23:59:41 -0500
In-Reply-To: <874oafn61h.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Kevin,
> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Wednesday, December 15, 2010 7:37 AM
> To: DebBarma, Tarun Kanti
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH v5 0/12] dmtimer adaptation to platform_driver
> 
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
> 
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
> And OMAP1?
BTW, I have posted v6 yesterday and in that for testing on N800
I have removed OMAP3 and OMAP4 options and I was able to download.

Coming to OMAP1, I am getting "Bad Magic Number" while download.
Looks like there is problem in selecting the right platform info.
I am trying to resolve this and test.
--
Tarun

> 
> Kevin
