From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2] OMAP: hwmod: Do not expect an entry in clkdev for
 opt_clks
Date: Thu, 10 Feb 2011 13:40:52 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1102101329070.21991@utopia.booyaka.com>
References: <1296626117-31716-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:38576 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755081Ab1BJUkx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Feb 2011 15:40:53 -0500
In-Reply-To: <1296626117-31716-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sumit Semwal <sumit.semwal@ti.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>, Partha Basak <p-basak2@ti.com>

On Wed, 2 Feb 2011, Rajendra Nayak wrote:

> The _add_optional_clock_alias function expects an entry
> already existing in the clkdev table in the form of
> <dev-id=NULL, con-id=role> which might not be the case
> always.
> 
> Instead, just check if an entry already exists in clkdev
> in the <dev-id=dev_name, con-id=role> form, else go ahead
> and add one.
> 
> Remove any assumption of an entry already existing in clkdev
> table in any form.
> 
> Since this means, adding a new entry in clkdev if it does
> not already exist, and not really adding an 'alias',
> also rename the function name
> (s/_add_optional_clock_alias/_add_optional_clock_clkdev)
> to reflect this.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Reported-by: Sumit Semwal <sumit.semwal@ti.com>
> Cc: Sumit Semwal <sumit.semwal@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Partha Basak <p-basak2@ti.com>

Thanks.  I changed the subject line to read:

OMAP2+: omap_device/clock: Do not expect an entry in clkdev for opt_clks

before queuing for 2.6.39 in the branch 'omap_device_a_2.6.39' of 
git://git.pwsan.com/linux-2.6

Also added to the 'integration-2.6.39' branch of 
git://git.pwsan.com/linux-2.6 and is part of the stable tag 
'integration-2.6.39-20110210-002'


- Paul
