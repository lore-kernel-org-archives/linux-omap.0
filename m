From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv5 0/6] ARM: OMAP3+: IO daisy chain support fixes
Date: Sat, 10 Mar 2012 14:29:45 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1203101425230.27395@utopia.booyaka.com>
References: <1331046702-2472-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:56851 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751835Ab2CJV3q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 10 Mar 2012 16:29:46 -0500
In-Reply-To: <1331046702-2472-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, rnayak@ti.com, Vishwanath BS <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org


Hi

By the way, one other thing I forgot to mention.  It would be really great 
if kerneldoc comments can be created for any new functions added to hwmod, 
PRCM, clock, or omap_device code.  The intention is to help not only 
people unfamiliar with the code, but even ourselves in the future.  I've 
been adding these by hand on Tero's last few patch series, but at some 
point I'll probably stop accepting patches without kerneldoc.


thanks,

- Paul
