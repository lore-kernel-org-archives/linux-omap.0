From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv11 07/49] clk: divider: add support for low level ops
Date: Fri, 20 Dec 2013 08:16:22 -0800
Message-ID: <20131220161622.GC27438@atomide.com>
References: <1387452260-23276-1-git-send-email-t-kristo@ti.com>
 <1387452260-23276-8-git-send-email-t-kristo@ti.com>
 <20131219182620.GQ27438@atomide.com>
 <52B342D2.1010301@ti.com>
 <52B416E8.8070006@ti.com>
 <52B41C15.8040304@ti.com>
 <52B41E4B.8040808@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:41295 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752700Ab3LTQQ3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Dec 2013 11:16:29 -0500
Content-Disposition: inline
In-Reply-To: <52B41E4B.8040808@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, nm@ti.com, bcousson@baylibre.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

* Rajendra Nayak <rnayak@ti.com> [131220 02:40]:
> 
> yeah, the crash was indeed when ll_ops was dereferenced despite being NULL.

Might be also worth checking if the gate and mux patches have a similar issue.

Regards,

Tony
