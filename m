From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: Re: [PATCH 1/1] per board prm timings
Date: Fri, 13 Feb 2009 12:24:30 +0200
Message-ID: <20090213102430.GA4582@codecarver.research.nokia.com>
References: <1234281875-19768-1-git-send-email-peter.de-schrijver@nokia.com> <1234281875-19768-2-git-send-email-peter.de-schrijver@nokia.com> <87d4dnpmxq.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:51349 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797AbZBMKYi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Feb 2009 05:24:38 -0500
Content-Disposition: inline
In-Reply-To: <87d4dnpmxq.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Kevin,

> Peter,
> 
> I like this approach much better than what we currently have.  Pushing
> to PM branch.
> 
> The next thing I would like to see is all the register value defines
> removed from prm-regbits-34xx.h.  That header is supposed to be for
> the bitfield definitions, not for values.
> 

True. If this patch goes in, there is no need for the register value
defines in prm-regbits-34xx.h any more.

Cheers,

Peter.

-- 
goa is a state of mind
