From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RFC 3/6] ARM: OMAP3: hwmod data: fix iva2 reset info
Date: Sun, 15 Jul 2012 18:12:13 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1207151811380.28834@utopia.booyaka.com>
References: <1342197459-7920-1-git-send-email-t-kristo@ti.com> <1342197459-7920-4-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36518 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410Ab2GPAMN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 15 Jul 2012 20:12:13 -0400
In-Reply-To: <1342197459-7920-4-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org

On Fri, 13 Jul 2012, Tero Kristo wrote:

> IVA2 hwmod resets were missing the status bit offsets. Also, as the
> hwmod itself didn't have prcm info at all, resetting iva hwmod was
> accessing some bogus memory addresses. Added both infos to fix this.
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

Thanks, this one looks like it's fodder for the -rc series due to the 
accesses, so, queuing for 3.6-rc.


- Paul
