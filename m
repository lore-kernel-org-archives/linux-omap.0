From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv10 41/41] ARM: OMAP3: use DT clock init if DT data is
 available
Date: Tue, 26 Nov 2013 09:44:55 -0800
Message-ID: <20131126174455.GF26766@atomide.com>
References: <1385453182-24421-1-git-send-email-t-kristo@ti.com>
 <1385453182-24421-42-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:10604 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755228Ab3KZRpB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Nov 2013 12:45:01 -0500
Content-Disposition: inline
In-Reply-To: <1385453182-24421-42-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [131126 00:10]:
> OMAP3 platforms support both DT and non-DT boot at the moment, make
> the clock init work according to the used setup.

We're making omap3 to be DT only as well, so it might make sense to
drop the omap3 clock data as well while at it. Or do it later to
avoid adding dependencies, up to you.

Regards,

Tony
