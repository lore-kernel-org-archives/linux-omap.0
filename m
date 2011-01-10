From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v5 17/17] OMAP2,3: DSS2: Get DSS IRQ from platform
 device
Date: Mon, 10 Jan 2011 13:00:17 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1101101300050.5731@utopia.booyaka.com>
References: <1294399551-10457-1-git-send-email-sumit.semwal@ti.com> <1294399551-10457-18-git-send-email-sumit.semwal@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48683 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751565Ab1AJUAR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Jan 2011 15:00:17 -0500
In-Reply-To: <1294399551-10457-18-git-send-email-sumit.semwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sumit Semwal <sumit.semwal@ti.com>
Cc: tomi.valkeinen@nokia.com, khilman@deeprootsystems.com, hvaibhav@ti.com, linux-omap@vger.kernel.org, Senthilvadivu Guruswamy <svadivu@ti.com>

On Fri, 7 Jan 2011, Sumit Semwal wrote:

> From: Senthilvadivu Guruswamy <svadivu@ti.com>
> 
> DSS IRQ number can be obtained from platform_get_irq().  This API in turn
> picks the right IRQ number belonging to HW IP from the hwmod database.
> So hardcoding of IRQ number could be removed.
> 
> Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>

Reviewed-by: Paul Walmsley <paul@pwsan.com>


- Paul
