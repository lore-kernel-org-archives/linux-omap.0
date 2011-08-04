From: Arno Steffen <arno.steffen@googlemail.com>
Subject: [Q] SW-ECC to HW-ECC (OMAP3)
Date: Thu, 4 Aug 2011 12:55:20 +0200
Message-ID: <CAACX+R3Gve=V4+AV17WONEkXpb9NwrLbUr7E2Ym6Qu-2URyiTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:40658 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752287Ab1HDKzU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Aug 2011 06:55:20 -0400
Received: by pzk37 with SMTP id 37so1853170pzk.1
        for <linux-omap@vger.kernel.org>; Thu, 04 Aug 2011 03:55:20 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

While migrating from .33 to .37 kernel I found, that HW-ECC is used by default.
I found that this is set in omap2.c:
	pdata->ecc_opt		= OMAP_ECC_HAMMING_CODE_HW;
Unfortunatly setting it back to
	pdata->ecc_opt		= OMAP_ECC_HAMMING_CODE_DEFAULT;
doesn't prevent me from getting messages like:

uncorrectable error :
uncorrectable error :
mtd->read(0xd18 bytes from 0x7eae8) returned ECC error

So what else has to be set? I couldn't found it.

Other way maybe to keep it at HW-ECC. Is this significant faster than SW-ECC?
But howto get nandwrite (mtd-utils) or fw_setenv (uboot) to handle HW-ECC?
Do I have to use just the --noecc option?

When using the fw_setenv command I get CRC errors in environment with next boot.

Thanks
Arno
