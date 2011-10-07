From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/4] ARM: OMAP: Map SRAM later on with ioremap_exec()
Date: Fri, 7 Oct 2011 07:55:58 -0700
Message-ID: <20111007145558.GH6324@atomide.com>
References: <20111005004339.26980.31149.stgit@kaulin.local>
 <20111005004546.26980.31836.stgit@kaulin.local>
 <alpine.LFD.2.02.1110042107230.9106@xanadu.home>
 <20111005221320.GE6324@atomide.com>
 <4E8EA1A1.5070508@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:44959 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752774Ab1JGO4D (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Oct 2011 10:56:03 -0400
Content-Disposition: inline
In-Reply-To: <4E8EA1A1.5070508@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Nicolas Pitre <nico@fluxnic.net>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [111006 23:18]:
> 
> Are you considering this change for 3.2?

I think we should as this is blocking development for
generic map_io and genalloc changes for SRAM code.

> OMAP4 errata WA would have a conflict with the
> change is sram code and hence the question ?

Right, let's see if we can fix that with a static mapping.

Regards,

Tony
