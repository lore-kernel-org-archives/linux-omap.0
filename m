From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] arm: omap2: mux: fix debugfs file permission
Date: Mon, 4 Mar 2013 11:18:31 -0800
Message-ID: <20130304191830.GV11806@atomide.com>
References: <1361269464-20263-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:23942 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757555Ab3CDTSd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Mar 2013 14:18:33 -0500
Content-Disposition: inline
In-Reply-To: <1361269464-20263-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

* Felipe Balbi <balbi@ti.com> [130219 02:28]:
> OMAP's debugfs interface creates one file
> for each signal in the mux table, such file
> provides a read method but didn't provide
> read permission. Fix it.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>

Heh indeed, although read still seems to work without it.
Applying into omap-for-v3.9/fixes.

Regards,

Tony

> ---
>  arch/arm/mach-omap2/mux.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
> index 6a217c9..03fa4f4 100644
> --- a/arch/arm/mach-omap2/mux.c
> +++ b/arch/arm/mach-omap2/mux.c
> @@ -739,8 +739,9 @@ static void __init omap_mux_dbg_create_entry(
>  	list_for_each_entry(e, &partition->muxmodes, node) {
>  		struct omap_mux *m = &e->mux;
>  
> -		(void)debugfs_create_file(m->muxnames[0], S_IWUSR, mux_dbg_dir,
> -					  m, &omap_mux_dbg_signal_fops);
> +		(void)debugfs_create_file(m->muxnames[0], S_IWUSR | S_IRUGO,
> +					  mux_dbg_dir, m,
> +					  &omap_mux_dbg_signal_fops);
>  	}
>  }
>  
> -- 
> 1.8.1.rc1.5.g7e0651a
> 
