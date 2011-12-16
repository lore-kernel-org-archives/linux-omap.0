From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv12 0/9] OMAP3+: PRCM chain handler
Date: Thu, 15 Dec 2011 22:10:05 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1112152207440.12660@utopia.booyaka.com>
References: <20111215213358.26632.44165.stgit@dusk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:34961 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749Ab1LPFKG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Dec 2011 00:10:06 -0500
In-Reply-To: <20111215213358.26632.44165.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: t-kristo@ti.com


Hi

This series was boot-tested on a 4430 ES2 Panda also.  It generates the 
following message on boot:

PRCM: failed to allocate irq descs: -12

which is an -ENOMEM coming from irq_alloc_descs().  This is probably 
because OMAP hasn't been converted to use sparse IRQs yet.

Until that happens, this message should be harmless.


- Paul
