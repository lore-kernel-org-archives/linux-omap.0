From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv9 6/8] ARM: OMAP4: retrigger localtimers after re-enabling
 gic
Date: Sat, 27 Oct 2012 02:51:16 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210270250140.27071@utopia.booyaka.com>
References: <1350552010-28760-1-git-send-email-t-kristo@ti.com> <1350552010-28760-7-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:41443 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758292Ab2J0CvR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Oct 2012 22:51:17 -0400
In-Reply-To: <1350552010-28760-7-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org, Colin Cross <ccross@android.com>, Sebastien Jan <s-jan@ti.com>, tony@atomide.com

Hi

On Thu, 18 Oct 2012, Tero Kristo wrote:

> From: Colin Cross <ccross@android.com>
> 
> 'Workaround for ROM bug because of CA9 r2pX gic control'
> register change disables the gic distributor while the secondary
> cpu is being booted.  If a localtimer interrupt on the primary cpu
> occurs when the distributor is turned off, the interrupt is lost,
> and the localtimer never fires again.

Looks like this one should go in separately via Tony.


- Paul
