From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: PM related performance degradation on OMAP3
Date: Thu, 12 Apr 2012 23:02:36 +0000
Message-ID: <EF62F09C0797D947AD4180A1043C0DF73C3C2D1C@DLEE10.ent.ti.com>
References: <CANOLnOP5gq4Vtt00SgRNW-3GZDWk0sukBgJx4V6rkMLL+b6G-w@mail.gmail.com>
	<877gxobudk.fsf@ti.com>
 <CANOLnOPbHBshCdbmSOjYdubWqUivrVpR-+eaayu=v4Yy6yKdsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55826 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755234Ab2DLXCj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Apr 2012 19:02:39 -0400
In-Reply-To: <CANOLnOPbHBshCdbmSOjYdubWqUivrVpR-+eaayu=v4Yy6yKdsQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>, "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>

> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Grazvydas Ignotas
> Sent: Tuesday, April 10, 2012 7:30 PM

> What I think is going on here is that omap_sram_idle() is taking too
> much time because it's overhead is too large. I've added a counter
> there and it seems to be called ~530 times per megabyte (DMA operates
> in ~2K chunks so it makes sense), that's over 2000 calls per second.
> Some quick measurement code shows ~243us spent for setting up in
> omap_sram_idle() (before and after omap34xx_do_sram_idle()).

243uS is really a long time for C1. For some reason has grown a lot since last time I captured path in ETM.

Your analysis correlates well to reports from a couple years back. N900 folks did report that the non-clock gated C1 was needed (as exists in code today). IIRC the NAND stack did have small-uS spins on NAND status or something which having higher clock stop penalty resulted in big performance dip. You needed like <10uS for C1 or bit hit.

Regards,
Richard W.
