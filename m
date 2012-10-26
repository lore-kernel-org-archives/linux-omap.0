From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] gpio/omap: fix off-mode bug: clear debounce clock enable
 mask on disable
Date: Fri, 26 Oct 2012 09:21:32 +0200
Message-ID: <CACRpkdbd=3quRrvOGJrWfH_ExHey7F2wgxp4HsiF9xzdN+O-1Q@mail.gmail.com>
References: <1351015771-6308-1-git-send-email-khilman@deeprootsystems.com>
	<CANOLnOOUHJg5W9VbHhnK8ta+Bys_oMpSz9M5jQ0xCeOB1gxtdg@mail.gmail.com>
	<87pq4854wu.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:45245 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756554Ab2JZHVd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Oct 2012 03:21:33 -0400
Received: by mail-wi0-f172.google.com with SMTP id hq12so158748wib.1
        for <linux-omap@vger.kernel.org>; Fri, 26 Oct 2012 00:21:32 -0700 (PDT)
In-Reply-To: <87pq4854wu.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Igor Grinberg <grinberg@compulab.co.il>, linux-arm-kernel@lists.infradead.org

On Wed, Oct 24, 2012 at 4:19 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:

> Linus, please revert if it's not too late, and I'll come up with a more
> targetted fix.

OK I ditched it, no big deal.

Yours,
Linus Walleij
