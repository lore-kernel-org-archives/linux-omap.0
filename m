From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH, RFC] default machine descriptor for multiplatform
Date: Tue, 5 Feb 2013 13:39:32 -0800
Message-ID: <CAOesGMiyKCdevdgnRu6gwzx214OEZvq18jCijTer5pnqwv3yww@mail.gmail.com>
References: <20130131092024.GN2637@n2100.arm.linux.org.uk>
	<20130131161823.GT2637@n2100.arm.linux.org.uk>
	<1731670.s76EGcEZ7m@wuerfel>
	<1638002.UJ7zfj1Wn5@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f171.google.com ([74.125.82.171]:41790 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754908Ab3BEVje (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Feb 2013 16:39:34 -0500
Received: by mail-we0-f171.google.com with SMTP id u54so576834wey.30
        for <linux-omap@vger.kernel.org>; Tue, 05 Feb 2013 13:39:32 -0800 (PST)
In-Reply-To: <1638002.UJ7zfj1Wn5@wuerfel>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Nicolas Pitre <nico@fluxnic.net>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Fabio Estevam <festevam@gmail.com>

On Thu, Jan 31, 2013 at 9:51 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> This is what I think it would look like to do a default platform
> with an empty machine descriptor on ARM. It makes the few required
> entries in the descriptor optional by using the new irqchip_init()
> and clocksource_of_init() functions as defaults, and adds
> a fallback for the DT case to customize_machine to probe all
> the default devices.
>
> For the case that CONFIG_MULTIPLATFORM is enabled, it then
> adds a machine descriptor that never matches any machine but
> is used as a fallback if nothing else matches.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Nice!

Acked-by: Olof Johansson <olof@lixom.net>

(Besides what Stephen already pointed out)

-Olof
