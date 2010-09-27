From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: RE: [PATCH v5 5/5] omap: nand: making ecc layout as compatible with
 romcode ecc
Date: Mon, 27 Sep 2010 19:32:56 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B03560989F6@dbde02.ent.ti.com>
References: <1285594634-19277-1-git-send-email-s-ghorai@ti.com>
 <1285594634-19277-6-git-send-email-s-ghorai@ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB5930233C3631E@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59351 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752978Ab0I0ODO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Sep 2010 10:03:14 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB5930233C3631E@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Vimal Singh <vimalsingh@ti.com>



> -----Original Message-----
> From: Premi, Sanjeev
> Sent: Monday, September 27, 2010 7:29 PM
> To: Ghorai, Sukumar; linux-omap@vger.kernel.org
> Cc: linux-mtd@lists.infradead.org; linux-arm-kernel@lists.infradead.org;
> Ghorai, Sukumar; Vimal Singh
> Subject: RE: [PATCH v5 5/5] omap: nand: making ecc layout as compatible
> with romcode ecc
> 
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org
> > [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Sukumar Ghorai
> > Sent: Monday, September 27, 2010 7:07 PM
> > To: linux-omap@vger.kernel.org
> > Cc: linux-mtd@lists.infradead.org;
> > linux-arm-kernel@lists.infradead.org; Ghorai, Sukumar; Vimal Singh
> > Subject: [PATCH v5 5/5] omap: nand: making ecc layout as
> > compatible with romcode ecc
> >
> >     This patch overrides nand ecc layout and bad block
> > descriptor (for 8-bit
> >     device) to support hw ecc in romcode layout. So as to
> > have in sync with ecc
> >     layout throughout; i.e. x-loader, u-boot and kernel.
> >
> >     This patch also enables to use romcode ecc for spd and
> > zoom, by default.
> >
> >     This enables to flash x-loader, u-boot, kernel, FS images
> > from kernel itself
> >     and compatiable with other tools.
> >
> The description seems to start with different whitespace indents
> in this patch series.
> 
[Ghorai] Thanks. I will RESEND.

> ~sanjeev
> 
> [snip]...[snip]
