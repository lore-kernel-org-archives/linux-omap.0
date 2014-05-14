From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 3/5] arm: omap2: skip device build from platform code
 for dt.
Date: Wed, 14 May 2014 14:43:08 -0700
Message-ID: <20140514214308.GI27426@atomide.com>
References: <1399528808-6920-1-git-send-email-sourav.poddar@ti.com>
 <1399528808-6920-4-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:40235 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752095AbaENVnW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 May 2014 17:43:22 -0400
Content-Disposition: inline
In-Reply-To: <1399528808-6920-4-git-send-email-sourav.poddar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sourav Poddar <sourav.poddar@ti.com>
Cc: zbr@ioremap.net, michael.opdenacker@free-electrons.com, wsa@the-dreams.de, paul@pwsan.com, bcousson@baylibre.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, balbi@ti.com

* Sourav Poddar <sourav.poddar@ti.com> [140507 23:01]:
> For SOCs with dt enabled, device should be build through device tree.
> Prevent device build call from platform code, if device tree is
> enabled.

Picking this patch into omap-for-v3.16/dt thanks.

Tony
