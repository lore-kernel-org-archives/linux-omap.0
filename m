From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH 3/9] omap: generic: introduce a single check_revision
Date: Fri, 25 Jun 2010 12:31:15 +0300
Message-ID: <AANLkTikivRbnADYMUJtzAEbjQt6yCNJLvq66tTIfcmnK@mail.gmail.com>
References: <1277259375-18521-1-git-send-email-nm@ti.com>
	<1277259375-18521-4-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48124 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753750Ab0FYJbR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Jun 2010 05:31:17 -0400
Received: by bwz7 with SMTP id 7so602051bwz.19
        for <linux-omap@vger.kernel.org>; Fri, 25 Jun 2010 02:31:16 -0700 (PDT)
In-Reply-To: <1277259375-18521-4-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

On Wed, Jun 23, 2010 at 5:16 AM, Nishanth Menon <nm@ti.com> wrote:
> Introduce a single omap generic check_revision that routes the
> request to the right revision of check_revision.
>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Angelo Arrifano <miknix@gmail.com>
> Cc: "Zebediah C. McClure" <zmc@lurian.net>
> Cc: Alistair Buxton <a.j.buxton@gmail.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Sanjeev Premi <premi@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Senthilvadivu Gurusamy <svadivu@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> Cc: Aaro Koskinen <aaro.koskinen@nokia.com>
> Cc: Vikram Pandita <vikram.pandita@ti.com>
> Cc: Vishwanath S <vishwa.s@ti.com>
> Cc: linux-omap@vger.kernel.org
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> =A0arch/arm/mach-omap1/io.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A03 +--
> =A0arch/arm/mach-omap2/io.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02 +-
> =A0arch/arm/plat-omap/common.c =A0 =A0 =A0 =A0 =A0 | =A0 12 +++++++++=
+++
> =A0arch/arm/plat-omap/include/plat/cpu.h | =A0 13 ++++++++++++-
> =A04 files changed, 26 insertions(+), 4 deletions(-)
>

<snip>

> diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.=
c
> index fca73cd..538e170 100644
> --- a/arch/arm/plat-omap/common.c
> +++ b/arch/arm/plat-omap/common.c
> @@ -89,6 +89,18 @@ void __init omap_reserve(void)
> =A0 =A0 =A0 =A0omap_vram_reserve_sdram_lmb();
> =A0}
>
> +void __init omap_check_revision()

minor nitpick:
void __init omap_check_revision(void)?
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
