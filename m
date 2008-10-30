From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH 08/16] OMAP3: Populate scratchpad contents
Date: Wed, 29 Oct 2008 19:33:26 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE89671620369796F15@dlee02.ent.ti.com>
References: <01f901c91fd2$06570810$LocalHost@wipultra1382>
 <87skqf6r48.fsf@deeprootsystems.com>
 <13B9B4C6EF24D648824FF11BE89671620369796DED@dlee02.ent.ti.com>
 <4908F349.2050100@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51179 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751939AbYJ3Adg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Oct 2008 20:33:36 -0400
In-Reply-To: <4908F349.2050100@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> I assume memory is being corrupted, but it also given an address in the
> virtual memory map of the kernel.  How is the ROM code halding a virtual
> address?  Just ignoring the upper bits?
>
> >> I believe what is intented is for arm_context_addr to be a physical
> >> memory address, right?  I've converted this to virt_to_phys().

Humm, not sure.  I'm thinking ROM code isn't using it in this form.  The .S code is stacking context there prior to sleep.  On wake you un-stack from it.

> > Yes virt_to_phys() should be here.  Current 2.6.24 kernel's do it this way
> also.
>
> Which begs the question why the patch sent to the list is using io_p2v()
> introducing a bug which was only caught by accident because it also
> introduced a compiler warning.

IIRC, when OFF was first introduced the bug was in internal code also.  It was later fixed. The branch point for initial open source code probably was before the fix.

Also strangely, the previous code worked on SDP.  When it was ported to a different board it crashed.  That is when the fix came in.

Regards,
Richard W.

