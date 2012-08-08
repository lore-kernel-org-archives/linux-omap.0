From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH 1/2] ARM: pgtable: add pgprot_writethrough() macro
Date: Wed, 8 Aug 2012 14:07:55 +0300
Message-ID: <CANOLnOMTFLMNidjyML5XFF3Wz4oXWCnRH1WCqvFD7FqOgO20Sg@mail.gmail.com>
References: <1337716444-30139-1-git-send-email-siarhei.siamashka@gmail.com>
	<1337716444-30139-2-git-send-email-siarhei.siamashka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:63138 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751967Ab2HHLH4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Aug 2012 07:07:56 -0400
In-Reply-To: <1337716444-30139-2-git-send-email-siarhei.siamashka@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Siarhei Siamashka <siarhei.siamashka@gmail.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, tomi.valkeinen@ti.com

On Tue, May 22, 2012 at 10:54 PM, Siarhei Siamashka
<siarhei.siamashka@gmail.com> wrote:
> Needed for remapping pages with write-through cacheable
> attribute. May be useful for framebuffers.

With this series applied, some of my framebuffer programs get over 70%
performance improvement, could we get this patch in? OMAP DSS
maintainer agreed to take the second patch if this can be merged.

> Signed-off-by: Siarhei Siamashka <siarhei.siamashka@gmail.com>
> ---
>  arch/arm/include/asm/pgtable.h |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pg=
table.h
> index f66626d..04297fa 100644
> --- a/arch/arm/include/asm/pgtable.h
> +++ b/arch/arm/include/asm/pgtable.h
> @@ -103,6 +103,9 @@ extern pgprot_t             pgprot_kernel;
>  #define pgprot_stronglyordered(prot) \
>         __pgprot_modify(prot, L_PTE_MT_MASK, L_PTE_MT_UNCACHED)
>
> +#define pgprot_writethrough(prot) \
> +       __pgprot_modify(prot, L_PTE_MT_MASK, L_PTE_MT_WRITETHROUGH)
> +
>  #ifdef CONFIG_ARM_DMA_MEM_BUFFERABLE
>  #define pgprot_dmacoherent(prot) \
>         __pgprot_modify(prot, L_PTE_MT_MASK, L_PTE_MT_BUFFERABLE | L_=
PTE_XN)
> --
> 1.7.3.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
