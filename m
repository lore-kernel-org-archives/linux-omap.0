From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 4/8] OMAP4: clock data: Add missing fields in
 iva_hsd_byp_clk_mux_ck
Date: Fri, 10 Dec 2010 17:34:15 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012101732320.13430@utopia.booyaka.com>
References: <1291932820-11163-1-git-send-email-b-cousson@ti.com> <1291932820-11163-5-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40841 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751575Ab0LKAeQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Dec 2010 19:34:16 -0500
In-Reply-To: <1291932820-11163-5-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>, Jonathan Bergsagel <jbergsagel@ti.com>
Cc: khilman@deeprootsystems.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

On Thu, 9 Dec 2010, Benoit Cousson wrote:

> From: Jonathan Bergsagel <jbergsagel@ti.com>
> 
> Add register address, mask and link to the clksel structure that
> were missing in the IVA DPLL mux clock node.
> 
> Signed-off-by: Jonathan Bergsagel <jbergsagel@ti.com>
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>

This patch results in a checkpatch warning:

---

WARNING: please, no space before tabs
#23: FILE: arch/arm/mach-omap2/clock44xx_data.c:639:
+^I.clksel ^I= iva_hsd_byp_clk_mux_sel,$

total: 0 errors, 1 warnings, 0 checks, 13 lines checked

Your patch has style problems, please review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.

---

I've fixed it in the copy in my local branch, but next time, please run 
checkpatch.pl and fix any problems before submitting.

regards,

- Paul
