From: Paul Walmsley <paul@pwsan.com>
Subject: Re: Regressions for older OMAP3503 silicon
Date: Wed, 5 Oct 2011 12:35:59 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1110051234340.4611@utopia.booyaka.com>
References: <CABi1daE-7OdgL5BqaLrB+X64-cf+kQMyXv9eSZOE79bRt+fMPw@mail.gmail.com> <877h4j5my0.fsf@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47921 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933573Ab1JESf7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Oct 2011 14:35:59 -0400
In-Reply-To: <877h4j5my0.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Dave Hylands <dhylands@gmail.com>, linux-omap@vger.kernel.org, sakoman@gmail.com

On Wed, 5 Oct 2011, Kevin Hilman wrote:

> The need to comment this out suggests that omap3_has_io_wakeup() is
> returning true for this SoC but should not.
> 
> Looking at mach-omap2/io.c, that feature flag is not set on the 3505 and
> 3517, but is set on the 3503:
> 
> 	if (!cpu_is_omap3505() && !cpu_is_omap3517())
> 		omap_features |= OMAP3_HAS_IO_WAKEUP;
> 
> Adding a case for the 3503 here should fix this problem.
> 
> Maybe check other checks for cpu_is_omap3505() and see if those should
> also be checking for the 3503.

I think 3503 supports I/O wakeup, but just doesn't support the I/O chain 
enable sequence.  So as I understand it, there's a window where wakeup 
events could be lost.

- Paul
