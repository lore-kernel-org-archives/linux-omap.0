From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v3 09/13] OMAP4: hwmod data: Align interconnect format
 with regular modules
Date: Wed, 6 Jul 2011 16:42:08 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107061640100.31498@utopia.booyaka.com>
References: <1309554558-19819-1-git-send-email-b-cousson@ti.com> <1309554558-19819-10-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:34628 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752959Ab1GFWmJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jul 2011 18:42:09 -0400
In-Reply-To: <1309554558-19819-10-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, 1 Jul 2011, Benoit Cousson wrote:

> The interconnect modules were using a slightly different layout than
> the regular modules.
> Align the layout for better consitency.

Thanks, this patch has been queued for 3.1 at 
git://git.pwsan.com/linux-2.6 in the 'omap4_hwmod_data_cleanup_a_3.1' 
branch.


- Paul
