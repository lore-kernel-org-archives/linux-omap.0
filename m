From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: OMAP5912 boot broken by "gpio/omap: don't create an IRQ mapping
 for every GPIO on DT"
Date: Mon, 29 Jul 2013 13:43:09 +0200
Message-ID: <CACRpkdZ1E9zC_yyK=UkJSejCwb_k7sYfhNgH5NASZ8Nf-qt2KA@mail.gmail.com>
References: <alpine.DEB.2.02.1307290604310.30864@utopia.booyaka.com>
	<CACRpkdYa8Kg_-u3gB8jrB_Ws2EpLCnXBh5UGgDvi_7tQspDP7A@mail.gmail.com>
	<51F633AE.8090308@collabora.co.uk>
	<alpine.DEB.2.02.1307290943000.30864@utopia.booyaka.com>
	<D135FD6D-D4B6-4237-9866-4FFED36C03CD@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:48362 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751735Ab3G2LnK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Jul 2013 07:43:10 -0400
Received: by mail-ob0-f175.google.com with SMTP id xn12so8968566obc.20
        for <linux-omap@vger.kernel.org>; Mon, 29 Jul 2013 04:43:09 -0700 (PDT)
In-Reply-To: <D135FD6D-D4B6-4237-9866-4FFED36C03CD@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Paul Walmsley <paul@pwsan.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Enric Balletbo i Serra <eballetbo@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Grant Likely <grant.likely@secretlab.ca>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@linaro.org>

On Mon, Jul 29, 2013 at 12:19 PM, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:

> I guess the safer approach is to just revert these since they are causing
> a regression and what the patches aims to fix as been broken since the
> initial OMAP migration to DT anyways.

I have already reverted these and pushed to linux-next.

Actually input-hogs was not such a good idea either, after
meditating on this I realized that the information about what
GPIOs are used as interrupts is a piece of information that
already exist in the device tree, albeit a bit distributed.

So I'm drafting an RFC to indicate how I think this should
be solved.

Yours,
Linus Walleij
