From: "Avinash.H.M." <avinashhm@ti.com>
Subject: Re: [PATCH 1/2] OMAP2/3: hwmod: fix the i2c-reset timeout during
 bootup
Date: Sat, 2 Apr 2011 13:00:21 +0530
Message-ID: <20110402073021.GA970@avinash-laptop>
References: <1301672047-31903-1-git-send-email-avinashhm@ti.com>
 <1301672047-31903-2-git-send-email-avinashhm@ti.com>
 <87k4fdllqd.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:50351 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750930Ab1DBHde (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 2 Apr 2011 03:33:34 -0400
Received: by iyf40 with SMTP id 40so6207214iyf.11
        for <linux-omap@vger.kernel.org>; Sat, 02 Apr 2011 00:30:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87k4fdllqd.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>

Hi Kevin, 

> 
> Shouldn't the final state be disabled after reset?  IOW, Shouldn't the
> I2C be disabled again after the polling?

Yes, the I2C should be disabled after polling. We need not explicitly
program it to disabled state because, the reset value of the I2C_EN bit
is '0'. So, it is kept disabled after reset.

> 
> Also, when reposting, please be sure to Cc the linux-arm-kernel mailing
> list for patches that are targetted for upstream.

Thanks for pointing it kevin.  I wasn't aware of this.  I will CC lak
for my further patches from now onwards.

thanks,

- avinash

