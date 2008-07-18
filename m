From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: Re: [PATCH 5/9] TWL4030: read and write module ISRs to clear them
	at init
Date: Fri, 18 Jul 2008 12:12:34 +0300
Message-ID: <20080718091234.GA4602@codecarver.research.nokia.com>
References: <20080718013205.18943.34047.stgit@localhost.localdomain> <20080718013451.18943.18579.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:47023 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756814AbYGRJMr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Jul 2008 05:12:47 -0400
Content-Disposition: inline
In-Reply-To: <20080718013451.18943.18579.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

On Thu, Jul 17, 2008 at 07:34:52PM -0600, ext Paul Walmsley wrote:
> TWL4030 interrupt status register bits can be cleared in one of two ways:
> either by reading from the register, or by writing a 1 to the
> appropriate bit(s) in the register.  This behavior can be altered at any
> time by the <twlmodule>_SIH_CTRL.COR register bit ("clear-on-read").
> 
> twl4030-core.c does not touch these *_SIH_CTRL registers during boot,
> and the TWL4030 TRM is deeply confused as to whether COR=1 means that
> the registers are cleared on reads, or cleared on writes.
> 

That's true. But reality is fortunately not so confused :) COR=1 means
all IRQs are acknowledged when reading the corresponding ISR. COR=0
means you need to write 1 to the bits in the ISR for interrupts you want to
acknowledge.

Hope this helps,

Cheers,

Peter.

-- 
goa is a state of mind
