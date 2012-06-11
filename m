From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/2] Revert "ARM: OMAP2+: clockdomains: make {prm,cm}_clkdm
 common"
Date: Mon, 11 Jun 2012 11:31:45 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206111126521.5849@utopia.booyaka.com>
References: <1339433225-30042-1-git-send-email-b-cousson@ti.com> <1339433225-30042-3-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36360 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752340Ab2FKRbp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jun 2012 13:31:45 -0400
In-Reply-To: <1339433225-30042-3-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, 11 Jun 2012, Benoit Cousson wrote:

> Neither prm_clkdm nor cm_clkdm does exist on OMAP4.
> Remove the common definition that does not make sense anymore
> since it is not common for OMAP2+ platforms.
> 
> Please note that these clock domains are probably non existant
> on OMAP 2 & 3 and thus should be removed in all the
> clockdomain files.

For the archives:

http://marc.info/?l=linux-omap&m=133943578712129&w=2


- Paul
