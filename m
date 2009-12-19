From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 4/5] arm: Fix init_atags_procfs() to check tag->hdr.size
Date: Sat, 19 Dec 2009 09:03:32 +0000
Message-ID: <20091219090332.GA28047@n2100.arm.linux.org.uk>
References: <20091219034151.26198.26570.stgit@localhost> <20091219034630.26198.35713.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:49298 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959AbZLSJDo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 19 Dec 2009 04:03:44 -0500
Content-Disposition: inline
In-Reply-To: <20091219034630.26198.35713.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Fri, Dec 18, 2009 at 07:46:30PM -0800, Tony Lindgren wrote:
> The tag->hdr.size cannot be larger than XXX.
> Otherwise we can getsomething similar during boot:
> 
> Unable to handle kernel paging request at virtual address 61a05020
> ...

NAK.

Why can't people get the simple ATAG setup right?  Fix the boot loader.
