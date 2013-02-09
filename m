From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2] drivers/gpio: using common order: let 'static const' instead of 'const static'
Date: Sat, 09 Feb 2013 14:22:11 +0000
Message-ID: <20130209142211.8FEB93E30EC@localhost>
References: <51122147.6080708@asianux.com> <5112241B.8050207@ti.com> <511232B1.7090206@asianux.com> <5112334F.1020508@ti.com> <51123410.40602@asianux.com> <511234BC.2000305@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:35968 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757951Ab3BIOWQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 9 Feb 2013 09:22:16 -0500
Received: by mail-wg0-f53.google.com with SMTP id fn15so3766291wgb.32
        for <linux-omap@vger.kernel.org>; Sat, 09 Feb 2013 06:22:14 -0800 (PST)
In-Reply-To: <511234BC.2000305@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>, Chen Gang <gang.chen@asianux.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linus.walleij@linaro.org, linux-omap@vger.kernel.org

On Wed, 6 Feb 2013 16:17:24 +0530, Santosh Shilimkar <santosh.shilimkar@ti.com> wrote:
> On Wednesday 06 February 2013 04:14 PM, Chen Gang wrote:
> >
> >    'const static ' is not a common order, better to use 'static const' instead.
> >
> > building:
> >    make EXTRA_CFLAGS=-W ARCH=arm
> >
> >    drivers/gpio/gpio-omap.c:1479:
> >      warning: 'static' is not at beginning of declaration
> >    drivers/gpio/gpio-omap.c:1485:
> >      warning: 'static' is not at beginning of declaration
> >    drivers/gpio/gpio-omap.c:1491:
> >      warning: 'static' is not at beginning of declaration
> >
> >
> > Signed-off-by: Chen Gang <gang.chen@asianux.com>
> > Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > ---
> Thanks for update.
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Applied, thanks.

g.

