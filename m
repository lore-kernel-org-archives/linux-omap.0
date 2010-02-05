From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/3] OMAP2/3 PM: Adding powerdomain APIs for reading the
 next logic and mem state
Date: Fri, 5 Feb 2010 01:21:58 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1002050121300.26033@utopia.booyaka.com>
References: <1265302071-7624-1-git-send-email-thara@ti.com> <1265302071-7624-2-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60682 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754177Ab0BEIV7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Feb 2010 03:21:59 -0500
In-Reply-To: <1265302071-7624-2-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org

On Thu, 4 Feb 2010, Thara Gopinath wrote:

> This patch adds APIs pwrdm_read_logic_retst and
> pwrdm_read_mem_retst for reading the next programmed
> logic and memory state a powerdomain is to hit in event
> of the next power domain state being retention.
> 
> Signed-off-by: Thara Gopinath <thara@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>

Thanks, looks good Thara.  Queued for 2.6.34.


- Paul
