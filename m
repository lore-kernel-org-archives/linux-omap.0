From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH resend] hsi: fix kernel-doc warnings
Date: Mon, 4 Mar 2013 03:56:04 +0100
Message-ID: <CACRpkdb83GYi7FNjz-ZgbatTQzgZsB=PdkiCuVFt4TK1s2kM+g@mail.gmail.com>
References: <5130FD73.9030601@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ia0-f178.google.com ([209.85.210.178]:32779 "EHLO
	mail-ia0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755049Ab3CDC4G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 3 Mar 2013 21:56:06 -0500
Received: by mail-ia0-f178.google.com with SMTP id y26so4318561iab.37
        for <linux-omap@vger.kernel.org>; Sun, 03 Mar 2013 18:56:05 -0800 (PST)
In-Reply-To: <5130FD73.9030601@infradead.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Nishanth Menon <nm@ti.com>, Carlos Chinea <carlos.chinea@nokia.com>, linux-omap@vger.kernel.org

On Fri, Mar 1, 2013 at 8:11 PM, Randy Dunlap <rdunlap@infradead.org> wrote:

> From: Randy Dunlap <rdunlap@infradead.org>
>
> Fix kernel-doc warnings in hsi files:
>
> Warning(include/linux/hsi/hsi.h:136): Excess struct/union/enum/typedef member 'e_handler' description in 'hsi_client'
> Warning(include/linux/hsi/hsi.h:136): Excess struct/union/enum/typedef member 'pclaimed' description in 'hsi_client'
> Warning(include/linux/hsi/hsi.h:136): Excess struct/union/enum/typedef member 'nb' description in 'hsi_client'
> Warning(drivers/hsi/hsi.c:434): No description found for parameter 'handler'
> Warning(drivers/hsi/hsi.c:434): Excess function parameter 'cb' description in 'hsi_register_port_event'
>
> Don't document "private:" fields with kernel-doc notation.
> If you want to leave them fully documented, that's OK, but
> then don't mark them as "private:".
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Carlos Chinea <carlos.chinea@nokia.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-omap@vger.kernel.org
> Acked-by: Nishanth Menon <nm@ti.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

HSI is basically orphaned FTM.

Andrew can you pick this into your orphanage?

Yours,
Linus Walleij
