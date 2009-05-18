From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH 01/11] OMAP2/3: PM: push core PM code from linux-omap
Date: Mon, 18 May 2009 14:04:19 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162038BED5CA9@dlee02.ent.ti.com>
References: <1242412851-16606-1-git-send-email-khilman@deeprootsystems.com>
	<1242412851-16606-2-git-send-email-khilman@deeprootsystems.com>
	<20090518133241.GH3067@n2100.arm.linux.org.uk>
 <878wku8hkb.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38297 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751234AbZERTFB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 May 2009 15:05:01 -0400
In-Reply-To: <878wku8hkb.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jouni Hogander <jouni.hogander@nokia.com>, Paul Walmsley <paul@pwsan.com>


> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Monday, May 18, 2009 12:09 PM
> To: Russell King - ARM Linux; Woodruff, Richard


> > There is a function which re-initializes the abort mode registers already -
> > cpu_init().  Please use that if possible instead.
>
> Upon a quick glance, using cpu_init() would not cover all the things
> that this code does.  cpu_init() only handles the init of sp for the
> various modes, where this code saves/resores all the banked registers:
> sp, lr and spsr as well as r8-r12 of FIQ mode.

cpu_init() is not yet accessible at the point this code is running.  You could reduce the context perhaps trying to optimize to what the Linux-ARM implementation is today or do a more generic save like is there now.

This code is copied into place from the .S code into SRAM.  Its position independent and is not linked for this address.  If you want to call functions outside of it you need to manually setup linkage.

Calling outside functions on the way _DOWN_ is ok.  For instance in current TI reference code all cache flush is calling to kernel functions.  This saves in space, duplication maintenance and is actually _much_ quicker as it executes from a cached address range.  The cache flush code takes 770uS from kernel area and takes 2.2mS from sram (non-cached map).

Calling functions on the way _UP_ from wake is NOT easy (like the one you propose) as the MMU is not yet enabled.  The MMU is enabled only below this.  Calling cpu_init() is not do able here.  Even if you dress up the calling pointer to the physical address, it won't work as cpu_init() makes a global variable dereferences (smp_processor_id & stacks[]).

Regards,
Richard W.
