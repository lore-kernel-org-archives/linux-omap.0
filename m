From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 6/6] arm: omap2: clksel: fix compile warning
Date: Tue, 15 Feb 2011 11:33:37 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1102151129430.16198@utopia.booyaka.com>
References: <1297774156-23312-1-git-send-email-balbi@ti.com> <1297774156-23312-7-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:54813 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755333Ab1BOSdj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Feb 2011 13:33:39 -0500
In-Reply-To: <1297774156-23312-7-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Tue, 15 Feb 2011, Felipe Balbi wrote:

> Fix the following compile warning:
> arch/arm/mach-omap2/clkt_clksel.c: In function '_get_div_and_fieldval':
> arch/arm/mach-omap2/clkt_clksel.c:100:35: warning: 'max_clkr' may be
> used uninitialized in this function
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>

This is just due to the compiler's ignorance, but anyway,

Acked-by: Paul Walmsley <paul@pwsan.com>


- Paul
