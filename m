From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH 4/13] dmtimer: hwmod: OMAP: api to read omap_hwmod _clk
Date: Tue, 24 Aug 2010 14:14:49 +0300
Message-ID: <AANLkTinQAmx8vv6fwEZOaCRTHCRDFsYjUb362fyJScK1@mail.gmail.com>
References: <1281800283-15185-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:38227 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751351Ab0HXLOu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Aug 2010 07:14:50 -0400
Received: by qwh6 with SMTP id 6so5962354qwh.19
        for <linux-omap@vger.kernel.org>; Tue, 24 Aug 2010 04:14:49 -0700 (PDT)
In-Reply-To: <1281800283-15185-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, Partha Basak <p-basak2@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Thara Gopinath <thara@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>

On Sat, Aug 14, 2010 at 6:38 PM, Tarun Kanti DebBarma
<tarun.kanti@ti.com> wrote:
> This patch adds the omap_hwmod_get_clk() to access the _clk
> field needed while setting clock sources of the timers.
>
> Signed-off-by: Partha Basak <p-basak2@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Thara Gopinath <thara@ti.com>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Tony Lindgren <tony@atomide.com>
> ---
> =A0arch/arm/mach-omap2/omap_hwmod.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 21 =
+++++++++++++++++++++
> =A0arch/arm/plat-omap/include/plat/omap_hwmod.h | =A0 =A01 +
> =A02 files changed, 22 insertions(+), 0 deletions(-)
> =A0mode change 100644 =3D> 100755 arch/arm/mach-omap2/omap_hwmod.c
> =A0mode change 100644 =3D> 100755 arch/arm/plat-omap/include/plat/oma=
p_hwmod.h

watch out for the mode changes..
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
