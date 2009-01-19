From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: ioremap()/iounmap() problem
Date: Mon, 19 Jan 2009 11:01:16 +0000
Message-ID: <20090119110116.GA15007@n2100.arm.linux.org.uk>
References: <1232360583.6481.92.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:44377 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756871AbZASLBv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Jan 2009 06:01:51 -0500
Content-Disposition: inline
In-Reply-To: <1232360583.6481.92.camel@tubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Mon, Jan 19, 2009 at 12:23:03PM +0200, Tomi Valkeinen wrote:
> Hi,
> 
> Running with latest linux-omap kernel on OMAP3 SDP board, I have problem
> with iounmap(). It looks like iounmap() does not properly free large
> areas. Below is a test which fails for me in 6-7 loops.
> 
> OMAP spesific ioremap code doesn't do much, so I think it's somewhere in
> generic ARM code. I looked at the ioremap code and for larger areas the
> code uses area sections, and I believe the bug is somewhere there. 

In unmap_area_sections(), try changing:

        unsigned long addr = virt, end = virt + (size & ~SZ_1M);

to

        unsigned long addr = virt, end = virt + (size & ~(SZ_1M - 1));
