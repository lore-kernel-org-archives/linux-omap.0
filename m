From: Vimal Singh <vimal.newwork@gmail.com>
Subject: Re: [PATCH v2] [OMAP3_PM] Fix omap zoom2 defconfig build error
Date: Mon, 2 Nov 2009 17:04:25 +0530
Message-ID: <ce9ab5790911020334n17facc07t87de82683d84a922@mail.gmail.com>
References: <1257160880-13641-1-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:57155 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754335AbZKBLel convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Nov 2009 06:34:41 -0500
Received: by bwz27 with SMTP id 27so6179977bwz.21
        for <linux-omap@vger.kernel.org>; Mon, 02 Nov 2009 03:34:45 -0800 (PST)
In-Reply-To: <1257160880-13641-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: manjugk@ti.com
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, dedekind1@gmail.com, felipe.balbi@nokia.com

On Mon, Nov 2, 2009 at 4:51 PM,  <manjugk@ti.com> wrote:
> From: Manjunatha GK <manjugk@ti.com>
>
> The omap zoom2 defconfig build breaks on linux-omap-pm(with pm branch=
)
> when CONFIG_DEBUG_FS is not enabled. This patch fixes the build issue=
=2E
> Kernel booting tested on omap zoom2 board.
>
> Signed-off-by: Manjunatha GK <manjugk@ti.com>
> ---
> =A0arch/arm/mach-omap2/pm-debug.c | =A0 =A02 ++
> =A01 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-=
debug.c
> index 767ebbc..3a42615 100644
> --- a/arch/arm/mach-omap2/pm-debug.c
> +++ b/arch/arm/mach-omap2/pm-debug.c
> @@ -625,4 +625,6 @@ arch_initcall(pm_dbg_init);
>
> =A0#else
> =A0void pm_dbg_update_time(struct powerdomain *pwrdm, int prev) {}
> +int pm_dbg_regset_init(int reg_set) {}
> +int pm_dbg_regset_save(int reg_set) {}

'return 0' to avoid compilation warning...

--=20
Regards,
Vimal Singh

> =A0#endif
> --
> 1.6.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
