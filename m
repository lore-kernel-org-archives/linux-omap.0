From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: OMAP4 DSS clock setup
Date: Fri, 08 Apr 2011 19:35:31 +0300
Message-ID: <1302280531.18772.2.camel@deskari>
References: <1301467733.2333.83.camel@deskari>  <4D92F899.7010606@ti.com>
	 <1301483027.4045.16.camel@deskari>  <4D931E21.8090305@ti.com>
	 <1301489930.15095.51.camel@deskari>
	 <alpine.DEB.2.00.1104011925510.27897@utopia.booyaka.com>
	 <1301900022.2715.12.camel@deskari>
	 <alpine.DEB.2.00.1104071054390.29552@utopia.booyaka.com>
	 <1302241893.2102.21.camel@deskari>  <4D9F2B63.9010507@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:59499 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752433Ab1DHQfg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Apr 2011 12:35:36 -0400
Received: by mail-ey0-f171.google.com with SMTP id d26so1443084eyd.2
        for <linux-omap@vger.kernel.org>; Fri, 08 Apr 2011 09:35:35 -0700 (PDT)
In-Reply-To: <4D9F2B63.9010507@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "Semwal, Sumit" <sumit.semwal@ti.com>, "Taneja, Archit" <archit@ti.com>, linux-omap <linux-omap@vger.kernel.org>

On Fri, 2011-04-08 at 17:36 +0200, Cousson, Benoit wrote:
> Hi Tomi,
> 
> On 4/8/2011 7:51 AM, Valkeinen, Tomi wrote:

> > - If the modules are handled separately, how should the dependencies be
> > handled? For example, dss_core's reset will reset all the other modules
> > also, and most of the submodules need functions from dss_core and
> > dss_dispc. So should, say, dss_dsi then call functions in core and dispc
> > to "get" them, i.e. increase their pm runtime use count?
> 
> Are you sure about that? 
> The dss_core does not have any reset in the sysonfig (only a status), but the dispc does have one and the dsi as well.

Ah, I might be speaking only of OMAP2/3. I remember somebody saying that
the DSS reset bit on OMAP4 is marked as reserved. But for OMAP3 (and I
think for OMAP2 also) the DSS_SYSCONFIG reset bit will reset also the
rest of the DSS.

 Tomi


