From: Arno Steffen <arno.steffen@googlemail.com>
Subject: Bug in omap mtd nand driver
Date: Thu, 26 Aug 2010 10:55:17 +0200
Message-ID: <AANLkTi=O0S-NWKQqXf3=NC4n_j-Sq91GeNJrWxAhJc7_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40263 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753246Ab0HZIzS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Aug 2010 04:55:18 -0400
Received: by iwn5 with SMTP id 5so1404666iwn.19
        for <linux-omap@vger.kernel.org>; Thu, 26 Aug 2010 01:55:17 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org

The setting NAND_NO_SUBPAGE_WRITE in omap_nand_platform_data is not used.
I am using SLC NAND - MT29F1G16ABC , which seems not to support subpages.
I can observe that kernel allows sub-page-writes.
I tried to find out what is happend with the options, but after a
while I get lost in numerous copies of structs ...

Options are still correct in beginning of omap_nand_probe but finally
it ends up in setting its option independent from platform options.
	info->nand.options  |= NAND_SKIP_BBTSCAN;
	if ((gpmc_cs_read_reg(info->gpmc_cs, GPMC_CS_CONFIG1) & 0x3000)
								== 0x1000)
		info->nand.options  |= NAND_BUSWIDTH_16;

This observations are done in a plain vanilla 2.6.33 kernel on an OMAP3 board.

Can someone confirm that and know how to change that in a clean way?
