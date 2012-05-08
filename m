From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH v4-alt 3/6] ARM: OMAP3: hwmod data: add gpmc
Date: Tue, 8 May 2012 09:37:52 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1205080936300.9984@utopia.booyaka.com>
References: <cover.1335941443.git.afzal@ti.com> <99ffbbcc634022ed3c781c37e03989f1d898003e.1335941444.git.afzal@ti.com> <alpine.DEB.2.00.1205051949290.20926@utopia.booyaka.com> <C8443D0743D26F4388EA172BF4E2A7A93E987188@DBDE01.ent.ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E987E55@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33613 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756106Ab2EHPhx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 11:37:53 -0400
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E987E55@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi

On Tue, 8 May 2012, Mohammed, Afzal wrote:

> If HWMOD_NO_INIT_RESET is not present, it would break GPMC on
> many of the existing boards.

IMHO, that should also be fixed as part of your changes, to remove what 
seems to be an unnecessary bootloader dependency.

http://marc.info/?l=linux-omap&m=133649129220098&w=2


- Paul
