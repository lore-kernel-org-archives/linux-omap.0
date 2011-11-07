From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] arm: omap2+: hwmod: fix breakage introduced by
 d6504acd
Date: Mon, 7 Nov 2011 14:29:35 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1111071428001.12394@utopia.booyaka.com>
References: <1320688617-4543-1-git-send-email-balbi@ti.com> <20111107183208.GG15294@n2100.arm.linux.org.uk> <20111107193908.GA5059@legolas.emea.dhcp.ti.com> <20111107212707.GH15294@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50262 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246Ab1KGV3g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Nov 2011 16:29:36 -0500
In-Reply-To: <20111107212707.GH15294@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

On Mon, 7 Nov 2011, Russell King - ARM Linux wrote:

> Again, can never have been tested on OMAP3.
> 
> Does anyone apart from me bother doing any testing what so ever on OMAP3
> platforms?  Am I the only one?

This was fixed by 

http://www.spinics.net/lists/arm-kernel/msg143549.html

which didn't go upstream as part of the v3.2 merge window.


- Paul
