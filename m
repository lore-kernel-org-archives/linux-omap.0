From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 1/1] DSPBRIDGE: move platform_device_register under
 mach-omap2
Date: Wed, 25 Mar 2009 15:11:29 +0200 (EET)
Message-ID: <20090325.151129.02294438.Hiroshi.DOYU@nokia.com>
References: <1237981895-9269-1-git-send-email-Hiroshi.DOYU@nokia.com>
	<8F7AF80515AF0D4D93307E594F3CB40E2349AE08@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:63935 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754995AbZCYNLp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Mar 2009 09:11:45 -0400
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E2349AE08@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: h-kanigeri2@ti.com
Cc: linux-omap@vger.kernel.org, 2ameya@gmail.com

From: "ext Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH 1/1] DSPBRIDGE: move platform_device_register under mach-omap2
Date: Wed, 25 Mar 2009 13:53:51 +0100

[...]
> 
> I am still going through the patch, but one quick question regarding
> this. One of the requirements of DSP memory pool is that it should
> be physically contiguous and non-cacheable. I hope the below patch
> is taking care of this requirement.

This patch reserves a *contigious* physical memory area and passes
this physical address to the bridge driver through
ldm(platform_data). Then this area is ioremap()'ed in
"MEM_ExtPhysPoolInit()". So it should be non-cachable and contigious.
