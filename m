From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: Re: [PATCH] OMAPDSS: DPI: add dependency to DSI
Date: Thu, 18 Apr 2013 19:26:01 +0200
Message-ID: <1366305961.4085.60.camel@mars>
References: <516BDD35.4000807@ti.com> <1366274225.4085.44.camel@mars>
	 <516FB845.3070505@ti.com>  <516FBB19.4090609@ti.com>
	 <1366280026.4085.55.camel@mars>  <51700539.7080603@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f48.google.com ([209.85.214.48]:48679 "EHLO
	mail-bk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966911Ab3DRR0R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Apr 2013 13:26:17 -0400
Received: by mail-bk0-f48.google.com with SMTP id jf3so1387050bkc.35
        for <linux-omap@vger.kernel.org>; Thu, 18 Apr 2013 10:26:15 -0700 (PDT)
In-Reply-To: <51700539.7080603@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Dave Airlie <airlied@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>

On Thu, 2013-04-18 at 17:37 +0300, Tomi Valkeinen wrote:
> > But here with linux-next (in contrast to 3.9-rc) removing all regulator
> > dependencies from drivers/video/omap2/dss/dpi.c does not make the trick.
> > The display stays dark :-( ...
> 
> That's with your DT hacked kernel, right? Not the official supported one.

yeah - it's fixed and working right now again.

 Thanks
   -- Christoph


