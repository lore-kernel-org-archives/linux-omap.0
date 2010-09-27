From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: Issue : jffs2 and ecc layout
Date: Mon, 27 Sep 2010 17:32:22 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B03560988FC@dbde02.ent.ti.com>
References: <1285394847-29844-1-git-send-email-vapier@gentoo.org>
 <1285570258-17068-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43152 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753549Ab0I0MCa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Sep 2010 08:02:30 -0400
In-Reply-To: <1285570258-17068-1-git-send-email-vapier@gentoo.org>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,
I was using the following ecc layout which is not working to mount the jffs2 File-system. I was using this in 2.6.32 kernel and was working; but same layout is not working with latest 2.6 kernel.

Observation is that - no read request issued to the driver (say omap2.c).

# mount -t jffs2 /dev/mtdblock4 /mnt/nand
[   32.505218] cannot read OOB for EB at 00000000, requested 8 bytes, read 0 bytes, error -22
mount: Mounting /dev/mtdblock4 on /mnt/nand failed: Input/output error

# dmesg 
<3>[   32.505218] cannot read OOB for EB at 00000000, requested 8 bytes, read 0 bytes, error -22

Code:
 178 static struct nand_ecclayout hw_x16_romcode_oob_64 = {
 179         .eccbytes = 12,
 180         .eccpos = {
 181                     2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13
 182                   },
 183         .oobfree = {
 184                         {.offset = 14,
 185                          .length = 50}
 186                    }
 187 };

 1188              info->nand.ecc.layout = &hw_x16_romcode_oob_64;

Regards,
Ghorai


