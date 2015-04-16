From: Tyler Baker <tyler.baker@linaro.org>
Subject: Re: n900 in 4.1-rc0
Date: Thu, 16 Apr 2015 09:45:12 -0700
Message-ID: <CANMBJr5G2RpS1sw3N8FYitqzqFu8a2Gqj__i_742FZrMYuusOA@mail.gmail.com>
References: <20150416093234.GA17423@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vn0-f52.google.com ([209.85.216.52]:45813 "EHLO
	mail-vn0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752694AbbDPQpN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Apr 2015 12:45:13 -0400
Received: by vnbg190 with SMTP id g190so24194645vnb.12
        for <linux-omap@vger.kernel.org>; Thu, 16 Apr 2015 09:45:13 -0700 (PDT)
In-Reply-To: <20150416093234.GA17423@amd>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, tony@atomide.com, Kevin's boot bot <khilman@kernel.org>, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com

On 16 April 2015 at 02:32, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
> Just tried booting 4.1-rc0 on n900 (commit
> 34c9a0ffc75ad25b6a60f61e27c4a4b1189b8085) and it is broken.
>
> Any ideas?

Looks like DT and legacy booting are working fine in our labs. [0][1]

>                                                                         Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Tyler

[0] http://kernelci.org/boot/omap3-n900/
[1] http://kernelci.org/boot/omap3-n900,legacy/
