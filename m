From: "Avinash.H.M." <avinashhm@ti.com>
Subject: Re: [PATCH] omap: hwmod: add syss reset done flags to omap2, omap3
 hwmods
Date: Fri, 25 Mar 2011 12:50:35 +0530
Message-ID: <20110325072035.GB25480@avinash-laptop>
References: <1298542123-3654-1-git-send-email-avinashhm@ti.com>
 <alpine.DEB.2.00.1103031427580.10981@utopia.booyaka.com>
 <20110314161609.GA10506@avinash-laptop>
 <alpine.DEB.2.00.1103242336410.21987@utopia.booyaka.com>
 <20110325062534.GA25480@avinash-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:46586 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933067Ab1CYHUq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Mar 2011 03:20:46 -0400
Received: by mail-gw0-f44.google.com with SMTP id 20so366061gwb.3
        for <linux-omap@vger.kernel.org>; Fri, 25 Mar 2011 00:20:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110325062534.GA25480@avinash-laptop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>

On Fri, Mar 25, 2011 at 11:56:34AM +0530, Avinash.H.M. wrote:
> On Thu, Mar 24, 2011 at 11:38:15PM -0600, Paul Walmsley wrote:

[snip]

> This patch is causing I2C softreset timeouts in the hwmod layer on OMAP2 
> > and 3.  Could you please take a look at this and figure out what is going 
> > on?
> 
> I ll start looking at this. I have a 3430 ES3.1 SDP, where i will check the
> difference in behaviour with this patch. 
> 
> BTW, is there a test case which i should run to produce 'I2C softreset
> timeouts' ? Can you give more information on how to reproduce the issue
> ?.

Hi paul, 

I am able to reproduce the issue. I am seeing the timeout prints for
i2c, gpio during bootup. I ll check why softreset is failing.

[    0.208892] omap_hwmod: i2c1: softreset failed (waited 10000 usec)
[    0.223114] omap_hwmod: i2c2: softreset failed (waited 10000 usec)
[    0.237335] omap_hwmod: i2c3: softreset failed (waited 10000 usec)
[    0.251525] omap_hwmod: gpio2: softreset failed (waited 10000 usec)
[    0.265594] omap_hwmod: gpio3: softreset failed (waited 10000 usec)
[    0.279693] omap_hwmod: gpio4: softreset failed (waited 10000 usec)
[    0.293762] omap_hwmod: gpio5: softreset failed (waited 10000 usec)
[    0.307861] omap_hwmod: gpio6: softreset failed (waited 10000 usec)

br,

- avinash

> 
