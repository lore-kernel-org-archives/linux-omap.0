From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv6 01/11] ARM: OMAP: clockdomain: Fix locking on
 _clkdm_clk_hwmod_enable / disable
Date: Wed, 17 Oct 2012 02:25:15 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210170224570.9767@utopia.booyaka.com>
References: <1348589142-11983-1-git-send-email-t-kristo@ti.com> <1348589142-11983-2-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:45255 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756126Ab2JQCZQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Oct 2012 22:25:16 -0400
In-Reply-To: <1348589142-11983-2-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org, tony@atomide.com

On Tue, 25 Sep 2012, Tero Kristo wrote:

> Previously the code only acquired spinlock after increasing / decreasing
> the usecount value, which is wrong. This leaves a small window where
> a task switch may occur between the check of the usecount and the actual
> wakeup / sleep of the domain. Fixed by moving the spinlock locking before
> the usecount access. Left the usecount as atomic_t if someone wants an
> easy access to the parameter through atomic_read.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

Acked-by: Paul Walmsley <paul@pwsan.com>

- Paul
