From: "Gupta, Pekon" <pekon@ti.com>
Subject: RE: [PATCH v10 00/10] mtd:nand:omap2: clean-up of supported ECC
 schemes
Date: Wed, 23 Oct 2013 05:10:21 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73EA29DCC@DBDE04.ent.ti.com>
References: <1382172254-12448-1-git-send-email-pekon@ti.com>
 <20131022203009.GM23337@ld-irv-0074.broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45257 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820Ab3JWFLH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Oct 2013 01:11:07 -0400
In-Reply-To: <20131022203009.GM23337@ld-irv-0074.broadcom.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "olof@lixom.net" <olof@lixom.net>, "dedekind1@gmail.com" <dedekind1@gmail.com>, "robherring2@gmail.com" <robherring2@gmail.com>, "Pawel.Moll@arm.com" <Pawel.Moll@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "arnd@arndb.de" <arnd@arndb.de>, "tony@atomide.com" <tony@atomide.com>, "bcousson@baylibre.com" <bcousson@baylibre.com>, "avinashphilipk@gmail.com" <avinashphilipk@gmail.com>, "Balbi, Felipe" <balbi@ti.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "jp.francois@cynove.com" <jp.francois@cynove.com>, "ivan.djelic@parrot.com" <ivan.djelic@parrot.com>

Hi Brian,

> From: Brian Norris [mailto:computersforpeace@gmail.com]
> > [PATCH 4/10]
> >   dropped [PATCH v9 4/9] introducing NAND_BUSWIDTH_AUTO, instead
> >   using DT 'nand-bus-width' for device bus-width
> 
> As mentioned in reply to the patch, I don't think this patch belongs in
> this series now, and it is still not adequate (the original code there
> is wrong in some ways, but your changes are not clearly better).
> 
Probably there was some confusion in review this patch.. 
I have added my comments and replies to you.
Request you to please re-review..

And as I suppose this is the only remaining piece in this series, so
If that's ok, request you to please pull-in this series..
So, I can re-work on next pending series.. 


with regards, pekon
