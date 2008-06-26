From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] PRCM: 34XX: Fix wrong shift value used in
	dpll4_m4x2_ck enable bit
Date: Thu, 26 Jun 2008 16:40:51 +0300
Message-ID: <20080626134051.GI12992@atomide.com>
References: <1214372282-1862-1-git-send-email-jouni.hogander@nokia.com> <alpine.DEB.1.00.0806250027150.5159@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:52852 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764956AbYFZNkz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Jun 2008 09:40:55 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0806250027150.5159@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Jouni Hogander <jouni.hogander@nokia.com>, linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [080625 09:28]:
> On Wed, 25 Jun 2008, Jouni Hogander wrote:
> 
> > Enable bit for dpll4_m4x2_ck is OMAP3430_PWRDN_DSS1_SHIFT instead of
> > OMAP3430_PWRDN_CAM_SHIFT.
> > 
> > Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
> 
> Acked-by: Paul Walmsley <paul@pwsan.com>

Pushing today.

Tony
