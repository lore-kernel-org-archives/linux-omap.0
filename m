From: Vimal Singh <vimal.newwork@gmail.com>
Subject: Re: [PATCH v2] ARM: omap2: mtd split nand_scan in ident and tail
Date: Mon, 18 Apr 2011 12:29:47 +0530
Message-ID: <BANLkTimxgyStkfYXyHJUzQBKTR0pYsF7Qw@mail.gmail.com>
References: <1302876214.3220.62.camel@localhost> <1303109438-24309-1-git-send-email-j.weitzel@phytec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:63877 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752602Ab1DRHAI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Apr 2011 03:00:08 -0400
Received: by wwa36 with SMTP id 36so5251391wwa.1
        for <linux-omap@vger.kernel.org>; Mon, 18 Apr 2011 00:00:07 -0700 (PDT)
In-Reply-To: <1303109438-24309-1-git-send-email-j.weitzel@phytec.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jan Weitzel <j.weitzel@phytec.de>
Cc: linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, Artem.Bityutskiy@nokia.com, s.hauer@pengutronix.de, dwmw2@infradead.org, tony@atomide.com, s-ghorai@ti.com, vimalsingh@ti.com

On Mon, Apr 18, 2011 at 12:20 PM, Jan Weitzel <j.weitzel@phytec.de> wrote:
> nand_scan calls nand_scan_tail and here we got a ecc.layout and calculate
> oobavail for this layout. After calling nand_scan, we change the layout pointer
> if OMAP_ECC_HAMMING_CODE_HW_ROMCODE is set. This results in not calcluated
> oobavail. Mountig as jffs2 is not possible.
>
> To fix that nand_scan has to split up in nand_scan_ident and nand_scan_tail
> setting ecc.layout between these calls. So nand_scan_tail calculates oobvail
> for the used layout. This is also done in serveral other platforms.
>
> v2:
> update commit message
Move above two lines to below (as there are not part of commit log):

>
> Signed-off-by: Jan Weitzel <j.weitzel@phytec.de>
> ---
here.

Feel free to add:
Reviewed-by: Vimal Singh <vimal.newwork@gmail.com>

Regards,
Vimal
