From: Rabin Vincent <rabin@rab.in>
Subject: Re: [RFC] Initial attempt to make ARM use LMB
Date: Sat, 10 Apr 2010 09:12:24 +0530
Message-ID: <20100410034224.GA22637@debian>
References: <20100325233248.GM24984@n2100.arm.linux.org.uk>
 <20100408153111.GA2598@debian>
 <20100408182715.GF31407@n2100.arm.linux.org.uk>
 <20100409111105.GA2804@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from kelvin.asmallorange.com ([207.210.111.10]:45754 "EHLO
	kelvin.asmallorange.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753355Ab0DJDmK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Apr 2010 23:42:10 -0400
Content-Disposition: inline
In-Reply-To: <20100409111105.GA2804@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Apr 09, 2010 at 12:11:05PM +0100, Russell King - ARM Linux wrote:
> Here's a revised version which should resolve the initrd problem.

It does, after the missing call to lmb_init() is added.

Rabin
