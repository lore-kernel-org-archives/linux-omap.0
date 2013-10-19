From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 11/11] ARM: OMAP2+: CM: move direct register write macros
 to internal header
Date: Sat, 19 Oct 2013 17:36:56 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1310191736190.12900@utopia.booyaka.com>
References: <1381508141-15244-1-git-send-email-t-kristo@ti.com> <1381508141-15244-12-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:49041 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753789Ab3JSRg5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 19 Oct 2013 13:36:57 -0400
In-Reply-To: <1381508141-15244-12-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@linaro.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org

On Fri, 11 Oct 2013, Tero Kristo wrote:

> The direct register access macros should not be exposed to CM clients.
> Thus, move the register macros to their own file and only include these
> to the cm_*.c files.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

The basic idea here looks great, obviously we can't merge it yet...

- Paul
