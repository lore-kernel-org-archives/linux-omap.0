From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCHv3 7/8] mailbox/omap: add code to support the wkupm3 operations
Date: Mon, 26 Aug 2013 20:50:43 -0700
Message-ID: <87li3n6bcc.fsf@linaro.org>
References: <1375825238-18299-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:65077 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752456Ab3H0Dur (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Aug 2013 23:50:47 -0400
Received: by mail-pd0-f177.google.com with SMTP id y10so4260190pdj.8
        for <linux-omap@vger.kernel.org>; Mon, 26 Aug 2013 20:50:46 -0700 (PDT)
In-Reply-To: <1375825238-18299-1-git-send-email-s-anna@ti.com> (Suman Anna's
	message of "Tue, 6 Aug 2013 16:40:38 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Benoit Cousson <benoit.cousson@linaro.org>, Paul Walmsley <paul@pwsan.com>, Ohad Ben-Cohen <ohad@wizery.com>, Jassi Brar <jaswinder.singh@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Suman Anna <s-anna@ti.com> writes:

> The WkupM3 mailbox used for triggering PM operations such as suspend
> and resume on AM33x/AM43x is special in that the M3 processor cannot
> access the mailbox registers. However, an interrupt is needed to be
> sent to request the M3 to perform a desired PM operation. This patch
> adds the support for this special mailbox through separate ops for
> this mailbox. These ops are designed to have the WkupM3's Rx interrupt
> programmed within the driver, during transmission of a message. The
> message is immediately read back and the internal mailbox interrupt
> acknowledged as well to avoid triggering any spurious interrupts to
> the M3.
>
> Signed-off-by: Suman Anna <s-anna@ti.com>

Dumb Q: why does all this extra logic belong in the mailbox driver and
not in the wkup_m3 driver?  To me, this seems like part of the IPC
protocol between the MPU and M3 firmware, and not an inherent part of
the AM33xx mbox.

Kevin
