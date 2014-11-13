From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/5] ARM: OMAP3+: DPLL: fix set_rate logic
Date: Thu, 13 Nov 2014 16:59:34 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1411131629220.31460@utopia.booyaka.com>
References: <1412344634-2798-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:59264 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933378AbaKMQ7f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Nov 2014 11:59:35 -0500
In-Reply-To: <1412344634-2798-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org

On Fri, 3 Oct 2014, Tero Kristo wrote:

> OMAP3+ DPLL code is currently using set_rate op to change DPLL rates.
> This is kind of wrong, as it also involves changing DPLL parent in certain
> cases (switch between locked mode <-> bypass mode.) This set fixes these
> issues by introducing the support of determine_rate and set_rate_and_parent
> ops for the DPLL clocks. Also introduces support for set_parent, which
> just switches a DPLL between locked <-> bypass modes.

Thanks, queued for v3.19.


- Paul
