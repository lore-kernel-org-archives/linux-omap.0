From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] omap: hwmod: add syss reset done flags to omap2, omap3
 hwmods
Date: Thu, 24 Mar 2011 23:38:15 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1103242336410.21987@utopia.booyaka.com>
References: <1298542123-3654-1-git-send-email-avinashhm@ti.com> <alpine.DEB.2.00.1103031427580.10981@utopia.booyaka.com> <20110314161609.GA10506@avinash-laptop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45697 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752353Ab1CYFiQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Mar 2011 01:38:16 -0400
In-Reply-To: <20110314161609.GA10506@avinash-laptop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Avinash.H.M." <avinashhm@ti.com>
Cc: linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>

Hi Avinash,

> > On Thu, 24 Feb 2011, Avinash.H.M wrote:
> > 
> > > Some of the omap2, omap3 peripherals support software reset. This
> > > can be done through the softreset bit in sysconfig register.
> > > The reset status can be checked through resetdone bit of
> > > sysstatus register. syss_has_reset_status is added to the hwmod
> > > database of peripherals which have resetdone bit in sysstatus register.
> > > 
> > > Cc: Rajendra Nayak <rnayak@ti.com>
> > > Cc: Paul Walmsley <paul@pwsan.com>
> > > Cc: Benoit Cousson <b-cousson@ti.com>
> > > Cc: Kevin Hilman <khilman@ti.com>
> > > Reviewed-by: Govindraj.R <govindraj.raja@ti.com>
> > > Signed-off-by: Avinash.H.M <avinashhm@ti.com>

This patch is causing I2C softreset timeouts in the hwmod layer on OMAP2 
and 3.  Could you please take a look at this and figure out what is going 
on?

thanks,

- Paul
