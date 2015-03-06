From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 11/24] ARM: OMAP2+: clock: remove support for legacy
 mpurate command line param
Date: Fri, 6 Mar 2015 07:32:55 -0800
Message-ID: <20150306153254.GK13520@atomide.com>
References: <1425644939-3232-1-git-send-email-t-kristo@ti.com>
 <1425644939-3232-12-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from pmta1.delivery1.ore.mailhop.org ([54.191.214.3]:41587 "EHLO
	pmta1.delivery1.ore.mailhop.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754387AbbCFPiT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Mar 2015 10:38:19 -0500
Received: from smtp4.ore.mailhop.org (172.31.18.134) by pmta1.delivery1.ore.mailhop.org id hv74te20r84b for <linux-omap@vger.kernel.org>; Fri, 6 Mar 2015 15:37:58 +0000 (envelope-from <tony@atomide.com>)
Content-Disposition: inline
In-Reply-To: <1425644939-3232-12-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [150306 04:29]:
> The legacy support is wrong and dangerous, as it doesn't take any
> OPPs into account and does not scale voltages. Switching mpurate should
> be handled through cpufreq.

Hmm I wonder if some systems actually rely on the mpurate cmdline
parameter. If this cannot be fixed properly, you should at least
print an error here.

Regards,

Tony
