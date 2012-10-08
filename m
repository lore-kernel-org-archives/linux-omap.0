From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] gpio/gpio-omap: Use existing pointer to struct device
Date: Mon, 8 Oct 2012 20:55:37 +0200
Message-ID: <CACRpkdZhT_SMLtP-hG3pJt6DzXi5Qe4=CPQW3TRsPStpQo0aSA@mail.gmail.com>
References: <1349429858-17943-1-git-send-email-tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:53007 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753088Ab2JHSzi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Oct 2012 14:55:38 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so4005291wgb.1
        for <linux-omap@vger.kernel.org>; Mon, 08 Oct 2012 11:55:37 -0700 (PDT)
In-Reply-To: <1349429858-17943-1-git-send-email-tklauser@distanz.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@ti.com>, Grant Likely <grant.likely@secretlab.ca>, linux-omap@vger.kernel.org

On Fri, Oct 5, 2012 at 11:37 AM, Tobias Klauser <tklauser@distanz.ch> wrote:

> A pointer to "pdev->dev" is already stored in "dev", so use it in
> devm_kzalloc.
>
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

Applied with Kevin's ACK, thanks!

Yours,
Linus Walleij
