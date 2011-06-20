From: "Avinash.H.M." <avinashhm@ti.com>
Subject: Re: [PATCH v4] OMAP2/3: hwmod: fix the i2c-reset timeout during
 bootup
Date: Mon, 20 Jun 2011 15:13:34 +0530
Message-ID: <20110620094334.GA9174@avinash-laptop>
References: <1305906384-22061-1-git-send-email-avinashhm@ti.com>
 <20110605084915.GA2887@avinash-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:43162 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753169Ab1FTJoA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Jun 2011 05:44:00 -0400
Received: by mail-yw0-f46.google.com with SMTP id 9so2657668ywe.5
        for <linux-omap@vger.kernel.org>; Mon, 20 Jun 2011 02:43:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110605084915.GA2887@avinash-laptop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khil>

On Sun, Jun 05, 2011 at 02:19:15PM +0530, Avinash.H.M. wrote:

> On Fri, May 20, 2011 at 09:16:24PM +0530, Avinash.H.M wrote:
> > The sequence of _ocp_softreset doesn't work for i2c. The i2c module has a
> > special sequence to reset the module. The sequence is
> >  - Disable the I2C.
> >  - Write to SOFTRESET bit.
> >  - Enable the I2C.
> >  - Poll on the RESETDONE bit.
> > The sequence is implemented as a function and the i2c_class is updated with
> > the correct 'reset' pointer.  omap_hwmod_softreset function is implemented
> > which triggers the softreset by writing into sysconfig register. On following
> > this sequence, i2c module resets properly and timeouts are not seen.
> > 
> > Cc: Rajendra Nayak <rnayak@ti.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> > Cc: Benoit Cousson <b-cousson@ti.com>
> > Cc: Kevin Hilman <khilman@ti.com>
> > Signed-off-by: Avinash.H.M <avinashhm@ti.com>
> > ---
> 
> Hi Kevin, Paul ,
> 
> Ping .. could you please review this.

Hi Paul ,

I recently observed that the sequence we are following to reset i2c in
omap2, 3 is also applicable for omap4.  On checking the the omap4 TRM
sequence , i confirmed this.

The reason why there were no timeouts seen in omap4 was, because of the
'HWMOD_INIT_NO_RESET' flag in the omap4 i2c hwmods. Because of these
flags, hwmod wasn't really attempting to reset i2c in omap4 and hence no
timeouts were seen.

I ll extend the patch to omap4 and send out new patch, also fixing
comments from Tomi.  I ll send out v5 and you can review directly v5.

thanks ,

- Avinash

> 
> thanks ,
> 
> - Avinash
> 
