From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] gpio/gpio-omap: Use existing pointer to struct device
Date: Fri, 05 Oct 2012 12:05:44 -0700
Message-ID: <87ehlcsprr.fsf@deeprootsystems.com>
References: <1349429858-17943-1-git-send-email-tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:33710 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988Ab2JETFk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Oct 2012 15:05:40 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so2172733pbb.19
        for <linux-omap@vger.kernel.org>; Fri, 05 Oct 2012 12:05:39 -0700 (PDT)
In-Reply-To: <1349429858-17943-1-git-send-email-tklauser@distanz.ch> (Tobias
	Klauser's message of "Fri, 5 Oct 2012 11:37:38 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@linaro.org>, linux-omap@vger.kernel.org

Tobias Klauser <tklauser@distanz.ch> writes:

> A pointer to "pdev->dev" is already stored in "dev", so use it in
> devm_kzalloc.
>
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

Acked-by: Kevin Hilman <khilman@ti.com>
