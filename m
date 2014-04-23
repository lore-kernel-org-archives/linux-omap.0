From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: regressions in linux-next?
Date: Wed, 23 Apr 2014 16:52:55 +0200
Message-ID: <CACRpkdbgLdkHo_hujU1QJBCvEo=tiDTCQL_SDgBFWYMXrkwwDA@mail.gmail.com>
References: <53566C20.6000208@ti.com>
	<53568706.1050204@ti.com>
	<5356E5E4.1060509@ti.com>
	<CABxcv=nATX0m8janD=kTZ_Askuy8StNx5r9vJM_Fq+EmQeZ0-g@mail.gmail.com>
	<5356F2A4.6010106@ti.com>
	<CABxcv=kx6zhJqVKcE1cijyOEak+jgXgsFaRAFYcZA4L_zxLRHg@mail.gmail.com>
	<20140423013022.GA18648@kahuna>
	<CABxcv=m3PhTXi=dRGPm_02-Edt_jOSCeVnTVKo_NiJkCzcKSew@mail.gmail.com>
	<CACRpkdZ1Sv9oWhPWYEemGEnsCojs5amMMkru8DjpPxc=c9MRHA@mail.gmail.com>
	<5357C04F.3060902@ti.com>
	<CACRpkdas=MxsvaB=q9rF7GwP+hJv61Ut5yL8Lc9amnTc=_E=pg@mail.gmail.com>
	<CABxcv=n_B4qDrgunKnyiY9769xPYOssi3ESAysiXU2ek9Zt2Xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f48.google.com ([209.85.219.48]:64368 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754724AbaDWOw4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Apr 2014 10:52:56 -0400
Received: by mail-oa0-f48.google.com with SMTP id m1so1124967oag.35
        for <linux-omap@vger.kernel.org>; Wed, 23 Apr 2014 07:52:55 -0700 (PDT)
In-Reply-To: <CABxcv=n_B4qDrgunKnyiY9769xPYOssi3ESAysiXU2ek9Zt2Xg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@linaro.org>, linux-omap <linux-omap@vger.kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>

On Wed, Apr 23, 2014 at 4:50 PM, Javier Martinez Canillas
<javier@dowhile0.org> wrote:

> What do you think about the following patch? Although I agree that if
> we can use IRQ_TYPE_NONE as you propose then tht is a much better and
> efficient solution that this patch.

Let's try IRQ_TYPE_NONE first and if that fails we go back to this.

I've pushed the current patch to linux-next.

Yours,
Linus Walleij
