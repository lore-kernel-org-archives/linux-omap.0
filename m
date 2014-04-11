From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: AM33xx: hwmod: Add INIT_NO_IDLE flag for debugss
 hwmod
Date: Fri, 11 Apr 2014 18:00:53 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1404111800430.14347@utopia.booyaka.com>
References: <1397022467-6166-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:60001 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752807AbaDKSAy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Apr 2014 14:00:54 -0400
In-Reply-To: <1397022467-6166-1-git-send-email-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, nsekhar@ti.com, rnayak@ti.com, hvaibhav@ti.com

On Wed, 9 Apr 2014, Lokesh Vutla wrote:

> During boot, when hwmod tries to cut clocks for debugss it always
> gets stuck in transition state and throws the following warning:
> 
> [    0.139581] omap_hwmod: debugss: _wait_target_disable failed
> 
> As per the information provided by folks, clocks to debugss cannot be cut.
> So adding HWMOD_INIT_NO_IDLE flag to debugss hwmod.
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>

Thanks, queued for v3.15-rc.


- Paul
