From: Luciano Coelho <coelho@ti.com>
Subject: Re: [PATCH 0/2] ARM: OMAP2+: PM: code consolidation for 3.4
Date: Fri, 09 Mar 2012 08:15:02 +0200
Message-ID: <1331273702.18015.92.camel@cumari>
References: <20120202093600.12509.35052.stgit@dusk> <87ty39cc7s.fsf@ti.com>
	 <alpine.DEB.2.00.1202021140060.586@utopia.booyaka.com>
	 <alpine.DEB.2.00.1202021328450.586@utopia.booyaka.com>
	 <CAKd1q9rq67gUyXn+rOL348YwaYQiqHR8UQCSd68fpxhZHHsYGA@mail.gmail.com>
	 <87sjhjaqyi.fsf@ti.com> <1331232433.18015.69.camel@cumari>
	 <alpine.DEB.2.00.1203081153540.9551@utopia.booyaka.com>
	 <1331233547.18015.74.camel@cumari> <87d38mbxfu.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:46949 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751414Ab2CIGPV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Mar 2012 01:15:21 -0500
Received: by mail-lb0-f181.google.com with SMTP id k6so267544lbo.12
        for <linux-omap@vger.kernel.org>; Thu, 08 Mar 2012 22:15:06 -0800 (PST)
In-Reply-To: <87d38mbxfu.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, linux-arm-kernel@lists.infradead.org, rnayak@ti.com, ido@wizery.com

Hi Kevin,

On Thu, 2012-03-08 at 13:21 -0800, Kevin Hilman wrote: 
> Luciano Coelho <coelho@ti.com> writes:
> 
> [...]
> 
> > Thanks, Paul! I was just chatting with Kevin about this on IRC.  With
> > your patch and no_console_suspend, it works. :)
> 
> Just FYI... I've queued this patch from Paul and it's now queued by Tony
> for v3.4 in his cleanup-pm branch.

Great, thanks for the info!

BTW, you and Paul said that it was not recommended to use
no_console_suspend, but Ido (on CC) said that it can be useful for us,
because we need to see if our own (wireless) stuff goes into suspend
correctly.

Are there any real problems with no_console_suspend besides power
consumption? Is it safe for us to simply apply Paul's patch when we need
it?

-- 
Cheers,
Luca.

