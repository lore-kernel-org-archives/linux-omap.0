From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v4] ARM: Fix sparse warnings due to variables conflicts.
Date: Sat, 9 Oct 2010 00:22:37 +0100
Message-ID: <20101008232237.GC10975@n2100.arm.linux.org.uk>
References: <1286517186-29934-1-git-send-email-sourav.poddar@ti.com> <4CAF014D.7000909@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54680 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752863Ab0JHXW4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Oct 2010 19:22:56 -0400
Content-Disposition: inline
In-Reply-To: <4CAF014D.7000909@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: "Poddar, Sourav" <sourav.poddar@ti.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Varadarajan, Charulatha" <charu@ti.com>

On Fri, Oct 08, 2010 at 06:32:29AM -0500, Nishanth Menon wrote:
> Poddar, Sourav had written, on 10/08/2010 12:53 AM, the following:
>> Fix the sparse warnings generated due to conflicts in variables used in readl/writel.
>>
>>
>> drivers/net/smc91x.c:312:8: warning: symbol '__v' shadows an earlier one
>> drivers/net/smc91x.c:312:8: originally declared here
>>
>> With this change, about 200 sparse warnings are fixed.
> The commit message could be a little more detailed.
> see http://marc.info/?l=linux-omap&m=128648102511076&w=2
>
> also should $subject say ARM: io: fix namespace conflict
> to better reflect the fix? sparse warnings are just an indication IMHO

afaics, this patch will cause checkpatch to issue warnings due to lines
over 80 characters.

I can't check that because I don't have the original patch via the
linux-arm-kernel mailing list.
