From: "Avinash.H.M." <avinashhm@ti.com>
Subject: Re: [PATCH] omap: hwmod: add syss reset done flags to omap2, omap3
 hwmods
Date: Mon, 14 Mar 2011 21:46:25 +0530
Message-ID: <20110314161609.GA10506@avinash-laptop>
References: <1298542123-3654-1-git-send-email-avinashhm@ti.com>
 <alpine.DEB.2.00.1103031427580.10981@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:37727 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754488Ab1CNQQp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Mar 2011 12:16:45 -0400
Received: by mail-gy0-f180.google.com with SMTP id 13so1269566gyg.11
        for <linux-omap@vger.kernel.org>; Mon, 14 Mar 2011 09:16:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1103031427580.10981@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>

On Thu, Mar 03, 2011 at 02:28:21PM -0700, Paul Walmsley wrote:
> On Thu, 24 Feb 2011, Avinash.H.M wrote:
> 
> > Some of the omap2, omap3 peripherals support software reset. This
> > can be done through the softreset bit in sysconfig register.
> > The reset status can be checked through resetdone bit of
> > sysstatus register. syss_has_reset_status is added to the hwmod
> > database of peripherals which have resetdone bit in sysstatus register.
> > 
> > Cc: Rajendra Nayak <rnayak@ti.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> > Cc: Benoit Cousson <b-cousson@ti.com>
> > Cc: Kevin Hilman <khilman@ti.com>
> > Reviewed-by: Govindraj.R <govindraj.raja@ti.com>
> > Signed-off-by: Avinash.H.M <avinashhm@ti.com>
> 
> Thanks, queued for 2.6.39.

Thanks very much Paul.

br
- avinash

> 
> 
> - Paul
