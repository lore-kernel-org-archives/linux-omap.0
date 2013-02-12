From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH] ARM: OMAP: Clock: Remove CK_* flags
Date: Tue, 12 Feb 2013 20:49:00 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1302122028480.29149@utopia.booyaka.com>
References: <1359966525-7603-1-git-send-email-j-keerthy@ti.com> <alpine.DEB.2.00.1302080248550.8539@utopia.booyaka.com> <DC88CAD03C0052499C1907B327FC63229B92FF@DBDE01.ent.ti.com> <alpine.DEB.2.00.1302081805450.28008@utopia.booyaka.com>
 <alpine.DEB.2.00.1302081855370.28008@utopia.booyaka.com>  <DC88CAD03C0052499C1907B327FC63229B966E@DBDE01.ent.ti.com> <alpine.DEB.2.00.1302111538430.8260@utopia.booyaka.com> <DC88CAD03C0052499C1907B327FC63229B989B@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1302120638580.14983@utopia.booyaka.com> <DC88CAD03C0052499C1907B327FC63229B98DD@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:42441 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758579Ab3BLUtB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Feb 2013 15:49:01 -0500
In-Reply-To: <DC88CAD03C0052499C1907B327FC63229B98DD@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "J, KEERTHY" <j-keerthy@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, 12 Feb 2013, J, KEERTHY wrote:

> Heh :-). It narrowed down to this patch:
> 
> commit 17b7e7d33530e2bbd3bdc90f4db09b91cfdde2bb
> Author: Paul Walmsley <paul@pwsan.com>
> Date:   Sat Jan 26 00:48:54 2013 -0700
> 
>     ARM: OMAP4: clock/hwmod data: start to remove some IP block control "clocks"

Thanks, this fixes it:

http://marc.info/?l=linux-omap&m=136070089529743&w=2

But at this point, I've rescheduled your patch to the 3.10-cleanup time 
frame, since we're pretty close to the 3.9 merge window.


- Paul
