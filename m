From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] ARM: omap5: build opp4xxx_data.c
Date: Tue, 25 Jun 2013 15:17:55 -0500
Message-ID: <CAGo_u6rQG7h2aPSErwKR1H7PYE5QdxXU3Dd5z13-rPkbVtkcUw@mail.gmail.com>
References: <201306212229.54238.arnd@arndb.de>
	<20130621204250.GA16139@kahuna>
	<alpine.DEB.2.02.1306251918590.14373@utopia.booyaka.com>
	<51C9F595.3060609@ti.com>
	<20130625195751.GA6529@kahuna>
	<51C9F993.6050109@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f175.google.com ([74.125.82.175]:60203 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358Ab3FYUR4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Jun 2013 16:17:56 -0400
Received: by mail-we0-f175.google.com with SMTP id t59so9782603wes.34
        for <linux-omap@vger.kernel.org>; Tue, 25 Jun 2013 13:17:55 -0700 (PDT)
In-Reply-To: <51C9F993.6050109@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Arnd Bergmann <arnd@arndb.de>, linux-omap <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, "J, KEERTHY" <j-keerthy@ti.com>

On Tue, Jun 25, 2013 at 3:12 PM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
>
> Well having voltage data in voltage domain was not my decision ;-)
> Instead of creating another set of dummy data, I just used what
> is out there(OMAP4) with clear comment that data needs to be updated.
> I don't see any problem in this considering we have devices booting
> and working nicely for OMAP5
I really wish the OMAP5 devices(the latest ones from Fab) I have would
like to function at OMAP4 configurations! Unfortunately the devices
tend to follow the data manual for OMAP5.
*if* there is no need for it to boot, I suggest removing it.

Regards,
Nishanth Menon
