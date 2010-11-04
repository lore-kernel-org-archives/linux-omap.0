From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: RE: [PATCH RESEND v5 4/5] omap: nand: ecc layout select from board
 file
Date: Thu, 4 Nov 2010 16:45:14 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B0356BAC331@dbde02.ent.ti.com>
References: <1285596710-25658-1-git-send-email-s-ghorai@ti.com>
	<1285596710-25658-5-git-send-email-s-ghorai@ti.com>
	<AANLkTikKMnzHR5DZqzGdJJbnCXhCpxKA7K2C2ZtPhNke@mail.gmail.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B0356BABFAE@dbde02.ent.ti.com>
	<AANLkTinOhBNUt+gvNb0MWiyHD8ZYgLDJPz8tc=p+CsVW@mail.gmail.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B0356BAC2B6@dbde02.ent.ti.com>
	<AANLkTinNrZNuZnFfJKGLF9J3zsHsOTK0+VmUmYH88+c3@mail.gmail.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B0356BAC323@dbde02.ent.ti.com>
 <AANLkTik3gO1Rm2U8-Rm2t2M83sdCjz_Oktpve_gDrbNM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58024 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755185Ab0KDLP0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Nov 2010 07:15:26 -0400
In-Reply-To: <AANLkTik3gO1Rm2U8-Rm2t2M83sdCjz_Oktpve_gDrbNM@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Artem.Bityutskiy@nokia.com" <Artem.Bityutskiy@nokia.com>, Vimal Singh <vimal.newwork@gmail.com>, Tony Lindgren <tony@atomide.com>



> -----Original Message-----
> From: Grazvydas Ignotas [mailto:notasas@gmail.com]
> Sent: Thursday, November 04, 2010 4:42 PM
> To: Ghorai, Sukumar
> Cc: linux-omap@vger.kernel.org; linux-mtd@lists.infradead.org; linux-arm-
> kernel@lists.infradead.org; Artem.Bityutskiy@nokia.com; Vimal Singh; Tony
> Lindgren
> Subject: Re: [PATCH RESEND v5 4/5] omap: nand: ecc layout select from
> board file
> 
> > [Ghorai] In 2.6.36, it's a s/w ecc by default and working in all
> platforms like - omap3430 SDP, zoom2, 3630SDP, ZOOM3.
> > So please explain more when you found that - sw ecc is broken on both
> 2.6.36
> 
> It doesn't for me, see
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-
> 2.6.git;a=blob;f=drivers/mtd/nand/omap2.c;h=513e0a76a4a73866d52bba8151e435
> 56a3b30a54;hb=f6f94e2ab1b33f0082ac22d71f66385a60d8157f
> 
> This is omap NAND driver at v2.6.36 tag, and it has
> CONFIG_MTD_NAND_OMAP_HWECC forced.

[Ghorai] This is the same old code since log. And this portion of code not touched for 2.6.36.
And please let me know what kind of problem you are facing when you using 2.6.36; also let me know how to reproduce, I can check in my platform too.

