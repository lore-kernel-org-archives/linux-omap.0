From: Paul Walmsley <paul@booyaka.com>
Subject: Re: [PATCH] OMAP3: PM: readability fix for IVA2 DPLL autoidle
Date: Tue, 25 Nov 2008 10:07:19 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0811251007020.28747@utopia.booyaka.com>
References: <1227626615-2949-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40629 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751494AbYKYRHU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Nov 2008 12:07:20 -0500
In-Reply-To: <1227626615-2949-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

On Tue, 25 Nov 2008, Kevin Hilman wrote:

> No functional change, just a readability fix.
> 
> The symbolic name of the shift value used in writing
> CM_AUTOIDLE_PLL_IVA2 referred values in the CM_CLKSTCTRL_IVA2
> register.  Fix this to use the AUTOIDLE fields.
> 
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>

Acked-by: Paul Walmsley <paul@pwsan.com>


- Paul
