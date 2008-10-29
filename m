From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH 08/16] OMAP3: Populate scratchpad contents
Date: Wed, 29 Oct 2008 16:35:06 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE89671620369796DED@dlee02.ent.ti.com>
References: <01f901c91fd2$06570810$LocalHost@wipultra1382>
 <87skqf6r48.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41006 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753511AbYJ2VfR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Oct 2008 17:35:17 -0400
In-Reply-To: <87skqf6r48.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "Nayak, Rajendra" <rnayak@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> > +   arm_context_addr = io_v2p(omap3_arm_context);

> strange is how the code is still working.

Probably just corrupts some DDR a bit higher up.

> I believe what is intented is for arm_context_addr to be a physical
> memory address, right?  I've converted this to virt_to_phys().

Yes virt_to_phys() should be here.  Current 2.6.24 kernel's do it this way also.

On a related note, I recently added a path to save and restore coresight debug registers.  This is allowing pretty good JTAG debugging even with power on (including ETM!).  In looking at usage of omap3_arm_context[] I found it needed to be bumped up as it was using 240 elements (with new ETM regs).  I need to check with out patch to see if the 128 is enough.

Regards,
Richard W.


