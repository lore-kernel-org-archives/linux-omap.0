From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/2] ARM: AM33xx+: hwmod: re-use omap4 implementations
 for reset functionality
Date: Fri, 8 May 2015 17:49:10 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1505081748510.19833@utopia.booyaka.com>
References: <1430832785-1976-1-git-send-email-t-kristo@ti.com> <1430832785-1976-3-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:45105 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932473AbbEHRtL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 May 2015 13:49:11 -0400
In-Reply-To: <1430832785-1976-3-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, d-gerlach@ti.com, s-anna@ti.com, linux-arm-kernel@lists.infradead.org

On Tue, 5 May 2015, Tero Kristo wrote:

> The reset code functionality is mostly a copy paste between OMAP4+ and
> AM33xx+. Re-use the omap4 code where possible, and just keep the special
> implementation for de-asserting the hardreset lines for AM33xx, as
> AM33xx+ devices have slightly different register layouts compared to
> OMAP4+. This patch also fixes the hardreset issues faced on AM43xx.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Reported-by: Dave Gerlach <d-gerlach@ti.com>
> Reported-by: Anna Suman <s-anna@ti.com>

Thanks, queued for v4.1-rc fixes.


- Paul
