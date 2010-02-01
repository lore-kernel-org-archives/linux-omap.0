From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 6/9] omap3/4: Fix compile for multi-omap for
 clkops_noncore_dpll_ops
Date: Mon, 1 Feb 2010 13:20:18 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1002011319340.20004@utopia.booyaka.com>
References: <20100130020036.10590.78028.stgit@baageli.muru.com> <20100130020136.10590.83332.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33456 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756049Ab0BAUUT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Feb 2010 15:20:19 -0500
In-Reply-To: <20100130020136.10590.83332.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Fri, 29 Jan 2010, Tony Lindgren wrote:

> Rename clkops_noncore_dpll_ops for omap3 and omap4.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Acked-by: Paul Walmsley <paul@pwsan.com>

In the long term we might try to share those, but this is an elegant 
solution for the purpose.

- Paul
