From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 0/5] add gpio_chip_ops to hold GPIO operations
Date: Tue, 22 Apr 2014 16:17:42 +0200
Message-ID: <201404221617.43272.arnd@arndb.de>
References: <1396981215-24888-1-git-send-email-javier.martinez@collabora.co.uk> <CACRpkdYLaGXJ+O0rsL5+rjUsOvxCxK2b9QtH2j4FD0g21vx8_Q@mail.gmail.com> <CABxcv=mb+CXQbrS==hBayMQGsaJCPuLR=xyW_BJpZm2oSNBu-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.130]:60231 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753950AbaDVORz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Apr 2014 10:17:55 -0400
In-Reply-To: <CABxcv=mb+CXQbrS==hBayMQGsaJCPuLR=xyW_BJpZm2oSNBu-w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Alexandre Courbot <acourbot@nvidia.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@linaro.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tuesday 22 April 2014, Javier Martinez Canillas wrote:
> Hello Linus,
> 
> On Tue, Apr 22, 2014 at 1:36 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Tue, Apr 8, 2014 at 8:20 PM, Javier Martinez Canillas
> > <javier.martinez@collabora.co.uk> wrote:
> >
> >> So this is an RFC patch-set to add a virtual table to be used by
> >> GPIO chip controllers and consist of the following patches:
> >
> > Overall I like this.

Agreed, it's a very good cleanup.

> > However I don't want to see any transitional phase. I prefer a BIG
> > fat patch converting everyone and its dog to the new vtable and
> > removing the old function pointers. This can be based on the HEAD
> > of my GPIO devel branch.
> >
> 
> Ok, I was adding a commit per GPIO driver but the patch-set would have
> been very big (~200 patches).
> 
> > It may be a good idea to use coccinelle for this refactoring in order
> > not to miss any users.
> >
> 
> Agreed, I was manually searching for users by using grep but I agree
> that is much safer to use coccinelle for this. I don't have previous
> experience writing coccinelle semantics patches though so it may take
> more time than I thought but it is the perfect excuse to finally learn
> how to do it :-)

I'm not a big fan of doing this all at once, but it's not my call here.
Just one recommendation: if you can't do an obvious coccinelle patch
to do everything at once, use extra patches in the beginning to clean
up the code enough to make it work, then have the large patch fully
automated.

	Arnd
