From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP2xxx: move SRAM to fix boot hang
Date: Fri, 10 Oct 2008 14:24:58 +0300
Message-ID: <20081010112457.GR3044@atomide.com>
References: <20081009232100.13509.6688.stgit@localhost.localdomain> <20081009232106.13509.80699.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:49174 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753810AbYJJLZE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Oct 2008 07:25:04 -0400
Content-Disposition: inline
In-Reply-To: <20081009232106.13509.80699.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, Jarkko Nikula <jarkko.nikula@nokia.com>, =?iso-8859-1?Q?M=E5nsRullg=E5rd?= <mans@mansr.com>

* Paul Walmsley <paul@pwsan.com> [081010 02:23]:
> Commit 1c957036bbd912322793da676d05e169abf24782 breaks booting on
> OMAP2; it causes the SRAM to be mapped on top of the L4 interconnect.
> This causes the system to hang early in boot in omap_map_sram() durin=
g
> the TLB flush. Fix by moving SRAM elsewhere in the memory map.
>=20
> Reported by Jarkko Nikula <jarkko.nikula@nokia.com>.  This patch is a
> collaboration with Tony Lindgren <tony@atomide.com> and
> Kevin Hilman <khilman@deeprootsystems.com>.
>=20
> Boot-tested on 2430SDP (by Paul) and N810 (by Jarkko).

Pushing.

Tony

> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Tested-by: Jarkko Nikula <jarkko.nikula@nokia.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: M=E5ns Rullg=E5rd <mans@mansr.com>
> ---
>  arch/arm/plat-omap/sram.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
> index 853048d..027b101 100644
> --- a/arch/arm/plat-omap/sram.c
> +++ b/arch/arm/plat-omap/sram.c
> @@ -37,8 +37,8 @@
>  #define OMAP1_SRAM_VA		VMALLOC_END
>  #define OMAP2_SRAM_PA		0x40200000
>  #define OMAP2_SRAM_PUB_PA	0x4020f800
> -#define OMAP2_SRAM_VA		VMALLOC_END
> -#define OMAP2_SRAM_PUB_VA	(VMALLOC_END + 0x800)
> +#define OMAP2_SRAM_VA		0xe3000000
> +#define OMAP2_SRAM_PUB_VA	(OMAP2_SRAM_VA + 0x800)
>  #define OMAP3_SRAM_PA           0x40200000
>  #define OMAP3_SRAM_VA           0xd7000000
>  #define OMAP3_SRAM_PUB_PA       0x40208000
>=20
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
