From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH V2 01/10] ARM: PMU: Add runtime PM Support
Date: Tue, 31 Jul 2012 16:14:47 +0100
Message-ID: <20120731151446.GK3903@mudshark.cambridge.arm.com>
References: <4FD7B1DC.30108@ti.com>
 <20120612213150.GC24380@mudshark.cambridge.arm.com>
 <4FD7C597.7060501@ti.com>
 <20120702095539.GD22239@mudshark.cambridge.arm.com>
 <4FF1D15E.7040301@ti.com>
 <20120702220117.GD25234@mudshark.cambridge.arm.com>
 <4FF6340A.6020409@ti.com>
 <50109233.3090302@ti.com>
 <20120726150534.GD6382@mudshark.cambridge.arm.com>
 <50115F3F.7050705@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:59326 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754837Ab2GaPPG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 31 Jul 2012 11:15:06 -0400
Content-Disposition: inline
In-Reply-To: <50115F3F.7050705@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, Ming Lei <ming.lei@canonical.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Thu, Jul 26, 2012 at 04:16:15PM +0100, Jon Hunter wrote:
> On 07/26/2012 10:05 AM, Will Deacon wrote:
> > Ok, thanks for updating me. I've pushed the patches out onto my
> > perf/omap4-dev branch as that seems to be a good place to collate the
> > current state of things. I've not tried doing anything with it yet though.
> 
> Ok, great. Let me know if you have any problems. I have ran some initial
> testing on omap3430, omap4430 and omap4460 and it seems ok (AFAICT).

Just an FYI that I gave up maintaining the old perf/omap4 branch and instead
moved everything from perf/omap4-dev onto that as the rebase was getting
painful.

Will
