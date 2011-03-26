From: "Avinash.H.M." <avinashhm@ti.com>
Subject: Re: [PATCH] omap: hwmod: add syss reset done flags to omap2, omap3
 hwmods
Date: Sat, 26 Mar 2011 17:05:38 +0530
Message-ID: <20110326113538.GB3668@avinash-laptop>
References: <1298542123-3654-1-git-send-email-avinashhm@ti.com>
 <alpine.DEB.2.00.1103031427580.10981@utopia.booyaka.com>
 <20110314161609.GA10506@avinash-laptop>
 <alpine.DEB.2.00.1103242336410.21987@utopia.booyaka.com>
 <20110325062534.GA25480@avinash-laptop>
 <20110325072035.GB25480@avinash-laptop>
 <alpine.DEB.2.00.1103251124040.21987@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:58596 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752196Ab1CZLfy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 26 Mar 2011 07:35:54 -0400
Received: by iym7 with SMTP id 7so2472998iym.24
        for <linux-omap@vger.kernel.org>; Sat, 26 Mar 2011 04:35:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1103251124040.21987@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>

On Fri, Mar 25, 2011 at 11:24:31AM -0600, Paul Walmsley wrote:
> On Fri, 25 Mar 2011, Avinash.H.M. wrote:
> 
> > On Fri, Mar 25, 2011 at 11:56:34AM +0530, Avinash.H.M. wrote:
> > 
> > I am able to reproduce the issue. I am seeing the timeout prints for
> > i2c, gpio during bootup. I ll check why softreset is failing.
> > 
> > [    0.208892] omap_hwmod: i2c1: softreset failed (waited 10000 usec)
> > [    0.223114] omap_hwmod: i2c2: softreset failed (waited 10000 usec)
> > [    0.237335] omap_hwmod: i2c3: softreset failed (waited 10000 usec)
> > [    0.251525] omap_hwmod: gpio2: softreset failed (waited 10000 usec)
> > [    0.265594] omap_hwmod: gpio3: softreset failed (waited 10000 usec)
> > [    0.279693] omap_hwmod: gpio4: softreset failed (waited 10000 usec)
> > [    0.293762] omap_hwmod: gpio5: softreset failed (waited 10000 usec)
> > [    0.307861] omap_hwmod: gpio6: softreset failed (waited 10000 usec)
> 
> Just FYI, I don't see the gpio softreset failures on my boards here.
> 

Hi Paul,

Which boards are you testing? 

To be doubly sure, i ll confirm if the issue is board specific or not,
by testing on another 3430 sdp.

- Avinash

> 
> - Paul
