From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/5] gpio/omap: remove extra context restores in *_runtime_resume()
Date: Wed, 10 Apr 2013 21:34:40 +0200
Message-ID: <CACRpkdaR0tL=2uvr+SP4uKW-BPmAHm=mL3rkaD79ELyPhDF1ag@mail.gmail.com>
References: <1365106576-31816-1-git-send-email-jon-hunter@ti.com>
	<1365106576-31816-3-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:57397 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762176Ab3DJTel (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Apr 2013 15:34:41 -0400
Received: by mail-ie0-f181.google.com with SMTP id 17so1053995iea.26
        for <linux-omap@vger.kernel.org>; Wed, 10 Apr 2013 12:34:41 -0700 (PDT)
In-Reply-To: <1365106576-31816-3-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@linaro.org>, device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Tarun Kanti DebBarma <tarun.kanti@ti.com>

On Thu, Apr 4, 2013 at 10:16 PM, Jon Hunter <jon-hunter@ti.com> wrote:

> From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
>
> 68942edb09f69b6e09522d1d346665eb3aadde49 (gpio/omap: fix wakeups
> on level-triggered GPIOs) already restores the fallingdetect and
> risingdetect contexts in *_runtime_resume(). These registers were
> modified in *_runtime_suspend() to include even those configured
> as level-triggered since only edge-triggered gpios can generate
> wakeup events. Therefore, the old context restores of the same
> registers present later in the code is not needed any more.
> Remove them.
>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>

Patch applied unless somebody complains.

Yours,
Linus Walleij
