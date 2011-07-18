From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 0/5] OMAP SMPS regulator driver
Date: Mon, 18 Jul 2011 01:19:37 -0700
Message-ID: <20110718081937.GX5783@atomide.com>
References: <1310565638-13140-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:51445 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753054Ab1GRITk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Jul 2011 04:19:40 -0400
Content-Disposition: inline
In-Reply-To: <1310565638-13140-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com, khilman@ti.com

* Tero Kristo <t-kristo@ti.com> [110713 06:56]:
> Hello,
> 
> Based on the comments for the previous version of this set, I implemented
> a regulator driver for the OMAP SMPS now. It could actually be moved under
> arch/arm/mach-omap2/ directory instead of drivers/regulator, I think it
> should work from there also. This would also require less hacking for the
> header files. Any thoughts on this?

If it's a driver it should be under drivers/ then.

Tony
