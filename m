From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2] OMAP: ctrl: Fix CONTROL_DSIPHY register fields
Date: Mon, 1 Aug 2011 16:21:34 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1108011619520.28427@utopia.booyaka.com>
References: <1311762839-31663-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:34500 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753696Ab1HAWVf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Aug 2011 18:21:35 -0400
In-Reply-To: <1311762839-31663-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: tony@atomide.com, b-cousson@ti.com, santosh.shilimkar@ti.com, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, 27 Jul 2011, Archit Taneja wrote:

> Fix the shift and mask macros for DSIx_PPID fields in CONTROL_DSIPHY. The
> OMAP4430 Public TRM vV has these fields mentioned correctly.

Thanks, queued for 3.2 in the scm_fixes_3.2 branch of 
git://git.pwsan.com/linux-2.6

Also added Santosh's ack.


- Paul
