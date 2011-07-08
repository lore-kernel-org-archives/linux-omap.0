From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 5/6] OMAP4: powerdomain: Reuse on 4460 using
 CHIP_IS_44XX
Date: Fri, 8 Jul 2011 00:51:31 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107080051140.24181@utopia.booyaka.com>
References: <1309573826-10615-1-git-send-email-rnayak@ti.com> <1309573826-10615-2-git-send-email-rnayak@ti.com> <1309573826-10615-3-git-send-email-rnayak@ti.com> <1309573826-10615-4-git-send-email-rnayak@ti.com> <1309573826-10615-5-git-send-email-rnayak@ti.com>
 <1309573826-10615-6-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:38562 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751232Ab1GHGvc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jul 2011 02:51:32 -0400
In-Reply-To: <1309573826-10615-6-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>

On Sat, 2 Jul 2011, Rajendra Nayak wrote:

> The 4460 platform has no difference in the powerdomains as compared
> to the 4430 platform. Hence just update the .omap_chip field to make
> sure the same powerdomain data can be reused on the 4460 platform.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Reviewed-by: Kevin Hilman <khilman@ti.com>

Acked-by: Paul Walmsley <paul@pwsan.com>


- Paul
