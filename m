From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/4] initialize omap SRAM later on with
 __arm_ioremap_exec()
Date: Wed, 5 Oct 2011 18:42:19 -0700
Message-ID: <20111006014219.GH6324@atomide.com>
References: <20111005004339.26980.31149.stgit@kaulin.local>
 <4E8C0125.1060300@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:64098 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934406Ab1JFBmW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Oct 2011 21:42:22 -0400
Content-Disposition: inline
In-Reply-To: <4E8C0125.1060300@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [111004 23:29]:
> 
> Will look at this series in next couple of days and do some testing.

Thanks, turns out there were a few issues with early ioremap
that I fixed. Care to check the L4_IO_ADDRESS changes?

It's all pushed now into sram-map-io branch at:

https://github.com/tmlind/linux/tree/sram-map-io

It seems it's booting now on all omaps I've tried, so will merge
it into linux-omap master branch as well for testing.

> Looks like you wanted to inlcude below patch also part of this
> series though [PATCH 5/4] numbering is bit confusing.
> [PATCH 5/4] ARM: OMAP: Move set_globals initialization to happen in
> init_early

Yeah sorry the patches overflowed from the initial four..

Regards,

Tony
