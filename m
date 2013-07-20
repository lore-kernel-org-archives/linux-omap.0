From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: Need help for DT GPIO probing
Date: Sat, 20 Jul 2013 21:43:53 +0200
Message-ID: <CACRpkdYXK6Phg4H5UviLSsJPsCOjykHRe3EnKpMphdFdOdnZUA@mail.gmail.com>
References: <CACpRUmig-J7tgipRFC5h09+4fHiOWpHpc3ELuTnujE1_gQCZrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f48.google.com ([209.85.219.48]:39519 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754823Ab3GTTny (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 20 Jul 2013 15:43:54 -0400
Received: by mail-oa0-f48.google.com with SMTP id f4so7532125oah.35
        for <linux-omap@vger.kernel.org>; Sat, 20 Jul 2013 12:43:53 -0700 (PDT)
In-Reply-To: <CACpRUmig-J7tgipRFC5h09+4fHiOWpHpc3ELuTnujE1_gQCZrw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Soumya Sutar <soumyasutar@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>
Cc: linux-gpio@vger.kernel.org, "santosh.shilimkar@ti.com" <santosh.shilimkar@ti.com>, ext Tony Lindgren <tony@atomide.com>, ext Kevin Hilman <khilman@deeprootsystems.com>

On Fri, Jul 12, 2013 at 4:05 PM, Soumya Sutar <soumyasutar@gmail.com> wrote:

> Hi Linus,
>
> I am facing DT GPIO probing problem same as below link.
> http://us.generation-nt.com/answer/gpio-crashed-when-not-using-help-208346861.html
>
> Could you know any patch is available for this issues or still we need to
> use gpio_request() in driver.

Please ask questions like this on the mailing lists and include
the OMAP GPIO maintainers (Santosh & Kevin).

And the answer is yes, all GPIO lines you are using need to
be requested by the driver.

Yours,
Linus Walleij
