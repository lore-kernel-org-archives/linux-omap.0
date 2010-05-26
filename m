From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM:VFPv3:enable {d16-d31} access
Date: Wed, 26 May 2010 21:10:17 +0100
Message-ID: <20100526201017.GE6232@n2100.arm.linux.org.uk>
References: <tarun.kanti@ti.com> <1274818736-26597-1-git-send-email-tarun.kanti@ti.com> <5A47E75E594F054BAF48C5E4FC4B92AB0322FA884E@dbde02.ent.ti.com> <20100525185741.GB16204@n2100.arm.linux.org.uk> <5A47E75E594F054BAF48C5E4FC4B92AB0322FA8E37@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:36099 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751547Ab0EZUK1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 May 2010 16:10:27 -0400
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0322FA8E37@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, May 26, 2010 at 05:13:24PM +0530, DebBarma, Tarun Kanti wrote:
> 1) With the existing implementation I am not able to correctly
> write/read {d0-d15} but not the {d16-d31} set
> 
> 2) With my changes I am able to write/read correctly.

The reason this happens is simple.  In vfp_get_double(), we have:

1:      fmrrd   r0, r1, d\dr
1:      mrrc    p11, 3, r0, r1, c\dr    @ fmrrd r0, r1, d\dr

but in vfp_put_double(), we have:

1:      fmdrr   d\dr, r0, r1
1:      mcrr    p11, 3, r1, r2, c\dr    @ fmdrr r1, r2, d\dr

Note the different registers.  Change "r1, r2" to "r0, r1" and it
should work.
