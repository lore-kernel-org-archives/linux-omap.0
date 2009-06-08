From: Jean Pihet <jpihet@mvista.com>
Subject: Re: [RFC][PATCH] OMAP3: add support for 2 SDRAM chip selects (was:  Re: Beagleboard rev C memory timings & suspend/resume)
Date: Mon, 8 Jun 2009 19:11:33 +0200
Message-ID: <200906081911.33673.jpihet@mvista.com>
References: <200904291553.49378.jpihet@mvista.com> <200906081102.00779.jpihet@mvista.com> <6ed0b2680906080401g64ed4dbcpa24bbad3841a2b2d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:37714 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750911AbZFHRLe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Jun 2009 13:11:34 -0400
In-Reply-To: <6ed0b2680906080401g64ed4dbcpa24bbad3841a2b2d@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, Paul Walmsley <paul@pwsan.com>, linux-omap <linux-omap@vger.kernel.org>

Hi Kevin,

On Monday 08 June 2009 13:01:18 Grazvydas Ignotas wrote:
> > =A0static void __init omap3pandora_init_irq(void)
> > =A0{
> > - =A0 =A0 =A0 omap2_init_common_hw(mt46h32m32lf6_sdrc_params, NULL,
> > + =A0 =A0 =A0 omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mt46h32m32=
lf6_sdrc_params,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 NULL, NULL,=
 NULL);
>
> Hm, since pandora uses OMAP3530, maybe it should also have
> omap3_*_rate_table args passed? Could also be true for Overo, at leas=
t
> for omap3_mpu_rate_table and omap3_l3_rate_table, as some models use
> OMAP3503 without the DSP.
Which table rates shall we pass for Overo and Pandora?
I will update the patch set with the needed ones.

Regards,
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
