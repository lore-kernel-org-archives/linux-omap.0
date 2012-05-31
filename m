From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 3/3] ARM: OMAP3+: PM: VP: check only the VPINIDLE status
 bit
Date: Thu, 31 May 2012 18:39:20 -0500
Message-ID: <20120531233918.GC23870@horus>
References: <1337369601-14915-1-git-send-email-nm@ti.com>
 <1337369601-14915-4-git-send-email-nm@ti.com>
 <87k3zsvsm7.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:38041 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758629Ab2EaXjZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 May 2012 19:39:25 -0400
Received: by obbuo13 with SMTP id uo13so2242863obb.29
        for <linux-omap@vger.kernel.org>; Thu, 31 May 2012 16:39:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87k3zsvsm7.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 16:27-20120531, Kevin Hilman wrote:
> Nishanth Menon <nm@ti.com> writes:
> 
> > Currently we check against the entire 32 bits of the status register
> > Where, bits 1-31 are marked as reserved and mentioned in TRM as read
> > returns undefined values. 
> 
> ouch
> 
> > Hence, check against purely the vpinidle status bit.
> >
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: Kevin Hilman <khilman@ti.com>
> > Cc: linux-omap@vger.kernel.org
> > Cc: linux-arm-kernel@lists.infradead.org
> >
> > Reported-by: Vinay Amancha <vinaykumar@ti.com>
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> 
> Thanks for the fix.
> 
> Looking at this combined with the previous patches, since this same
> thing is done several places, it looks like we need a helper function
> 'omap_vp_wait_for_idle()' or similar.  That function will do the check,
> wait for timeout, and return an error if failure.  The callers can than
> do appropriate error handling upon failure.
> 
yep - i think a static inline should do just fine here considering just
a test_timeout is involved.
will post out a new series in a few mins.
-- 
Regards,
Nishanth Menon
