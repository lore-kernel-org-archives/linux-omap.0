From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP3: DVFS: No sdrc AC timing changes during core
 dvfs
Date: Tue, 20 Oct 2009 19:21:28 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0910201918230.22645@utopia.booyaka.com>
References: <1254835224-19500-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58462 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751781AbZJUBVX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Oct 2009 21:21:23 -0400
In-Reply-To: <1254835224-19500-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

Hi,

On Tue, 6 Oct 2009, Rajendra Nayak wrote:

> This patch removes the SDRC AC timings changes done during core dvfs.
> Updating AC timing CTRL values for SDRC during DVFS is seen to be a risk,
> while the RFR CTRL value is safe to be updated.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

just wanted to let you know, I haven't forgotten about this one. Am trying 
to get an answer from others as to whether AC timing register changes are 
completely unsafe, in which case your patch is probably the best way to 
move forward; or whether we can make the changes when no initiators are 
touching SDRAM.


- Paul
