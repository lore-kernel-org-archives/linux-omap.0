From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 4/6] ARM: OMAP4: PMU: Add runtime PM support
Date: Thu, 31 May 2012 02:29:23 +0100
Message-ID: <20120531012923.GB8506@mudshark.cambridge.arm.com>
References: <1336599355-10983-1-git-send-email-jon-hunter@ti.com>
 <87wr3uelgp.fsf@ti.com>
 <4FC548A3.2040906@ti.com>
 <4FC54D3B.10301@ti.com>
 <87pq9l7306.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:48093 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757598Ab2EaB3l (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 May 2012 21:29:41 -0400
Content-Disposition: inline
In-Reply-To: <87pq9l7306.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Jon Hunter <jon-hunter@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Ming Lei <ming.lei@canonical.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

Hi Kevin,

On Wed, May 30, 2012 at 10:50:01PM +0100, Kevin Hilman wrote:
> Basically, I don't like the result when we have to hack around missing
> runtime PM support for a driver, so IMO, the driver should be updated.
> 
> IOW, it looks to me like the armpmu driver should grow runtime PM
> support.  The current armpmu_release|reserve should probably be replaced
> with runtime PM get/put, and the functionality in those functions would
> be the runtime PM callbacks instead.
> 
> Will, any objections to armpmu growing runtime PM support?

My plan for the armpmu reservation is to kill the global reservation scheme
that we currently have and push those function pointers into the arm_pmu,
so that fits with what you'd like.

The only concern I have is that we need the mutual exclusion even when we
don't have support for runtime PM. If we can solve that then I'm fine with
the approach.

Cheers,

Will
