From: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [RFC PATCH] tty: serial: Add 8250-core based omap driver
Date: Fri, 4 Jul 2014 17:59:35 +0100
Message-ID: <CAFEAcA-UyLWteuNUO1xa5cGvQQV-fscJtiaC7B6N=cdTam-UQA@mail.gmail.com>
References: <1404316809-20637-1-git-send-email-bigeasy@linutronix.de>
 <20140702160932.GF5541@saruman.home> <20140702190944.GA567@drone.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:42195 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753232AbaGDQ75 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Jul 2014 12:59:57 -0400
Received: by mail-lb0-f177.google.com with SMTP id u10so1291502lbd.8
        for <linux-omap@vger.kernel.org>; Fri, 04 Jul 2014 09:59:55 -0700 (PDT)
In-Reply-To: <20140702190944.GA567@drone.musicnaut.iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

On 2 July 2014 20:09, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> When ttyS -> ttyO change was done on OMAP, compatibility was not an issue.
> Why should we care about it now?

You should have cared about it back then as well -- it was
really annoying and required everybody running an OMAP
based board to suddenly fix up their userland and command
line configs when they got broken by a kernel upgrade.

thanks
-- PMM
