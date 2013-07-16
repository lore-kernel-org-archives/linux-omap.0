From: avinash philip <avinashphilipk@gmail.com>
Subject: Re: [PATCH v1 1/5] mtd: nand: omap: optimized chip->ecc.correct() for
 H/W ECC schemes
Date: Tue, 16 Jul 2013 12:16:36 +0530
Message-ID: <CAGBQFKSqcDmJcdgLWdtxZmgjmjMnLgJXUARSu0NgNVpUGSRa7g@mail.gmail.com>
References: <1373900152-26885-1-git-send-email-pekon@ti.com>
	<1373900152-26885-2-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:51460 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751695Ab3GPGqi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Jul 2013 02:46:38 -0400
Received: by mail-wg0-f42.google.com with SMTP id z11so3307122wgg.5
        for <linux-omap@vger.kernel.org>; Mon, 15 Jul 2013 23:46:36 -0700 (PDT)
In-Reply-To: <1373900152-26885-2-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pekon Gupta <pekon@ti.com>
Cc: dedekind1@gmail.com, dwmw2@infradead.org, arnd@arndb.de, tony@atomide.com, benoit.cousson@linaro.org, balbi@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org

Hi Pekon,

On Mon, Jul 15, 2013 at 8:25 PM, Pekon Gupta <pekon@ti.com> wrote:
> chip->ecc.correct() is used for detecting and correcting bit-flips during read
> operations. In omap2-nand driver this is done usingt following functions:
>
> - omap_correct_data(): for H/W based HAM1_ECC schemes
>         (Un-Touched in current patch)
>
> - omap_elm_correct_data(): for H/W based BCHx_ECC scheme
>         Current implementation of this function is not scalable for newer ECC
>         schemes because:
>         - It depends on a specific byte-position in OOB area (reserved as 0x00)
>           to differentiates between programmed-pages and erased-pages.
>           This reserved byte-position cannot be accomodated in all ECC schemes.
>         - Current code is not scalable for future ECC schemes due to tweaks for
>           BCH4_ECC and BCH8_ECC at multiple places.
>         - It checks for bit-flips in Erased-pages using check_erased_page().
>           This is over-work, as sanity of Erased-page can be verified by just
>           comparing them to a pre-defined ECC-syndrome for all_0xFF data.

This is correct if the erased page read back didn't have any bit flips.
If erased page result in bit flips, then this method will end up in
un-correctable
error. Can you please confirm you taken care erased page bit flips in this
modification?

I think below discussion would help.

https://lkml.org/lkml/2012/11/22/590

Thanks
Avinash
