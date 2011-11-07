From: Paul Walmsley <paul@pwsan.com>
Subject: Re: Fix handling of return value in omap3xx_hwmod_init and sr
 warning.
Date: Mon, 7 Nov 2011 14:31:25 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1111071431070.12394@utopia.booyaka.com>
References: <1320701417-16818-1-git-send-email-J.Kilb@phytec.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50307 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752212Ab1KGVbZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Nov 2011 16:31:25 -0500
In-Reply-To: <1320701417-16818-1-git-send-email-J.Kilb@phytec.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Juergen Kilb <J.Kilb@phytec.de>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, 7 Nov 2011, Juergen Kilb wrote:

> After this, I got some new warnings during bootup about sr1_hwmod and sr2_hwmod.
> This is fixed with PATCH2/2.

Thanks for the patches, but these should be already fixed by 

http://www.spinics.net/lists/arm-kernel/msg143549.html

- Paul
