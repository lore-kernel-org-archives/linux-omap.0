From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: remove unused parameter arch_id from uncompress.h
Date: Tue, 7 Aug 2012 00:38:03 -0700
Message-ID: <20120807073803.GP11011@atomide.com>
References: <20120714204952.GA4798@raptus.dandreoli.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:18041 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750727Ab2HGHiF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Aug 2012 03:38:05 -0400
Content-Disposition: inline
In-Reply-To: <20120714204952.GA4798@raptus.dandreoli.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Domenico Andreoli <cavokz@gmail.com> [120714 13:54]:
> From: Domenico Andreoli <domenico.andreoli@linux.com>
> 
> There is not point in having arch_id as parameter of __arch_decomp_setup(),
> nothing in it uses arch_id. The machine id is already exported (and used)
> with symbol __machine_arch_type as per mach-types.h.
> 
> Removing the pointless macro as well.

Thanks applying into fixes.

Tony
