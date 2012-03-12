From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv5 3/6] ARM: OMAP4 PM: Add IO Daisychain support
Date: Mon, 12 Mar 2012 00:51:29 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1203120050360.11332@utopia.booyaka.com>
References: <1331046702-2472-1-git-send-email-t-kristo@ti.com> <1331046702-2472-4-git-send-email-t-kristo@ti.com> <alpine.DEB.2.00.1203092051140.30879@utopia.booyaka.com> <4F5D8F2A.1070602@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51848 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209Ab2CLGv3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Mar 2012 02:51:29 -0400
In-Reply-To: <4F5D8F2A.1070602@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org, Vishwanath BS <vishwanath.bs@ti.com>

On Mon, 12 Mar 2012, Rajendra Nayak wrote:

> > Signed-off-by: Tero Kristo<t-kristo@ti.com>
> > [paul@pwsan.com: removed MAX_IOPAD_LATCH_TIME declaration; renamed
> 
> But the code below still seems to use it. Is it now defined in some
> common header so the same value is used in omap3 and omap4?

Yes, I put it into prcm-common.h in the previous patch that added it for 
OMAP3.  I'll update that comment to clarify.


- Paul
