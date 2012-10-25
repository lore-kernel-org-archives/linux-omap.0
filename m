From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 6/7] watchdog: OMAP: use standard GETBOOTSTATUS interface;
 use platform_data fn ptr
Date: Thu, 25 Oct 2012 20:16:11 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210252015490.21193@utopia.booyaka.com>
References: <20121016012448.21844.92339.stgit@dusk.lan> <20121016013233.21844.1279.stgit@dusk.lan> <50899DB9.8050308@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:37974 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760280Ab2JYUQM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Oct 2012 16:16:12 -0400
In-Reply-To: <50899DB9.8050308@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org

On Thu, 25 Oct 2012, Jon Hunter wrote:

> > +		if (!pdata->read_reset_sources)
> > +			return put_user(0, (int __user *)arg);
> 
> In the case of booting with device-tree, pdata could be null and so
> should we check for this too? In other words ...
> 
> +		if (!pdata || !pdata->read_reset_sources)
> +			return put_user(0, (int __user *)arg);

Thanks, good catch, will integrate that fix.


- Paul
