From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP4: clock: fix mult and div mask for USB_DPLL
Date: Wed, 25 Jan 2012 12:04:19 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1201251204080.5324@utopia.booyaka.com>
References: <4F1E7F8A.4010805@ti.com> <1327455315-19464-1-git-send-email-ameya.palande@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40528 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751200Ab2AYTEU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jan 2012 14:04:20 -0500
In-Reply-To: <1327455315-19464-1-git-send-email-ameya.palande@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@ti.com>
Cc: b-cousson@ti.com, khilman@ti.com, linux-omap@vger.kernel.org, mturquette@ti.com, linux-arm-kernel@lists.infradead.org

On Tue, 24 Jan 2012, Ameya Palande wrote:

> According to OMAP4 TRM Table 3-1183, CM_CLKSEL_DPLL_USB register defines
> following fields for multiplication and division factors:
> 
> DPLL_MULT (bits 19:8) DPLL multiplier factor (2 to 4095)
> DPLL_DIV (bits 7:0) DPLL divider factor (0 to 255)
> 
> Acked-by: Benoit Cousson <b-cousson@ti.com>
> Signed-off-by: Ameya Palande <ameya.palande@ti.com>

Thanks, queued for 3.4.


- Paul
