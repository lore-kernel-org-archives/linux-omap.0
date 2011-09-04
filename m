From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 00/11] Add L2 cache cleaning to generic CPU suspend
Date: Sun, 4 Sep 2011 11:12:50 +0100
Message-ID: <20110904101250.GB6918@n2100.arm.linux.org.uk>
References: <20110901124752.GE29729@n2100.arm.linux.org.uk> <4E625796.1020109@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:60330 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753690Ab1IDKND (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 4 Sep 2011 06:13:03 -0400
Content-Disposition: inline
In-Reply-To: <4E625796.1020109@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Sat, Sep 03, 2011 at 10:06:38PM +0530, Santosh wrote:
> Thanks a lot Russell for this series. I have tested the entire series
> with OMAP4 S2R and CPUIDLE and it works great.
>
> Tested-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Thanks.  I've merged added that to the non-fixes stuff (which Linus
hasn't pulled) and the series into the for-next branch.
