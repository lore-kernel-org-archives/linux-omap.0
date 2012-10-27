From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v5] gpio/omap: fix off-mode bug: clear debounce settings
 on free/reset
Date: Sat, 27 Oct 2012 18:28:09 +0200
Message-ID: <CACRpkdbaRxQcXk3djc3kxHt+-xu-zKz4yZX6QLFfGjAhRkELeQ@mail.gmail.com>
References: <1351279564-4591-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:44623 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756653Ab2J0Q2K (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 27 Oct 2012 12:28:10 -0400
Received: by mail-ee0-f46.google.com with SMTP id b15so1481965eek.19
        for <linux-omap@vger.kernel.org>; Sat, 27 Oct 2012 09:28:09 -0700 (PDT)
In-Reply-To: <1351279564-4591-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>, Igor Grinberg <grinberg@compulab.co.il>, Grazvydas Ignotas <notasas@gmail.com>

On Fri, Oct 26, 2012 at 9:26 PM, Jon Hunter <jon-hunter@ti.com> wrote:

> This change was originally titled "gpio/omap: fix off-mode bug: clear debounce
> clock enable mask on free/reset". The title has been updated slightly to
> reflect (what should be) the final fix.
>
> When a GPIO is freed or shutdown, we need to ensure that any debounce settings
> are cleared and if the GPIO is the only GPIO in the bank that is currently
> using debounce, then disable the debounce clock as well to save power.
>
> Currently, the debounce settings are not cleared on a GPIO free or shutdown and
> so during a context restore on subsequent off-mode transition, the previous
> debounce values are restored from the shadow copies (bank->context.debounce*)
> leading to mismatch state between driver state and hardware state.
>
> This was discovered when board code was doing
>
>   gpio_request_one()
>   gpio_set_debounce()
>   gpio_free()
>
> which was leaving the GPIO debounce settings in a confused state.  If that GPIO
> bank is subsequently used with off-mode enabled, bogus state would be restored,
> leaving GPIO debounce enabled which then prevented the CORE powerdomain from
> transitioning.
>
> To fix this, introduce a new function called _clear_gpio_debounce() to clear
> any debounce settings when the GPIO is freed or shutdown. If this GPIO is the
> last debounce-enabled GPIO in the bank, the debounce will also be cut.
>
> Please note that we cannot use _gpio_dbck_disable() to disable the debounce
> clock because this has been specifically created for the gpio suspend path
> and is intended to shutdown the debounce clock while debounce is enabled.
>
> Special thanks to Kevin Hilman for root causing the bug. This fix is a
> collaborative effort with inputs from Kevin Hilman, Grazvydas Ignotas and
> Santosh Shilimkar.
>
> Testing:
> - This has been unit tested on an OMAP3430 Beagle board, by requesting a gpio,
>   enabling debounce and then freeing the gpio and checking the register
>   contents, the saved register context and the debounce clock state.
> - Kevin Hilman tested on 37xx/EVM board which configures GPIO debounce for the
>   ads7846 touchscreen in its board file using the above sequence, and so was
>   failing off-mode tests in dynamic idle. Verified that off-mode tests are
>   passing with this patch.
>
> V5 changes:
> - Corrected author
>
> Reported-by: Paul Walmsley <paul@pwsan.com>
> Cc: Igor Grinberg <grinberg@compulab.co.il>
> Cc: Grazvydas Ignotas <notasas@gmail.com>
> Cc: Jon Hunter <jon-hunter@ti.com>
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> Reviewed-by: Kevin Hilman <khilman@ti.com>
> Tested-by: Kevin Hilman <khilman@ti.com>
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Hey there is a version I requested, with ACKs and all.

You must be reading my mind :-D

OK patch applied for fixes.

Yours,
Linus Walleij
