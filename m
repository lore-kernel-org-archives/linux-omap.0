From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/2] gpio/omap: add *remove* callback in platform_driver
Date: Wed, 11 Jul 2012 23:54:23 +0200
Message-ID: <CACRpkdYxE7rj8HHAy3+HbQHW4+WbqK2suggfBqKX=TbhHzraDg@mail.gmail.com>
References: <1341997995-14020-1-git-send-email-tarun.kanti@ti.com>
	<1341997995-14020-3-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:61858 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754682Ab2GKVyY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Jul 2012 17:54:24 -0400
Received: by qadb17 with SMTP id b17so3469542qad.19
        for <linux-omap@vger.kernel.org>; Wed, 11 Jul 2012 14:54:23 -0700 (PDT)
In-Reply-To: <1341997995-14020-3-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Kevin Hilman <khilman@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

On Wed, Jul 11, 2012 at 11:13 AM, Tarun Kanti DebBarma
<tarun.kanti@ti.com> wrote:

> Add *remove* callback so that necessary cleanup operations are
> performed when device is unregistered. The device is deleted
> from the list and associated clock handle is released by
> calling clk_put() and irq descriptor is released using the
> irq_free_desc() api.
>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>

Looks good, applied.

Yours,
Linus Walleij
