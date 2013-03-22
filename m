From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] mach_omap2: use PTR_RET instead of IS_ERR + PTR_ERR
Date: Fri, 22 Mar 2013 16:36:50 +0000
Message-ID: <20130322163650.GN30923@n2100.arm.linux.org.uk>
References: <1363075109-27038-1-git-send-email-silviupopescu1990@gmail.com> <20130312110557.GF30923@n2100.arm.linux.org.uk> <5149FFDF.6050501@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42239 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1160998Ab3CVQg6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Mar 2013 12:36:58 -0400
Content-Disposition: inline
In-Reply-To: <5149FFDF.6050501@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Silviu-Mihai Popescu <silviupopescu1990@gmail.com>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@ti.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On Wed, Mar 20, 2013 at 01:28:47PM -0500, Jon Hunter wrote:
> Sorry I am now not sure I follow you here. Someone just pointed out to
> me that PTR_RET() is defined as ...
> 
> static inline int __must_check PTR_RET(const void *ptr)
> {
> 	if (IS_ERR(ptr))
> 		return PTR_ERR(ptr);
> 	else
> 		return 0;
> }
> 
> So the above change appears to be equivalent. Is there something that is
> wrong with the current implementation that needs to be fixed?

No - I misread it as PTR_ERR not PTR_RET.  Your patch is fine.
