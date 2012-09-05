From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH 13/17] Revert "OMAPDSS: APPLY: add fifo-merge support"
Date: Wed, 5 Sep 2012 19:13:41 +0530
Message-ID: <5047570D.1030601@ti.com>
References: <1346833555-31258-1-git-send-email-tomi.valkeinen@ti.com> <1346833555-31258-14-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55789 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751316Ab2IENn3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Sep 2012 09:43:29 -0400
In-Reply-To: <1346833555-31258-14-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Wednesday 05 September 2012 01:55 PM, Tomi Valkeinen wrote:
> This reverts commit 1d71f42b35ed66d90a9a39bc515bb16cfe2d4a46.
>
> Adding fifo merge feature as an omapdss internal configuration was a
> mistake. We cannot hide from the users of omapdss the complexities of
> fifo merge.
>
> This commit removes the fifo merge support, which luckily is easily done
> as it was handled totally inside apply.c.
>
> The plan is to try fifo merge again later when it is more clear how the
> hardware acts in various situations, and how the omapdrm wants to use
> fifo merge.

Nitpick: This isn't an exact revert right? Maybe we should mention that, 
so that if someone tries to apply the old patch, it doesn't fail.

>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>   drivers/video/omap2/dss/apply.c |  154 ++-------------------------------------
>   1 file changed, 8 insertions(+), 146 deletions(-)
>
> diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
> index 1b49019..02943a5 100644
> --- a/drivers/video/omap2/dss/apply.c
> +++ b/drivers/video/omap2/dss/apply.c
> @@ -993,11 +993,11 @@ static void dss_apply_fifo_merge(bool use_fifo_merge)
>   	dss_data.fifo_merge_dirty = true;
>   }
>
> -static void dss_ovl_setup_fifo(struct omap_overlay *ovl,
> -		bool use_fifo_merge)
> +static void dss_ovl_setup_fifo(struct omap_overlay *ovl)
>   {
>   	struct ovl_priv_data *op = get_ovl_priv(ovl);
>   	u32 fifo_low, fifo_high;
> +	bool use_fifo_merge = false;

This looks like the line which wasn't removed in the original commit.

Archit

