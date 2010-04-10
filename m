From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC] Initial attempt to make ARM use LMB
Date: Sat, 10 Apr 2010 08:03:05 +0100
Message-ID: <20100410070305.GA2445@n2100.arm.linux.org.uk>
References: <20100325233248.GM24984@n2100.arm.linux.org.uk> <20100408153111.GA2598@debian> <20100408182715.GF31407@n2100.arm.linux.org.uk> <20100409111105.GA2804@n2100.arm.linux.org.uk> <20100410034224.GA22637@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:50111 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751338Ab0DJHEU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 10 Apr 2010 03:04:20 -0400
Content-Disposition: inline
In-Reply-To: <20100410034224.GA22637@debian>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rabin Vincent <rabin@rab.in>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sat, Apr 10, 2010 at 09:12:24AM +0530, Rabin Vincent wrote:
> On Fri, Apr 09, 2010 at 12:11:05PM +0100, Russell King - ARM Linux wrote:
> > Here's a revised version which should resolve the initrd problem.
> 
> It does, after the missing call to lmb_init() is added.

Which missing call?
