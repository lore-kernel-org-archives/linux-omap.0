From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 01/10] OMAP: iommu: fix wrong argument in
	flush_cache_vmap()
Date: Thu, 13 Aug 2009 10:21:10 +0100
Message-ID: <20090813092110.GR6132@n2100.arm.linux.org.uk>
References: <20090812120926.17601.85860.stgit@localhost> <20090812121200.17601.61014.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:52967 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753868AbZHMJVU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Aug 2009 05:21:20 -0400
Content-Disposition: inline
In-Reply-To: <20090812121200.17601.61014.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

On Wed, Aug 12, 2009 at 03:12:00PM +0300, Tony Lindgren wrote:
> From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> 
> The second argument should be the end address, not the
> length. Actually there will not be any effect on the behavior of this
> driver since flush_cache_vmap() calls flush_cache_all() in the end.

Ok.
