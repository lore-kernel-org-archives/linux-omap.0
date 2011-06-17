From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH v2 00/18] GPIO: OMAP: Driver Cleanup and Fixes
Date: Fri, 17 Jun 2011 11:12:32 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037B9AC5B7@dbde02.ent.ti.com>
References: <1308058321-12875-1-git-send-email-tarun.kanti@ti.com>
 <87ei2trbuq.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44793 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750808Ab1FQFmo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Jun 2011 01:42:44 -0400
In-Reply-To: <87ei2trbuq.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

> -----Original Message-----
> From: Hilman, Kevin
> Sent: Thursday, June 16, 2011 9:46 PM
> To: DebBarma, Tarun Kanti
> Cc: linux-omap@vger.kernel.org; Shilimkar, Santosh; tony@atomide.com;
> linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH v2 00/18] GPIO: OMAP: Driver Cleanup and Fixes
> 
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
> 
> > This series is continuation of cleanup of OMAP GPIO driver and fixes.
> > The cleanup include getting rid of cpu_is_* checks wherever possible,
> > use of gpio_bank list instead of static array, use of unique platform
> > specific value associated data member to OMAP platforms to avoid
> > cpu_is_* checks. The series also include PM runtime support.
> 
> A quick test of this series on 3430/n900 shows that it prevents PER
> retention.  I see CM_FCLKEN_PER=0000c000 (debounce clock for GPIO banks
> 3 & 4 are still enabled.)
> 
> Can you retest with debounce enabled on one of the GPIOs for one of your
> platforms?
Sure, I will.
--
Tarun
> 
> Kevin
> 
> 

