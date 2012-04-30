From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 3/6] ARM: OMAP4: hwmod: drop extra cpu_is check from
 _wait_target_disable()
Date: Mon, 30 Apr 2012 08:29:19 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204300828560.10308@utopia.booyaka.com>
References: <1335557140-10854-1-git-send-email-khilman@ti.com> <1335557140-10854-4-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46961 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752670Ab2D3O3T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Apr 2012 10:29:19 -0400
In-Reply-To: <1335557140-10854-4-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, 27 Apr 2012, Kevin Hilman wrote:

> _omap4_wait_target_disable() is called only from inside _omap4_disable_module()
> which is already protected by SoC specific checks.  Remove the cpu_is check
> here.
> 
> Signed-off-by: Kevin Hilman <khilman@ti.com>

Looks good to me.


- Paul
