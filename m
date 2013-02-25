From: Paolo Pisati <p.pisati@gmail.com>
Subject: Re: omap4: 3.8: IPV6 + PREEMPT_VOLUNTARY + !DEBUG_[SPINLOCK|MUTEXES]
 = BUG()
Date: Mon, 25 Feb 2013 15:20:48 +0100
Message-ID: <20130225142048.GA6616@luxor.wired.org>
References: <20130221094819.GA4580@luxor.wired.org>
 <20130222123637.GA30923@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:33326 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758155Ab3BYOUx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Feb 2013 09:20:53 -0500
Received: by mail-wg0-f50.google.com with SMTP id es5so2494753wgb.29
        for <linux-omap@vger.kernel.org>; Mon, 25 Feb 2013 06:20:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130222123637.GA30923@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Paolo Pisati <p.pisati@gmail.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>

On Fri, Feb 22, 2013 at 12:36:37PM +0000, Russell King - ARM Linux wrote:
> On Thu, Feb 21, 2013 at 10:48:19AM +0100, Paolo Pisati wrote:
> > any idea how can i debug this?
> 
> Please try this patch, and report back whether it solves your problem.
> Thanks.

yes, it solves my problem: any chance we can see it in 3.9 or 3.8.x?

-- 
bye,
p.
