From: "Avinash.H.M." <avinashhm@ti.com>
Subject: Re: [PATCH] omap: hwmod: add syss reset done flags to omap2, omap3
 hwmods
Date: Fri, 25 Mar 2011 11:56:34 +0530
Message-ID: <20110325062534.GA25480@avinash-laptop>
References: <1298542123-3654-1-git-send-email-avinashhm@ti.com>
 <alpine.DEB.2.00.1103031427580.10981@utopia.booyaka.com>
 <20110314161609.GA10506@avinash-laptop>
 <alpine.DEB.2.00.1103242336410.21987@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:50742 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753307Ab1CYG0s (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Mar 2011 02:26:48 -0400
Received: by gxk8 with SMTP id 8so322240gxk.9
        for <linux-omap@vger.kernel.org>; Thu, 24 Mar 2011 23:26:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1103242336410.21987@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>

On Thu, Mar 24, 2011 at 11:38:15PM -0600, Paul Walmsley wrote:
> Hi Avinash,

Hi Paul, 

> 
> > > On Thu, 24 Feb 2011, Avinash.H.M wrote:
> > > 
> > > > Some of the omap2, omap3 peripherals support software reset. This
> > > > can be done through the softreset bit in sysconfig register.
> > > > The reset status can be checked through resetdone bit of
> > > > sysstatus register. syss_has_reset_status is added to the hwmod
> > > > database of peripherals which have resetdone bit in sysstatus register.
> > > > 
> > > > Cc: Rajendra Nayak <rnayak@ti.com>
> > > > Cc: Paul Walmsley <paul@pwsan.com>
> > > > Cc: Benoit Cousson <b-cousson@ti.com>
> > > > Cc: Kevin Hilman <khilman@ti.com>
> > > > Reviewed-by: Govindraj.R <govindraj.raja@ti.com>
> > > > Signed-off-by: Avinash.H.M <avinashhm@ti.com>
> 
> This patch is causing I2C softreset timeouts in the hwmod layer on OMAP2 
> and 3.  Could you please take a look at this and figure out what is going 
> on?

I ll start looking at this. I have a 3430 ES3.1 SDP, where i will check the
difference in behaviour with this patch. 

BTW, is there a test case which i should run to produce 'I2C softreset
timeouts' ? Can you give more information on how to reproduce the issue
?.

br,

- avinash

> 
> thanks,
> 
> - Paul
