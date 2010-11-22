From: Grant Erickson <marathon96@gmail.com>
Subject: Re: No more software ECC in omap2.c NAND driver. Why?
Date: Sun, 21 Nov 2010 22:08:52 -0800
Message-ID: <C90F48F4.2031A%marathon96@gmail.com>
References: <201011221001.22909.manningc2@actrix.gen.nz>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:33991 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750792Ab0KVGJH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Nov 2010 01:09:07 -0500
Received: by pwj1 with SMTP id 1so1069247pwj.19
        for <linux-omap@vger.kernel.org>; Sun, 21 Nov 2010 22:09:06 -0800 (PST)
In-Reply-To: <201011221001.22909.manningc2@actrix.gen.nz>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Charles Manning <manningc2@actrix.gen.nz>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Grazvydas Ignotas <notasas@gmail.com>, "Ghorai, Sukumar" <s-ghorai@ti.com>

On 11/21/10 1:01 PM, Charles Manning wrote:
> Just recompiling with the CONFIG_MTD_NAND_OMAP_HWECC define commented out did
> not result in a working system. I suspect there is more tto the problem than
> this.

FWIW, I had the exact same issues with my Mistral AM37x EVM board. I not
only had to remove/deassert CONFIG_MTD_NAND_OMAP_HWECC, but also had to roll
back nand_base.c and nand_bbt.c back to their 2.6.32 versions (later ones
between .32 and .35 might have worked but I didn't bother trying) to be able
to read, error-free and correctly, NAND that was erased and written with a
.32-era kernel.

Best,

Grant Erickson


