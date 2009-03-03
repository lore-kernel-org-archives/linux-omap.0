From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH A 09/10] OMAP2/3: Remove OMAP_PRM_REGADDR,
 OMAP_CM_REGADDR
Date: Mon, 2 Mar 2009 19:48:07 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0903021945060.30037@utopia.booyaka.com>
References: <20090128020447.7244.80496.stgit@localhost.localdomain> <20090128021312.7244.2415.stgit@localhost.localdomain> <20090128232831.GL23301@n2100.arm.linux.org.uk> <alpine.DEB.2.00.0901290021360.32081@utopia.booyaka.com>
 <87zlg372rm.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:56007 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752967AbZCCCsJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Mar 2009 21:48:09 -0500
In-Reply-To: <87zlg372rm.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

Hi Kevin,

On Mon, 2 Mar 2009, Kevin Hilman wrote:

> What about the rest of the *_PRM_REGADDR() accessor macro changes in
> this patch?
> 
> The rest of the PM core code uses these and so does not build on top
> of the Russell's omap-clks3 branch.

yes, all of the *_{PRM,CM}_REGADDR() work should be kept.


- Paul
