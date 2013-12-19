From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv11 07/49] clk: divider: add support for low level ops
Date: Thu, 19 Dec 2013 10:26:20 -0800
Message-ID: <20131219182620.GQ27438@atomide.com>
References: <1387452260-23276-1-git-send-email-t-kristo@ti.com>
 <1387452260-23276-8-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:63210 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753948Ab3LSS00 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Dec 2013 13:26:26 -0500
Content-Disposition: inline
In-Reply-To: <1387452260-23276-8-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [131219 03:26]:
> Divider clock can now be registered to use low level register access ops.
> Preferred initialization method is via clock description.

This seems to make omap2 not boot for me. No output whatsoever even with
DEBUG_LL and earlyprintk.

Regards,

Tony
