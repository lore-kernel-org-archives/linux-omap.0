From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 02/10] OMAP: iommu: add initial debugfs support
Date: Thu, 13 Aug 2009 10:23:59 +0100
Message-ID: <20090813092359.GS6132@n2100.arm.linux.org.uk>
References: <20090812120926.17601.85860.stgit@localhost> <20090812121324.17601.39083.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:36089 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753875AbZHMJYF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Aug 2009 05:24:05 -0400
Content-Disposition: inline
In-Reply-To: <20090812121324.17601.39083.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

On Wed, Aug 12, 2009 at 03:13:24PM +0300, Tony Lindgren wrote:
> +static DEFINE_MUTEX(iommu_debug_lock);
> +static char local_buffer[SZ_4K];

I don't like this - what if the data you're sprintf'ing into this
buffer overflows it?
