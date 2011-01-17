From: Jamie Iles <jamie@jamieiles.com>
Subject: Re: [RFC+CFT] Use word operations in bitops
Date: Mon, 17 Jan 2011 09:46:02 +0000
Message-ID: <20110117094602.GA2622@pulham.picochip.com>
References: <20110116121911.GB27542@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:63942 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753030Ab1AQJqG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jan 2011 04:46:06 -0500
Received: by wyb28 with SMTP id 28so4909009wyb.19
        for <linux-omap@vger.kernel.org>; Mon, 17 Jan 2011 01:46:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110116121911.GB27542@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Sun, Jan 16, 2011 at 12:19:11PM +0000, Russell King - ARM Linux wrote:
> XXX WARNING: bitops are used heavily by filesystem code: there be dragons XXX
> I strongly suggest you ensure you have a copy of your filesystems before
> trying this patch.
> 
> The patch below switches the bitops to use word loads/stores rather than
> byte operations - so that we can avoid using the ldrexb/strexb instructions
> which are only supported from ARMv6k and up.
[...]
> This does need a fair amount of testing before it can be merged, so I'd
> like to see a number of Tested-by's against this patch.  Please also
> indicate whether you tested on LE or BE or both, which filesystems, and
> whether they were read-only mounted or read-write mounted.

Hi Russell,

I've tested these on my picoxcell board (ARMv6K UP LE) with UBIFS, JFFS2 
and NFS all mounted rw and haven't seen any problems.  Our platforms 
aren't particulary FS intensive so I'll keep these patches applied to 
give them a bit more time.

Tested-by: Jamie Iles <jamie@jamieiles.com>

Jamie
