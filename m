From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHV6 2/4] OMAP3: Remove FreqSel for 3630
Date: Mon, 8 Feb 2010 12:17:57 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1002081217420.22923@utopia.booyaka.com>
References: <1265638684-30250-1-git-send-email-vishwanath.bs@ti.com> <1265638684-30250-2-git-send-email-vishwanath.bs@ti.com> <1265638684-30250-3-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:34633 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752575Ab0BHTR5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Feb 2010 14:17:57 -0500
In-Reply-To: <1265638684-30250-3-git-send-email-vishwanath.bs@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath BS <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org

On Mon, 8 Feb 2010, Vishwanath BS wrote:

> DPLL_FREQSEL field in CLKEN_PLL register is no longer valid for
> OMAP3630. So remove
> references to that.
> 
> Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>

Thanks, queued for 2.6.34.


- Paul
