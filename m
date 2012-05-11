From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL 1/10] omap non-critical fixes for v3.5 merge window
Date: Fri, 11 May 2012 00:21:52 -0700
Message-ID: <CAOesGMi0+fty-x1kq0qo+msya=p5xyQDsB9iFrtht38Rn5V=Eg@mail.gmail.com>
References: <4fac0be2.e9a0320a.1f37.7e70SMTPIN_ADDED@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:49907 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751782Ab2EKHVx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 May 2012 03:21:53 -0400
Received: by yenm10 with SMTP id m10so2316568yen.19
        for <linux-omap@vger.kernel.org>; Fri, 11 May 2012 00:21:53 -0700 (PDT)
In-Reply-To: <4fac0be2.e9a0320a.1f37.7e70SMTPIN_ADDED@mx.google.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>

Tony,

I've pulled all 10 requests. Many of them ended up going into the same
next/ branch, but that's quite OK. Please double check my merge
conflict resolutions.

One nit is that at least one of the branches had a few varying patch
subjects, so just a friendly reminder to sanitize them to ARM: OMAP.*:
or so when you apply patches.

I did notice that omap2plus_defconfig has grown a new warning caused
by "ARM: OMAP2+: clean up some cppcheck warnings" (oh, the irony!):

arch/arm/plat-omap/usb.c: In function 'omap_otg_init':
arch/arm/plat-omap/usb.c:40:6: warning: unused variable 'status'
[-Wunused-variable]


-Olof
