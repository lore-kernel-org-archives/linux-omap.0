From: Seth Forshee <seth.forshee@gmail.com>
Subject: Re: [PATCH] I2C: Fix OMAP I2C status register handling in IRQ processing
Date: Wed, 12 Mar 2008 14:51:47 -0500
Message-ID: <20080312195146.GA18324@ubuntu-workstation>
References: <20080312175609.GA9811@ubuntu-workstation> <726835a879584696afcb396dfcabdc64@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.246]:45874 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867AbYCLTwe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Mar 2008 15:52:34 -0400
Received: by an-out-0708.google.com with SMTP id d31so733162and.103
        for <linux-omap@vger.kernel.org>; Wed, 12 Mar 2008 12:52:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <726835a879584696afcb396dfcabdc64@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org

On Wed, Mar 12, 2008 at 01:14:32PM -0500, Felipe Balbi wrote:
> > -	int count = 0;
> > +	int err, count = 0;
> 
> int err = 0, count = 0; will be better and you avoid that err=0 before
> using err right below.

No, the err = 0 I added is in a while loop.  It needs to be
reinitialized for each iteration.

> > +		if (stat & (OMAP_I2C_STAT_ARDY | OMAP_I2C_STAT_NACK |
> > +					OMAP_I2C_STAT_AL))
> 
> err should already hold them, how about
> if (stat & err)

err will not hold ARDY, so it would need to be

	if (stat & (err | OMAP_I2C_STAT_ARDY))

But I don't see the advantage.  Comparing the assembly, what I
submitted generates one less instruction than the above, so the
difference appears to be trivial.

Cheers,
Seth
