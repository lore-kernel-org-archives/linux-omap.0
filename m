From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP1: fix USB host on 1710
Date: Fri, 25 Jan 2013 08:10:05 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1301250809500.471@utopia.booyaka.com>
References: <1359066295-20382-1-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:41362 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751275Ab3AYIKG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Jan 2013 03:10:06 -0500
In-Reply-To: <1359066295-20382-1-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, 25 Jan 2013, Aaro Koskinen wrote:

> There is a long-standing bug that OHCI USB host controller does
> not respond on 1710, because of wrong clock definitions. See e.g.
> http://marc.info/?l=linux-omap&m=119634441229321&w=2. All register reads
> return just zeroes:

Thanks, queued for v3.8-rc fixes.

- Paul
