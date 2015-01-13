From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/4] Drop legacy support for omap3517
Date: Tue, 13 Jan 2015 21:24:22 +0100
Message-ID: <10549142.7lWnPtPtZG@wuerfel>
References: <1421171865-5209-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:61157 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113AbbAMUY1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Jan 2015 15:24:27 -0500
In-Reply-To: <1421171865-5209-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On Tuesday 13 January 2015 09:57:41 Tony Lindgren wrote:
> 
> It seems we can now drop omap3517 legacy booting support to get
> a bit closer to making all of omap3 boot in device tree only mode.
> 
> All these boards have at least minimal support for booting with
> device tree, and pretty much anything supported with the legacy
> board files can be configured also for device tree based booting
> if not done already.

Ah, very nice.

Just out of curiosity, what are the remaining showstoppers for
the 3430 and 3530 based boards?

	Arnd
