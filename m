From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP2+: PM/serial: hold console semaphore while OMAP UARTs are
 disabled
Date: Wed, 24 Nov 2010 16:59:23 -0800
Message-ID: <20101125005923.GE31536@atomide.com>
References: <alpine.DEB.2.00.1011241646310.20215@utopia.booyaka.com>
 <87oc9e5j4c.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:24212 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753884Ab0KYA7b (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Nov 2010 19:59:31 -0500
Content-Disposition: inline
In-Reply-To: <87oc9e5j4c.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tom.leiming@gmail.com, pramod.gurav@ti.com, thomas.petazzoni@free-electrons.com, jean.pihet@newoldbits.com, govindraj.raja@ti.com

* Kevin Hilman <khilman@deeprootsystems.com> [101124 16:32]:
> Paul Walmsley <paul@pwsan.com> writes:

<snip>

> Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
> 
> Very nice.  I've been exploring various solutions to this problem as
> well, but this one is much cleaner.  Also, I hadn't discovered the 'try'
> version of the console semaphore, so was running into recursive locking.
> 
> Anyways, tested on omap35xx: omap3evm (uart1/core console) and beagle
> (uart3/per console) and omap34xx/n900 (uart3/per console) using both
> retention-idle and off-idle.

Thanks, queuing this as fix for the -rc cycle.

Tony
