From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [RFC/PATCH 6/8] omap: mailbox: more more stuff to
 omap2_mbox_init
Date: Tue, 04 May 2010 09:04:17 +0300 (EEST)
Message-ID: <20100504.090417.242149613.Hiroshi.DOYU@nokia.com>
References: <8F7AF80515AF0D4D93307E594F3CB40E4B79179A@dlee03.ent.ti.com>
	<r2n94a0d4531005030808sc1f2a0a0q6a97f8a7ed2b8e7f@mail.gmail.com>
	<8F7AF80515AF0D4D93307E594F3CB40E4B791DED@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:22994 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754348Ab0EDGEj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 May 2010 02:04:39 -0400
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E4B791DED@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: h-kanigeri2@ti.com
Cc: felipe.contreras@gmail.com, linux-omap@vger.kernel.org, tony@atomide.com, ohad@wizery.com

From: "ext Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [RFC/PATCH 6/8] omap: mailbox: more more stuff to omap2_mbox_init
Date: Mon, 3 May 2010 20:50:39 +0200

> Felipe,
> 
>> > Small suggestion...if we are re-organizing can we make it look similar
>> to how iommu is structured? This way we can maintain consistency.
>> 
>> I thought I did. What exactly do you have in mind?
> 
> 	1. What Tony mentioned in another email about using #ifdefs for the platforms. That will be bring close to what is in omap-iommu.c
> 
> 	2. Compare iommu_get with mailbox_get. iommu_get uses
> driver_find_device to get the iommu structure. I guess we can apply
> the same logic to get mailbox structure. This way we can get rid of
> omap_mbox_register, omap_mbox_unregister, and find_mboxes functions.

Right. The same logic could be applied.

