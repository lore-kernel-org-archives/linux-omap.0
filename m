From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH V2 01/10] ARM: PMU: Add runtime PM Support
Date: Mon, 2 Jul 2012 23:01:17 +0100
Message-ID: <20120702220117.GD25234@mudshark.cambridge.arm.com>
References: <20120608094708.GC19062@mudshark.cambridge.arm.com>
 <4FD21930.4000800@ti.com>
 <20120611173930.GD28235@mudshark.cambridge.arm.com>
 <4FD64083.3020800@ti.com>
 <20120612092842.GA2991@mudshark.cambridge.arm.com>
 <4FD7B1DC.30108@ti.com>
 <20120612213150.GC24380@mudshark.cambridge.arm.com>
 <4FD7C597.7060501@ti.com>
 <20120702095539.GD22239@mudshark.cambridge.arm.com>
 <4FF1D15E.7040301@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:62683 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932997Ab2GBWBd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Jul 2012 18:01:33 -0400
Content-Disposition: inline
In-Reply-To: <4FF1D15E.7040301@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, Ming Lei <ming.lei@canonical.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Mon, Jul 02, 2012 at 05:50:38PM +0100, Jon Hunter wrote:
> On 07/02/2012 04:55 AM, Will Deacon wrote:
> > 
> > Did you have any luck getting to the bottom of this?
> 
> I am still waiting for feedback from design. They were trying to confirm
> my observations. Unfortunately, it is taking some time. I will ping them
> again.

Ok, thanks. If pinging doesn't work, bribery can be quite effective with
hardware guys :)

> > It would be good to take your PMU suspend/resume patches once we know that
> > they will get used.
> 
> Yes that would be good. I could drop the 4460 specific changes for now
> and make 4460 work in the same way as 4430 (using CTI) for the time
> being and see if we can get these in. However, I recall that was not
> working for you, but it was working fine for me.

Indeed, that hack didn't help me and I'd rather not commit it if it only
partially fixes the problem. A better bet might just be to go with your
original approach and see how many bug reports we receive. That might also
help us narrow down the problem, but it's your call.

In the meantime, I pushed what I think is the latest drop of your series to
a new branch on kernel.org:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git perf/omap4-dev

Will
