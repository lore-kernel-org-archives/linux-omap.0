From: David Miller <davem@davemloft.net>
Subject: Re: HyperSPARC RT625 Cache Controler, Ross CY7C605 Cache
 Controler, Cache Aliases, and Linux MM Code
Date: Mon, 08 Sep 2008 22:12:03 -0700 (PDT)
Message-ID: <20080908.221203.158686193.davem@davemloft.net>
References: <48B67008.3010007@tensilica.com>
	<20080828.024118.166054084.davem@davemloft.net>
	<48C6048E.2080609@tensilica.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:41492
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751740AbYIIFMJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Sep 2008 01:12:09 -0400
In-Reply-To: <48C6048E.2080609@tensilica.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: piet.delaney@tensilica.com
Cc: sparclinux@vger.kernel.org, linux-omap@vger.kernel.org, piet.delaney@gmail.com

From: Piet Delaney <piet.delaney@tensilica.com>
Date: Mon, 08 Sep 2008 22:07:26 -0700

> Wonder why the update_mmu_cache() for sun4c has to do so much more
> work that sun4m.

Caches are virtually indexed and virtually tagged on sun4c, that's why.

Keep on wonderin'

> Wonder why SPARC has to do more work that ARM.

ARMs that have the cache issues aren't SMP, that's why.

Keep on wonderin'
