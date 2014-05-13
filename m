From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/2] gpio: omap: prepare and unprepare the debounce clock
Date: Tue, 13 May 2014 11:24:24 +0200
Message-ID: <CACRpkdZ2EhKyjg6_txGByN501QiOOQ+N5rvDZDm_jqNRWZxN5g@mail.gmail.com>
References: <1398233465-8845-1-git-send-email-rnayak@ti.com>
	<1398233465-8845-2-git-send-email-rnayak@ti.com>
	<536B2CEE.4010809@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:44915 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759397AbaEMJYY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 May 2014 05:24:24 -0400
Received: by mail-ob0-f182.google.com with SMTP id wn1so66879obc.13
        for <linux-omap@vger.kernel.org>; Tue, 13 May 2014 02:24:24 -0700 (PDT)
In-Reply-To: <536B2CEE.4010809@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, ext Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Alexandre Courbot <gnurou@gmail.com>

On Thu, May 8, 2014 at 9:06 AM, Rajendra Nayak <rnayak@ti.com> wrote:

> Do you mind picking this fix up via the GPIO tree?

Yes, it's merged to my devel branch now with the ACKs.

> Alternatively you could
> Ack this if you are fine and we can take both Patch 1/2 and Patch 2/2 from this
> series via the OMAP tree.

This probably will not work as I have a set of other changes to this
driver in my tree.

> Patch 2/2 has a dependency on Patch 1/2 and they need to go in in that order else
> gpio would break. More discussions are here [1].

Tell me if I should prepare an immutable tag on my branch that you
can pull in. I want an explicit handshake with the platform
maintainer for this kind of stuff.

Yours,
Linus Walleij
