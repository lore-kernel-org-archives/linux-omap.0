From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP4 clock code needs some modifying now that clockdomains are
 present
Date: Fri, 18 Dec 2009 11:21:23 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0912181118100.12561@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:55117 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932458AbZLRSV2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Dec 2009 13:21:28 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: abhijitpagare@ti.com
Cc: rnayak@ti.com, linux-omap@vger.kernel.org


Hi Abhijit,

going through the clock code, I noticed that it still has several

#ifndef CONFIG_ARCH_OMAP4 /* FIXME: Remove this once clkdm f/w is in place */

Could you please put together a patch to remove these, test it on 4430ES1 
SDP, and send it to the list?

I'd suggest basing the patches on my upstream queue for .34, which is 
available at:

    git://git.pwsan.com/linux-2.6 for_2_6_34


thanks,

- Paul
