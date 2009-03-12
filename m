From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: RFD: OMAP PRCM register access holding up PM branch submissions
Date: Thu, 12 Mar 2009 09:54:41 -0700
Message-ID: <87bps67kby.fsf@deeprootsystems.com>
References: <87hc1y930c.fsf@deeprootsystems.com>
	<20090312162804.GA7179@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:28392 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756149AbZCLQyq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 12:54:46 -0400
Received: by wa-out-1112.google.com with SMTP id v33so576895wah.21
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 09:54:44 -0700 (PDT)
In-Reply-To: <20090312162804.GA7179@n2100.arm.linux.org.uk> (Russell King's message of "Thu\, 12 Mar 2009 16\:28\:04 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Thu, Mar 12, 2009 at 08:25:55AM -0700, Kevin Hilman wrote:
>> So, what is the path forward?  If you are not opposed to moving to the
>> 'MOD + offset' approach in principle, I propose we just make a new
>> attempt at converting to it.
>
> The path forward is that I'm not going to do anything further on this
> until after the next merge window[*].  I only officially spend one day
> a week on TI stuff, and I've spent rather more than that over the course
> of the last cycle at the expense of other work.
>

Russell,

Nobody expects you to be doing all the work yourself, I would just
like to hear your opinions on the direction.  Even working full-time,
there is way too much OMAP clock and PM code in progress for any one
person to work on alone.  Between Paul, myself and others in the
linux-omap community, we are happy to work on evolving this code in
the right direction.

If you can share your opinions on the two register access approaches I
described, I will work on coordinating development in that direction.

Until then, any efforts to get OMAP PM code into shape for upstream
submission are completely stalled since it is still unclear what your
opinions are on the PRCM access methods going forward.

Kevin
