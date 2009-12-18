From: Tony Lindgren <tony@atomide.com>
Subject: "Flush the D-cache during copy_user_highpage" breaks compile for
 v7 on -rc1
Date: Thu, 17 Dec 2009 19:19:24 -0800
Message-ID: <20091218031923.GA4575@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:58710 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752565AbZLRDTe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Dec 2009 22:19:34 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Catalin,

You may have already run into this, but if not, looks like commit
115b22474eb1905da2f606a057da3455833333d3 breaks compile for v7:

arch/arm/mm/copypage-v6.c: In function 'v6_copy_user_highpage_nonaliasing':
arch/arm/mm/copypage-v6.c:51: error: implicit declaration of function '__cpuc_flush_dcache_page'

Undoing that makes it work again.

Regards,

Tony
