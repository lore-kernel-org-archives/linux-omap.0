From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [GIT PULL 1/10] omap non-critical fixes for v3.5 merge window
Date: Fri, 11 May 2012 02:33:13 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1205110231120.3201@utopia.booyaka.com>
References: <4fac0be2.e9a0320a.1f37.7e70SMTPIN_ADDED@mx.google.com> <CAOesGMi0+fty-x1kq0qo+msya=p5xyQDsB9iFrtht38Rn5V=Eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37431 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757826Ab2EKIdO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 May 2012 04:33:14 -0400
In-Reply-To: <CAOesGMi0+fty-x1kq0qo+msya=p5xyQDsB9iFrtht38Rn5V=Eg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Tony Lindgren <tony@atomide.com>, Arnd Bergmann <arnd@arndb.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello Olof,

On Fri, 11 May 2012, Olof Johansson wrote:

> I did notice that omap2plus_defconfig has grown a new warning caused
> by "ARM: OMAP2+: clean up some cppcheck warnings" (oh, the irony!):
> 
> arch/arm/plat-omap/usb.c: In function 'omap_otg_init':
> arch/arm/plat-omap/usb.c:40:6: warning: unused variable 'status'
> [-Wunused-variable]

Thanks, this has been fixed by:

http://marc.info/?l=linux-omap&m=133660322929805&w=2

- Paul
