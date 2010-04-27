From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH] OMAP: DSS: ensure clocks are disabled on failed init
Date: Tue, 27 Apr 2010 12:14:19 +0300
Message-ID: <p2x6ed0b2681004270214yc64459e4g2e0d15dcac84bd2@mail.gmail.com>
References: <1272309166-698-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:53667 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753291Ab0D0JOV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Apr 2010 05:14:21 -0400
Received: by bwz19 with SMTP id 19so14277bwz.21
        for <linux-omap@vger.kernel.org>; Tue, 27 Apr 2010 02:14:19 -0700 (PDT)
In-Reply-To: <1272309166-698-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@nokia.com>

CC Tomi in case he missed this.

On Mon, Apr 26, 2010 at 10:12 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Currently, if init fails for whatever reason, various DSS related
> clocks will be left enabled and prevent the chip from hitting
> retention or off-mode.
>
> This patch ensures the clocks are disabled on a failed init.
>
> For this to work, a check had to be added to dispc_save_context()
> to not save context if it has not yet been initialized.
>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> ---
> Patch against v2.6.34-rc5.
>
> Discovered when testing n900 with current PM branch + Roger's
> series for the LCC panel. =A0DPI init fails since it can't find
> VDDS_DSI regulator, and as a result init fails out and leaves
> clocks enabled.
>
> =A0drivers/video/omap2/dss/core.c =A0| =A0 =A01 +
> =A0drivers/video/omap2/dss/dispc.c | =A0 =A03 +++
> =A02 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss=
/core.c
> index 7ebe50b..62f7ee2 100644
> --- a/drivers/video/omap2/dss/core.c
> +++ b/drivers/video/omap2/dss/core.c
> @@ -584,6 +584,7 @@ static int omap_dss_probe(struct platform_device =
*pdev)
>
> =A0 =A0 =A0 =A0/* XXX fail correctly */
> =A0fail0:
> + =A0 =A0 =A0 dss_clk_disable_all();
> =A0 =A0 =A0 =A0return r;
> =A0}
>
> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/ds=
s/dispc.c
> index e777e35..4cc54ef 100644
> --- a/drivers/video/omap2/dss/dispc.c
> +++ b/drivers/video/omap2/dss/dispc.c
> @@ -195,6 +195,9 @@ void dispc_save_context(void)
> =A0 =A0 =A0 =A0if (cpu_is_omap24xx())
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>
> + =A0 =A0 =A0 if (!dispc.base)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> =A0 =A0 =A0 =A0SR(SYSCONFIG);
> =A0 =A0 =A0 =A0SR(IRQENABLE);
> =A0 =A0 =A0 =A0SR(CONTROL);
> --
> 1.7.0.2
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
