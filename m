From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 2/3] OMAP3 EHCI: use clock framework to program DPLL5,
 DPLL5_M2_CLK
Date: Thu, 11 Dec 2008 15:49:37 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0812111549140.26754@utopia.booyaka.com>
References: <20081211212030.22860.49518.stgit@localhost.localdomain> <20081211212239.22860.56824.stgit@localhost.localdomain> <FCCFB4CDC6E5564B9182F639FC3560870251066D54@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:43398 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755003AbYLKWti (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Dec 2008 17:49:38 -0500
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC3560870251066D54@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, 12 Dec 2008, Pandita, Vikram wrote:

> Can we have these clocks hidden from the driver.
> USB-Host understands only :
> 2 fclocks
> 1 iclock
> 
> The DPLL5 is outside the USBHOST module in the DPLL5 part.
> Ideally, the clock node for say USBHOST-iclock should internally enable all the parent clocks.

Yes, I agree, this patch is just for testing.


- Paul
