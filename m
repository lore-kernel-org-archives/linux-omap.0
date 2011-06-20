From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH v2 00/18] GPIO: OMAP: Driver Cleanup and Fixes
Date: Tue, 21 Jun 2011 01:30:25 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037B9ACD84@dbde02.ent.ti.com>
References: <1308058321-12875-1-git-send-email-tarun.kanti@ti.com>
 <87ei2trbuq.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42570 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751942Ab1FTUAq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Jun 2011 16:00:46 -0400
In-Reply-To: <87ei2trbuq.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

[...]
> 
> A quick test of this series on 3430/n900 shows that it prevents PER
> retention.  I see CM_FCLKEN_PER=0000c000 (debounce clock for GPIO banks
> 3 & 4 are still enabled.)
> 
> Can you retest with debounce enabled on one of the GPIOs for one of your
> platforms?
With one of the module debounce clock enabled it doesn't go to retention.
Later I disabled all modules debounce clock. It doesn't to retention either.
So this is same as your observation. I am surprised what has happened now.
The only thing I could recollect is few patches to solve LDO and
OMAP1 issues while testing before posting. I will investigate further.
--
Tarun
> 
> Kevin
> 
> 

