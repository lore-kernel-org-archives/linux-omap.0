From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RFC PATCH 1/3] ARM: AM33XX: clock: Add debugSS clock nodes to
 clock tree
Date: Wed, 29 May 2013 19:07:12 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1305291906160.9052@utopia.booyaka.com>
References: <hvaibhav@ti.com> <1362396957-30113-2-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:33783 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759608Ab3E2THN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 May 2013 15:07:13 -0400
In-Reply-To: <1362396957-30113-2-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, khilman@linaro.org, b-cousson@ti.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org

On Mon, 4 Mar 2013, hvaibhav@ti.com wrote:

> From: Vaibhav Hiremath <hvaibhav@ti.com>
> 
> Represent debugSS clock interface as provided in
> CM_WKUP_DEBUGSS_CLKCTRL register, which includes,
> 	- Clock gate for optional DEBUG_CLKA and DBGSYSCLK
> 	- Clock Mux for TRC_PMD and STM_PMD
> 	- Clock divider for STM and TPIU
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Cc: Kevin Hilman <khilman@linaro.org>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Rajendra Nayak <rnayak@ti.com>

Acked-by: Paul Walmsley <paul@pwsan.com>

based on a quick glance.


- Paul
