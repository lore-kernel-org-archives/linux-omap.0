From: Paul Walmsley <paul@pwsan.com>
Subject: Re: Regression with AM43xx devices
Date: Tue, 2 Jun 2015 19:28:22 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1506021923590.14902@utopia.booyaka.com>
References: <20150602191752.GE9623@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:42561 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752140AbbFBT2Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Jun 2015 15:28:24 -0400
In-Reply-To: <20150602191752.GE9623@saruman.tx.rr.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Dave Gerlach <d-gerlach@ti.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

On Tue, 2 Jun 2015, Felipe Balbi wrote:

> You commit fabbe6df130a46d5b5e7484b2273d69c4be3012a (ARM: OMAP: AM43xx
> hwmod: Add data for am43xx emif hwmod) listed below added a new WARNING
> during boot to all AM43xx-based boards. Full boot logs can be found at
> [1],

Speaking of which, could you guys please send along an AM43xx board for 
the testbed?  That would help avoid these issues earlier.


- Paul
