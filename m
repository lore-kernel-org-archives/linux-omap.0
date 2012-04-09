From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP2+: PRM: fix compile for OMAP4-only build
Date: Mon, 9 Apr 2012 10:51:37 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204091046410.6640@utopia.booyaka.com>
References: <1333660837-23249-1-git-send-email-khilman@ti.com> <alpine.DEB.2.00.1204051533110.10302@utopia.booyaka.com> <87fwchhge4.fsf@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57952 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752333Ab2DIQvi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Apr 2012 12:51:38 -0400
In-Reply-To: <87fwchhge4.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, 5 Apr 2012, Kevin Hilman wrote:

> No objections.

Thanks, I took a closer look at this issue over the weekend, and realized 
that I had misunderstood it.  So, will take this patch as-is, as part of 
the io_chain_devel_3.5 series; thanks for the great changelog.

Looking forward to dropping these old OMAP2/3 PRM stubs for OMAP4 soon, 
they've been around for too long :-(

- Paul
