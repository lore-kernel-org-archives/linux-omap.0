From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP2+: hwmod: Add new sysc_type3 into omap_hwmod
 required for am33xx
Date: Fri, 27 Apr 2012 19:34:38 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204271934230.10308@utopia.booyaka.com>
References: <1329481488-27771-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35953 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757647Ab2D1Bej (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Apr 2012 21:34:39 -0400
In-Reply-To: <1329481488-27771-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, tony@atomide.com, b-cousson@ti.com, Vaibhav Bedia <vaibhav.bedia@ti.com>

On Fri, 17 Feb 2012, Vaibhav Hiremath wrote:

> In case of AM33xx family of devices (like cpsw) have different sysc
> bit field offsets defined,
> 
> sysc_type3:
> |  3     2  |  1    0  |
> | STDBYMODE | IDLEMODE |
> 
> So introduce new sysc_type3 in omap_hwmod common data.
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>

Thanks, queued for 3.5.


- Paul
