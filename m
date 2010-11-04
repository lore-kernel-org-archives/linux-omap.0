From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH RESEND v5 4/5] omap: nand: ecc layout select from board file
Date: Thu, 4 Nov 2010 13:11:50 +0200
Message-ID: <AANLkTik3gO1Rm2U8-Rm2t2M83sdCjz_Oktpve_gDrbNM@mail.gmail.com>
References: <1285596710-25658-1-git-send-email-s-ghorai@ti.com>
	<1285596710-25658-5-git-send-email-s-ghorai@ti.com>
	<AANLkTikKMnzHR5DZqzGdJJbnCXhCpxKA7K2C2ZtPhNke@mail.gmail.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B0356BABFAE@dbde02.ent.ti.com>
	<AANLkTinOhBNUt+gvNb0MWiyHD8ZYgLDJPz8tc=p+CsVW@mail.gmail.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B0356BAC2B6@dbde02.ent.ti.com>
	<AANLkTinNrZNuZnFfJKGLF9J3zsHsOTK0+VmUmYH88+c3@mail.gmail.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B0356BAC323@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:53540 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753330Ab0KDLLv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Nov 2010 07:11:51 -0400
Received: by qyk12 with SMTP id 12so1283881qyk.19
        for <linux-omap@vger.kernel.org>; Thu, 04 Nov 2010 04:11:50 -0700 (PDT)
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B0356BAC323@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ghorai, Sukumar" <s-ghorai@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Artem.Bityutskiy@nokia.com" <Artem.Bityutskiy@nokia.com>, Vimal Singh <vimal.newwork@gmail.com>, Tony Lindgren <tony@atomide.com>

> [Ghorai] In 2.6.36, it's a s/w ecc by default and working in all platforms like - omap3430 SDP, zoom2, 3630SDP, ZOOM3.
> So please explain more when you found that - sw ecc is broken on both 2.6.36

It doesn't for me, see
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=drivers/mtd/nand/omap2.c;h=513e0a76a4a73866d52bba8151e43556a3b30a54;hb=f6f94e2ab1b33f0082ac22d71f66385a60d8157f

This is omap NAND driver at v2.6.36 tag, and it has
CONFIG_MTD_NAND_OMAP_HWECC forced.
