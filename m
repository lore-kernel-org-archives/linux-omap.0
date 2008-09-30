From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: Re: does twl3040-pwrirq.c "need" to be a separate file?
Date: Tue, 30 Sep 2008 12:22:25 +0300
Message-ID: <20080930092225.GD4552@codecarver.research.nokia.com>
References: <200809291417.12437.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:29962 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521AbYI3JXD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Sep 2008 05:23:03 -0400
Content-Disposition: inline
In-Reply-To: <200809291417.12437.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

Hi David,

On Mon, Sep 29, 2008 at 02:17:12PM -0700, ext David Brownell wrote:
> Hi Peter,
> 
> I see your patch 68d7477caca19c0b52b5d4e85700cd3e6115577f created
> pwrirq.c as a separate file and thread.
> 

I guess choose this solution because it was similar to the GPIO IRQs.
Originally, this was 1 shared IRQ. But I wanted to change this to avoid
every driver having to read PWR_ISR1 and clear his interrupt. This saves
some i2c transactions.

> I'm wondering if there's any particular reason that "bank" of
> interrupts shouldn't be handled directly by twl4030-core, and
> even by the same IRQ handling thread.
> 

I don't think so.

> As it stands now the TWL "core" is not especially core-ish in
> this respect, and I'd like to see that be resolved (e.g. by a
> patch I'll probably write this afternoon) before this code
> goes to mainline ...

Ok. Good.

Cheers,

Peter.

-- 
goa is a state of mind
