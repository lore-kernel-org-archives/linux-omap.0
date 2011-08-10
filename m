From: Maxin B John <maxin.john@gmail.com>
Subject: Re: [PATCH] arch:arm:plat-omap:iovmm: remove unused variable 'va'
Date: Wed, 10 Aug 2011 14:12:11 +0300
Message-ID: <CAMhs6YwHbFknDpOg9e_5XcB-X9qo+DXX3tAaQy5xQopepeKOxw@mail.gmail.com>
References: <20110808101546.GA25572@maxin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:57884 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752853Ab1HJLMO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Aug 2011 07:12:14 -0400
In-Reply-To: <20110808101546.GA25572@maxin>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

ping.

On Mon, Aug 8, 2011 at 1:15 PM, Maxin B. John <maxin.john@gmail.com> wr=
ote:
> The pointer "va" returned from "phys_to_virt(pa)" is never used in
> "sgtable_fill_kmalloc()".So,it is safe to remove this set-but-unused =
variable.
>
> Signed-off-by: Maxin B. John <maxin.john@gmail.com>
> ---
> diff --git a/arch/arm/plat-omap/iovmm.c b/arch/arm/plat-omap/iovmm.c
> index c60737c..79e7fed 100644
> --- a/arch/arm/plat-omap/iovmm.c
> +++ b/arch/arm/plat-omap/iovmm.c
> @@ -423,9 +423,6 @@ static void sgtable_fill_kmalloc(struct sg_table =
*sgt, u32 pa, u32 da,
> =A0{
> =A0 =A0 =A0 =A0unsigned int i;
> =A0 =A0 =A0 =A0struct scatterlist *sg;
> - =A0 =A0 =A0 void *va;
> -
> - =A0 =A0 =A0 va =3D phys_to_virt(pa);
>
> =A0 =A0 =A0 =A0for_each_sg(sgt->sgl, sg, sgt->nents, i) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned bytes;
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
